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
    stage('Build Back image')
        {
          dockerImage = docker.build(backReg + "${commitHash}:latest", "-f ${backDockerPath} ${backDockerContext}")
        }
 
    stage('Push Back image')
      {
        docker.withRegistry( registry, 'registry' )
          {
            dockerImage.push()
            dockerImage.push(commitHash)
          }
      }
    
    stage('Build Front image')
      {
        dockerImage = docker.build(frontReg + "${commitHash}:latest", "-f ${frontDockerPath} ${frontDockerContext}")
      }
    stage('Push Front image')
      {
       docker.withRegistry( registry, 'registry' )
        {
          dockerImage.push()
          dockerImage.push(commitHash)
        }
      }
    
}
