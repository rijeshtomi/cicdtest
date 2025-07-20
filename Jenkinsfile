node()
{
  parameters
  {
      string(name: 'UNSTABLE', defaultValue: 'UNSTABLE')
  }
  stage("Stage1")
  {
      // something went wrong, but it isn't catastrophic...
	  currentBuild.result = "${UNSTABLE}"
  }
}
