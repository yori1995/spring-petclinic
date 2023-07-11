pipeline {
  agent any
  tools {
    maven 'M3'
    jdk 'JDK11'
  }
  environment {
    AWS_CREDNETIALS_NAME = "AWSCredentials"
    REGION = "ap-northeast-2"
    DOCKER_IMAGE_NAME = "aws07-spring-pet-clinic"
    DOCKER_TAG = "1.0"
    ECR_REPOSITORY = "257307634175.dkr.ecr.ap-northeast-2.amazonaws.com"
    ECR_DOCKER_IAMGE = "${ECR_REPOSITORY}/${DOCKER_IMAGE_NAME}"
    ECR_DOCKER_TAG = "${DOCKER_TAG}"
  }
  stages{
    stage('Git Clone') {
      steps{
        git url: 'https://github.com/yori1995/spring-petclinic.git', branch: 'efficient-webjars', credentialsId: 'gitCredentials'
      }
    }
    stage('mvn build') {
      steps{
        sh 'mvn -Dmaven.test.failure.ignore=true install'
      }
      post{
        success{
          junit '**/target/surefire-reports/TEST-*.xml'
        }
      }
    }
    
    stage('Docker Image Build') {
      steps {
        dir("${env.WORKSPACE}") {
          sh 'docker build -t ${ECR_REPOSITORY}/${DOCKER_IMAGE_NAME}.'
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script{
          sh 'rm -f ~/.dockercfg ~/.docker/config.json || true'

          docker.writeRegistry("https://${ECR_REPOSITORY}", "ecr:${RESION}:${AWS_CREDNETIALS_NAME}") {
            docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_TAG}").push()
          }
        }
      }
    }
  }
}
