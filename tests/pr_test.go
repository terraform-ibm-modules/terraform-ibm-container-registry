// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/files"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

const solutionFCDir = "solutions/fully-configurable"
const resourceGroup = "geretain-test-icr"

// ICR Plan is non revertible once upgraded to standard
var validRegions = []string{
	"br-sao",
	"us-south",
	"ap-north",
}

func setupFullyConfigurableOptions(t *testing.T, prefix string) *testschematic.TestSchematicOptions {

	var region = validRegions[common.CryptoIntn(len(validRegions))]

	excludeDirs := []string{
		// ".terraform",
		// ".docs",
		// ".github",
		// ".git",
		// ".idea",
		// "common-dev-assets",
		// "examples",
		// "tests",
		// "reference-architectures",
	}
	includeFiletypes := []string{
		// ".tf",
		// ".yaml",
		// ".py",
		// ".tpl",
		".sh",
	}

	tarIncludePatterns, recurseErr := testhelper.GetTarIncludeDirsWithDefaults("..", excludeDirs, includeFiletypes)

	// if error producing tar patterns (very unexpected) fail test immediately
	require.NoError(t, recurseErr, "Schematic Test had unexpected error traversing directory tree")
	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing:                t,
		TarIncludePatterns:     tarIncludePatterns,
		TemplateFolder:         solutionFCDir,
		Prefix:                 prefix,
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 60,
	})

	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "existing_resource_group_name", Value: resourceGroup, DataType: "string"},
		{Name: "namespace_region", Value: region, DataType: "string"},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "upgrade_to_standard_plan", Value: true, DataType: "bool"},
		{Name: "storage_megabytes", Value: 499, DataType: "number"},
		{Name: "traffic_megabytes", Value: 5*1024 - 1, DataType: "number"},
	}
	return options
}

func TestRunFCSolutionSchematics(t *testing.T) {
	t.Parallel()

	options := setupFullyConfigurableOptions(t, "icr-fc")
	err := options.RunSchematicTest()
	assert.NoError(t, err, "Schematics test should complete without errors")
}

// Upgrade test for "Fully configurable ICR" solution in schematics
func TestRunFCSolutionSchematicsUpgrade(t *testing.T) {
	t.Parallel()

	options := setupFullyConfigurableOptions(t, "icr-fc-upg")
	options.CheckApplyResultForUpgrade = true
	err := options.RunSchematicUpgradeTest()
	if !options.UpgradeTestSkipped {
		assert.NoError(t, err, "Upgrade test should complete without errors")
	}
}

func TestRunExistingResourcesExample(t *testing.T) {
	t.Parallel()

	// ------------------------------------------------------------------------------------
	// Provision icr namespace
	// ------------------------------------------------------------------------------------

	prefix := fmt.Sprintf("cr-%s", strings.ToLower(random.UniqueId()))
	realTerraformDir := "./existing-resources"
	tempTerraformDir, _ := files.CopyTerraformFolderToTemp(realTerraformDir, fmt.Sprintf(prefix+"-%s", strings.ToLower(random.UniqueId())))

	var region = validRegions[common.CryptoIntn(len(validRegions))]

	// Verify ibmcloud_api_key variable is set
	checkVariable := "TF_VAR_ibmcloud_api_key"
	val, present := os.LookupEnv(checkVariable)
	require.True(t, present, checkVariable+" environment variable not set")
	require.NotEqual(t, "", val, checkVariable+" environment variable is empty")

	logger.Log(t, "Tempdir: ", tempTerraformDir)
	existingTerraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: tempTerraformDir,
		Vars: map[string]interface{}{
			"prefix":           prefix,
			"namespace_region": region,
		},
		// Set Upgrade to true to ensure latest version of providers and modules are used by terratest.
		// This is the same as setting the -upgrade=true flag with terraform.
		Upgrade: true,
	})

	terraform.WorkspaceSelectOrNew(t, existingTerraformOptions, prefix)
	_, existErr := terraform.InitAndApplyE(t, existingTerraformOptions)
	if existErr != nil {
		assert.True(t, existErr == nil, "Init and Apply of temp existing resource failed")
	} else {
		options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
			Testing:       t,
			TerraformDir:  solutionFCDir,
			Prefix:        "upg-icr",
			Region:        region,
			ResourceGroup: resourceGroup,
		})
		options.TerraformVars = map[string]interface{}{
			"existing_namespace_name":      terraform.Output(t, existingTerraformOptions, "namespace_name"),
			"existing_resource_group_name": terraform.Output(t, existingTerraformOptions, "resource_group_name"),
			"namespace_region":             region,
			"prefix":                       options.Prefix,
			"upgrade_to_standard_plan":     true,
			"storage_megabytes":            499,
			"traffic_megabytes":            5*1024 - 1,
			"provider_visibility":          "public",
		}

		output, err := options.RunTestConsistency()
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}

	// Check if "DO_NOT_DESTROY_ON_FAILURE" is set
	envVal, _ := os.LookupEnv("DO_NOT_DESTROY_ON_FAILURE")
	// Destroy the temporary existing resources if required
	if t.Failed() && strings.ToLower(envVal) == "true" {
		fmt.Println("Terratest failed. Debug the test and delete resources manually.")
	} else {
		logger.Log(t, "START: Destroy (existing resources)")
		terraform.Destroy(t, existingTerraformOptions)
		terraform.WorkspaceDelete(t, existingTerraformOptions, prefix)
		logger.Log(t, "END: Destroy (existing resources)")
	}
}
