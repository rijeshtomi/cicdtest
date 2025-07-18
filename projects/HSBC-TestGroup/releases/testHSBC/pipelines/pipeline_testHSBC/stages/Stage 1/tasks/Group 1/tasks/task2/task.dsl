
task 'task2', {
  advancedMode = '0'
  allowOutOfOrderRun = '0'
  alwaysRun = '0'
  enabled = '1'
  errorHandling = 'stopOnError'
  groupName = 'Group 1'
  insertRollingDeployManualStep = '0'
  projectName = 'HSBC-TestGroup'
  skippable = '0'
  subErrorHandling = 'continueOnError'
  subpipeline = 'testPipeline'
  subproject = 'testProj_Procedures'
  taskType = 'PIPELINE'
  triggerType = 'async'
  useApproverAcl = '0'
  waitForPlannedStartDate = '0'
}
