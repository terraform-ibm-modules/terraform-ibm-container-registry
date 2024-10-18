// Tests in this file are run in the PR pipeline and the continuous testing pipeline
package test

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const solutionStandardDir = "solutions/standard"
const resourceGroup = "geretain-test-icr"
const region = "br-sao"

func setupOptions(t *testing.T, prefix string, dir string) *testhelper.TestOptions {
	return testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:      t,
		TerraformDir: solutionStandardDir,
		Prefix:       prefix,
		// ResourceGroup: resourceGroup,
		Region: region,
		TerraformVars: map[string]interface{}{
			"use_existing_resource_group": true,
			"resource_group_name":         resourceGroup,
			"name":                        fmt.Sprintf("%s-namespace", prefix),
			"container_registry_endpoint": "br.icr.io",
			"upgrade_to_standard_plan":    true,
			"update_traffic_quota":        true,
			"update_storage_quota":        true,
			"storage_megabytes":           499,
			"traffic_megabytes":           5*1024 - 1,
		},
	})
}

func TestRunStandardSolution(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "icr-standard", solutionStandardDir)
	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunUpgradeExample(t *testing.T) {
	t.Parallel()

	options := setupOptions(t, "icr-standard-upg", solutionStandardDir)
	output, err := options.RunTestUpgrade()
	if !options.UpgradeTestSkipped {
		assert.Nil(t, err, "This should not have errored")
		assert.NotNil(t, output, "Expected some output")
	}
}
