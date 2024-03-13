node {
    def dockerImage
    def commitHash
    def projectNamespace = 'vinama'
    def registry = 'docker.artifactory.glss.ir'
    def backReg = "docker.artifactory.glss.ir/${projectNamespace}/back"
    def frontReg = "docker.artifactory.glss.ir/${projectNamespace}/front"
    def backDockerContext = './back-mono'
    def backDockerPath = './back-mono/build/Dockerfile'
    def frontDockerContext = './new-front'
    def frontDockerPath = './new-front/Dockerfile'
    
    stage('Clone repository')
        {
          commitHash = checkout(scm).GIT_COMMIT
        }
    stage('Docker Login'){
      sh "echo 'Pass=omid1381' | docker login -u soltani --password-stdin docker.artifactory.glss.ir"
    }
    stage('Build Back image')
        {
          dir(${backDockerPath}){
            sh "docker build ${backReg}:${commitHash} ."
          }
        }

    stage('Push Back image')
      {
        sh "docker push ${backReg}:${commitHash}"
      }
    
    stage('Build Front image')
      {
        dir(${frontDockerPath}){
          sh "docker build ${frontReg}:${commitHash} -f ${backDockerPath}"
        }
      }
    stage('Push Front image')
      {
        sh "docker push ${backReg}:${commitHash}"
      }
}
