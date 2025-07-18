project 'Default Copy', {
  tracked = '1'

  pipeline 'p1', {

    formalParameter 'ec_stagesToRun', {
      expansionDeferred = '1'
    }

    stage 'Stage 1', {
      colorCode = '#289ce1'
      pipelineName = 'p1'

      gate 'PRE'

      gate 'POST'

      task 'r1', {
        subErrorHandling = 'continueOnError'
        subproject = 'Default Copy'
        subreleaseSuffix = 'qq'
        taskType = 'RELEASE'
        triggerType = 'async'
      }

      task 'r2', {
        actualParameter = [
          'snapshotName': 'Snap_$[/myPipeline/name]_$[/myPipelineStageRuntime/flowRuntimeId]',
        ]
        subErrorHandling = 'continueOnError'
        subproject = 'Default Copy'
        subreleasePipeline = 'ClumsyBird_v.2.0'
        subreleasePipelineProject = 'Web Games Testing'
        subreleaseSuffix = 'qe'
        taskType = 'RELEASE'
        triggerType = 'async'
      }
    }
  }

  release 'rr', {
    plannedEndDate = '2022-06-29'
    plannedStartDate = '2022-06-15'

    pipeline 'p1', {
      releaseName = 'rr'
      templatePipelineName = 'p1'
      templatePipelineProjectName = 'Default Copy'

      formalParameter 'ec_stagesToRun', {
        expansionDeferred = '1'
      }

      stage 'Stage 1', {
        colorCode = '#289ce1'
        pipelineName = 'p1'

        gate 'PRE'

        gate 'POST'

        task 'r1', {
          subErrorHandling = 'continueOnError'
          subproject = 'Default Copy'
          subrelease = 'rr_qq'
          taskType = 'RELEASE'
          triggerType = 'async'
        }

        task 'r2', {
          actualParameter = [
            'snapshotName': 'Snap_$[/myPipeline/name]_$[/myPipelineStageRuntime/flowRuntimeId]',
          ]
          subErrorHandling = 'continueOnError'
          subproject = 'Default Copy'
          subrelease = 'rr_qe'
          taskType = 'RELEASE'
          triggerType = 'async'
        }
      }
    }

    subrelease {
      subreleaseName = 'rr_qq'
      subreleaseProject = 'Default Copy'
    }

    subrelease {
      subreleaseName = 'rr_qe'
      subreleaseProject = 'Default Copy'
    }
  }

  release 'rr_qe', {

    pipeline 'ClumsyBird_v.2.0', {
      releaseName = 'rr_qe'
      templatePipelineName = 'ClumsyBird_v.2.0'
      templatePipelineProjectName = 'Web Games Testing'

      formalParameter 'snapshotName', defaultValue: 'Snap_$[/myPipeline/name]_$[/myPipelineStageRuntime/flowRuntimeId]', {
        expansionDeferred = '1'
        label = 'Snapshot Name'
        orderIndex = '1'
        required = '1'
        type = 'entry'
      }

      formalParameter 'ec_stagesToRun', {
        expansionDeferred = '1'
      }

      stage 'DEV', {
        pipelineName = 'ClumsyBird_v.2.0'

        gate 'PRE'

        gate 'POST'

        task 'Deploy App on DEV envs', {
          actualParameter = [
            'ec_smartDeployOption': '1',
            'ec_stageArtifacts': '0',
            'server_status': 'success',
            'setup_db_app_param': 'success',
            'snap_name': '$[/myPipelineRuntime/snapshotName]',
            'source_code_app_param': 'success',
          ]
          environmentName = 'ClumsyBird'
          environmentProjectName = 'DEV Environment'
          rollingDeployEnabled = '0'
          subapplication = 'Clumsy Bird v2.0'
          subprocess = 'Deploy'
          subproject = 'Applications Lib'
          taskProcessType = 'APPLICATION'
          taskType = 'PROCESS'
        }

        task 'Set Dev Snapshot name', {
          actualParameter = [
            'propertyPath': '/myPipelineRuntime/snapshotName_dev',
            'propertyValue': '$[/myPipelineRuntime/snapshotName]',
          ]
          subprocedure = 'Set new property'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Display snapshot name used for tests', {
          actualParameter = [
            'propName': 'DEV_snapshotName',
            'value': '''<html>
<b><u><font color=#0088cc>
$[/myPipelineRuntime/snapshotName_dev]
</font></u></b></html>''',
          ]
          subprocedure = 'Set Summary'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Run UNIT Tests', {
          subprocedure = 'Run UNIT tests'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }
      }

      stage 'QA', {
        pipelineName = 'ClumsyBird_v.2.0'

        gate 'PRE'

        gate 'POST'

        task 'Deploy App on QA envs', {
          actualParameter = [
            'ec_smartDeployOption': '1',
            'ec_stageArtifacts': '0',
            'server_status': 'success',
            'setup_db_app_param': 'success',
            'snap_name': '$[/myPipelineRuntime/snapshotName]',
            'source_code_app_param': 'success',
          ]
          environmentName = 'ClumsyBird'
          environmentProjectName = 'QA Environment'
          rollingDeployEnabled = '0'
          subapplication = 'Clumsy Bird v2.0'
          subprocess = 'Deploy'
          subproject = 'Applications Lib'
          taskProcessType = 'APPLICATION'
          taskType = 'PROCESS'
        }

        task 'Create property with Tested Snapshot name', {
          actualParameter = [
            'propertyPath': '/myPipelineRuntime/snapshotName_qa',
            'propertyValue': '$[/myPipelineRuntime/snapshotName]',
          ]
          subprocedure = 'Set new property'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task ' Display snapshot name used for tests', {
          actualParameter = [
            'propName': 'QA_snapshotName',
            'value': '''<html>
<b><u><font color=#0088cc>
$[/myPipelineRuntime/snapshotName_qa]
</font></u></b></html>''',
          ]
          subprocedure = 'Set Summary'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Run Selenium tests', {
          subprocedure = 'Run SELENIUM tests'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }
      }

      stage 'DEMO', {
        pipelineName = 'ClumsyBird_v.2.0'

        gate 'PRE'

        gate 'POST'

        task 'Deploy Tested App on Env Template', {
          actualParameter = [
            'ec_stageArtifacts': '0',
            'server_status': 'success',
            'setup_db_app_param': 'success',
            'snap_name': '$[/myPipelineRuntime/snapshotName]',
            'source_code_app_param': 'success',
          ]
          advancedMode = '1'
          environmentName = 'ClumsyBird_$[/increment /server/ec_counters/jobCounter]'
          environmentProjectName = 'PROD Environment'
          environmentTemplateName = 'ClumsyBird'
          environmentTemplateProjectName = 'TEMPLATES Environment'
          rollingDeployEnabled = '0'
          snapshotName = '$[/myPipelineRuntime/snapshotName_qa]'
          subapplication = 'Clumsy Bird v2.0'
          subprocess = 'Deploy'
          subproject = 'Applications Lib'
          taskProcessType = 'APPLICATION'
          taskType = 'PROCESS'
        }

        task 'Save Snapshot Name deployed on ENV Template PROD', {
          actualParameter = [
            'propertyPath': '/myPipelineRuntime/snapshotName_prod',
            'propertyValue': '$[/myPipelineRuntime/snapshotName]',
          ]
          subprocedure = 'Set new property'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Clear un-used dev snapshot', {
          actualParameter = [
            'appName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subapplication]',
            'projName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subproject]',
            'snapName': '$[/myPipelineRuntime/snapshotName_dev]',
          ]
          errorHandling = 'continueOnError'
          subprocedure = 'DeleteSnapshot'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Clear un-used qa snapshot', {
          actualParameter = [
            'appName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subapplication]',
            'projName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subproject]',
            'snapName': '$[/myPipelineRuntime/snapshotName_qa]',
          ]
          errorHandling = 'continueOnError'
          subprocedure = 'DeleteSnapshot'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }

        task 'Create Ready-To-Release Snapshot', {
          actualParameter = [
            'ApplicationName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subapplication]',
            'EnvironmentName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/environmentName]',
            'EnvironmentProjectName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/environmentProjectName]',
            'Overwrite': 'true',
            'ProjectName': '$[/myPipelineStageRuntime/flowRuntimeStates[taskName=Deploy Tested App on Env Template]/subproject]',
            'SnapshotName': 'ReadyForRelease_$[/myPipeline/name]_$[/timestamp yyyyMMdd]',
          ]
          subpluginKey = 'EF-Utilities'
          subprocedure = 'Create Snapshot'
          taskType = 'UTILITY'
        }

        task 'Publish demo server', {
          actualParameter = [
            'propName': 'DemoServer',
            'value': '''<html>
<a href=\'http://www.ellison.rocks/clumsy-bird/\'>
http://www.clumsy-bird.com
</a>
</html>''',
          ]
          subprocedure = 'Set Summary'
          subproject = 'Web Games Testing'
          taskType = 'PROCEDURE'
        }
      }

      stage 'PROD', {
        pipelineName = 'ClumsyBird_v.2.0'

        gate 'PRE'

        gate 'POST'

        task 'Deploy on PROD', {
          deployerRunType = 'serial'
          subproject = 'Default Copy'
          taskType = 'DEPLOYER'
        }
      }

      // Custom properties

      property 'Clumsy Bird ', {

        // Custom properties

        property 'ec_counters', {

          // Custom properties
          pipelineCounter = '11'
        }
      }

      property 'ClumsyBird_v.2.0', {

        // Custom properties

        property 'ec_counters', {

          // Custom properties
          pipelineCounter = '22'
        }
      }
    }
  }

  release 'rr_qq', {

    pipeline 'pipeline_rr_qq', {
      releaseName = 'rr_qq'

      formalParameter 'ec_stagesToRun', {
        expansionDeferred = '1'
      }

      stage 'Stage 1', {
        pipelineName = 'pipeline_rr_qq'

        gate 'PRE'

        gate 'POST'
      }
    }
  }
}
