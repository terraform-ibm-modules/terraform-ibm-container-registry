// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const completeDir = "examples/complete"
const existingICRNamespaceName = "geretain-br-icr"

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  completeDir,
		Prefix:        "icr",
		ResourceGroup: resourceGroup,
		TerraformVars: map[string]interface{}{
			"resource_group_name":         resourceGroup,
			"use_existing_resource_group": true,
			"namespace_region":            "br-sao",
			"namespace_name":              "icr-prefix",
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}

func TestRunExistingNamespaceExample(t *testing.T) {
	t.Parallel()

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  completeDir,
		Prefix:        "icr-existing",
		ResourceGroup: resourceGroup,
		TerraformVars: map[string]interface{}{
			"use_existing_resource_group": true,
			"resource_group_name":         resourceGroup,
			"namespace_region":            "br-sao",
			"namespace_name":              existingICRNamespaceName,
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
