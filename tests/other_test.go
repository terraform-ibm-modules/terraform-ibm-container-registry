// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/common"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testschematic"
)

const completeDir = "examples/complete"

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()

	var region = validRegions[common.CryptoIntn(len(validRegions))]

	options := testschematic.TestSchematicOptionsDefault(&testschematic.TestSchematicOptions{
		Testing: t,
		Prefix:  "complete-icr",
		TarIncludePatterns: []string{
			"*.tf",
			"modules/*/*.tf",
			completeDir + "/*.tf",
		},

		ResourceGroup:          resourceGroup,
		TemplateFolder:         completeDir,
		Tags:                   []string{"test-schematic"},
		DeleteWorkspaceOnFail:  false,
		WaitJobCompleteMinutes: 60,
	})
	options.TerraformVars = []testschematic.TestSchematicTerraformVar{
		{Name: "ibmcloud_api_key", Value: options.RequiredEnvironmentVars["TF_VAR_ibmcloud_api_key"], DataType: "string", Secure: true},
		{Name: "namespace_region", Value: region, DataType: "string"},
		{Name: "prefix", Value: options.Prefix, DataType: "string"},
		{Name: "resource_group", Value: resourceGroup, DataType: "string"},
		{Name: "retain_untagged", Value: true, DataType: "bool"},
	}

	err := options.RunSchematicTest()
	assert.Nil(t, err, "This should not have errored")
}
