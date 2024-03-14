node {
    def dockerImage
    def commitHash
    def projectNamespace = 'vinama'
    def registry = 'docker.artifactory.glss.ir'
    def backReg = "docker.artifactory.glss.ir/${projectNamespace}/back"
    def frontReg = "docker.artifactory.glss.ir/${projectNamespace}/front"
    def backDockerContext = './back-mono'
    def frontDockerContext = './new-front'
    def frontDockerPath = './new-front/Dockerfile'
    
    stage('Clone repository')
        {
          commitHash = checkout(scm).GIT_COMMIT
        }
    stage('Docker Login'){
      withCredentials([usernamePassword(credentialsId: 'artifactory', usernameVariable: 'U', passwordVariable: 'P')]) {
        sh "echo $P | docker login -u $U --password-stdin docker.artifactory.glss.ir"
        }
    }
    stage('Build Back image')
        {
          dir('back-mono/build/Dockerfile'){
            sh "docker build ${backReg}:${commitHash} ."
          }
        }

    stage('Push Back image')
      {
        sh "docker push ${backReg}:${commitHash}"
      }
    
    stage('Build Front image')
      {
        dir('new-front/Dockerfile'){
          sh "docker build ${frontReg}:${commitHash} ."
        }
      }
    stage('Push Front image')
      {
        sh "docker push ${backReg}:${commitHash}"
      }
}
