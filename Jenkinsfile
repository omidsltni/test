node {

    def dockerImage
    def commitHash
    def projectNamespace = 'vinama'

    def registry = 'https://registry.ghaf.cloud'
    def clusterUrl = 'https://cluster.afra.ghaf.cloud:6443'
    def backReg = "registry.ghaf.cloud/${projectNamespace}/back"
    def frontReg = "registry.ghaf.cloud/${projectNamespace}/front"

    def backDockerContext = './back-mono'
    def backDockerPath = './back-mono/build/Dockerfile'
    def frontDockerContext = './new-front'
    def frontDockerPath = './new-front/Dockerfile'

    def backContainerName = 'back'
    def frontContainerName = "${projectNamespace}-app"

    def backDeploymentName =  'back'
    def frontDeploymentName = 'front'

    
    stage('Clone repository')
        {
          commitHash = checkout(scm).GIT_COMMIT
        }
    stage('Build image')
        {
          sh "echo 'mahdi1376' | docker login -u malivix --password-stdin docker.artifactory.glss.ir"
          dockerImage = docker.build(backReg + ":latest", "-f ${backDockerPath} ${backDockerContext}")
        }
 
    stage('Push image')
      {
        docker.withRegistry( registry, 'registry' )
          {
            dockerImage.push()
            dockerImage.push(commitHash)
          }
      }

    stage('Deploying Back')
      {
        withKubeConfig([credentialsId: 'kubeConfig', serverUrl: clusterUrl])
        {
          sh "kubectl set image -n ${projectNamespace} deployment/${backDeploymentName} ${backContainerName}=${backReg}:${commitHash}"
        }
      }

    stage('Build front image')
      {
        dockerImage = docker.build(frontReg + ":latest", "-f ${frontDockerPath} ${frontDockerContext}")
      }
    stage('Push front image')
      {
       docker.withRegistry( registry, 'registry' )
        {
          dockerImage.push()
          dockerImage.push(commitHash)
        }
      }
    stage('Deploying Back')
    {
      withKubeConfig([credentialsId: 'kubeConfig',serverUrl: clusterUrl])
        {
          sh "kubectl set image -n ${projectNamespace} deployment/${frontDeploymentName} ${frontContainerName}=${frontReg}:${commitHash}"
        }
    }
}
