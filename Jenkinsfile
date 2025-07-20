node()
{
  properties([
    parameters([
      string(name: 'ERROR', defaultValue: 'SUCCESS')
    ])
   ])
  stage("Stage1")
  {
      // something went wrong, but it isn't catastrophic...
	  currentBuild.result = "${ERROR}"
  }
}
