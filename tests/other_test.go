// Tests in this file are NOT run in the PR pipeline. They are run in the continuous testing pipeline along with the ones in pr_test.go
package test

import (
	"math/rand"
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/terraform-ibm-modules/ibmcloud-terratest-wrapper/testhelper"
)

const completeDir = "examples/complete"

func TestRunCompleteExample(t *testing.T) {
	t.Parallel()

	var region = validRegions[rand.Intn(len(validRegions))]

	options := testhelper.TestOptionsDefault(&testhelper.TestOptions{
		Testing:       t,
		TerraformDir:  completeDir,
		Prefix:        "complete-icr",
		ResourceGroup: resourceGroup,
	})
	options.TerraformVars = map[string]interface{}{
		"resource_group":   resourceGroup,
		"namespace_region": region,
		"retain_untagged":  true,
		"prefix":           options.Prefix,
	}

	output, err := options.RunTestConsistency()
	assert.Nil(t, err, "This should not have errored")
	assert.NotNil(t, output, "Expected some output")
}
