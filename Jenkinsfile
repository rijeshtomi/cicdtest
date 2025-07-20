node()
{
properties([
   parameters([
    string(name: 'NOT_BUILD', defaultValue: 'SUCCESS')
    ])
   ])
  stage("Stage1")
  {
      // something went wrong, but it isn't catastrophic...
	  currentBuild.result = "${NOT_BUILD}"
  }
}
