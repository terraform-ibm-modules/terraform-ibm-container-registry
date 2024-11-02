// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const completeDir = "examples/complete"
const existingICRNamespaceName = "geretain-sao-ns-do-not-delete"

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()
	const prefix = "complete-icr"

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  completeDir,
		Prefix:        prefix,
		ResourceGroup: resourceGroup,
		TerraformVars: map[string]interface{}{
			"resource_group":   resourceGroup,
			"namespace_region": "us-south",
			"retain_untagged":  true,
			"namespace_name":   fmt.Sprintf("%s-ns", prefix),
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
		Prefix:        "existing-icr-ns",
		ResourceGroup: resourceGroup,
		TerraformVars: map[string]interface{}{
			"resource_group":         resourceGroup,
			"use_existing_namespace": true,
			"namespace_region":       "br-sao",
			"retain_untagged":        true,
			"namespace_name":         existingICRNamespaceName,
		},
	})

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
