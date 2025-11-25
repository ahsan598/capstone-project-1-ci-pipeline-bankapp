pipeline {
    agent any

    tools {
        jdk 'jdk21'        // Jenkins JDK installation name
        maven 'maven3'     // Jenkins Maven installation name
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'   // Sonar Scanner tool name in Jenkins
        IMAGE_NAME   = 'bankapp'
        IMAGE_REPO   = 'ahsan598/bankapp'  // <--- change if you use different Docker Hub repo
        IMAGE_TAG    = "v${BUILD_NUMBER}"

        APP_GIT_REPO = 'https://github.com/username/app-repo.git'              // <--- your app repo
        CD_GIT_REPO  = 'https://github.com/username/Capstone-Mega-CD-Pipeline.git' // <--- your CD repo
    }

    stages {

        stage('Git Checkout') {
            steps {
                git branch: 'main', url: "${APP_GIT_REPO}"
            }
        }

        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Trivy FS Scan') {
            steps {
                // Filesystem scan: source code, Dockerfile, Terraform, etc.
                sh 'trivy fs --format table -o fs-report.html . || true'
            }
        }

        stage('Code Quality Analysis (SonarQube)') {
            steps {
                withSonarQubeEnv('sonar') {   // 'sonar' = SonarQube server name in Jenkins config
                    sh '''
                        $SCANNER_HOME/bin/sonar-scanner \
                          -Dsonar.projectKey=GCBank \
                          -Dsonar.projectName=GCBank \
                          -Dsonar.java.binaries=target
                    '''
                }
            }
        }

        stage('Quality Gate Check') {
            steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }

        stage('Build & Deploy to Nexus (Maven)') {
            steps {
                // 'Capstone' = Jenkins Maven Global Settings ID (with Nexus repo settings)
                withMaven(globalMavenSettingsConfig: 'Capstone', maven: 'maven3', traceability: true) {
                    sh 'mvn clean deploy -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_REPO}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Trivy Image Scan') {
            steps {
                // Image vulnerability scan; don't fail pipeline for learning (|| true)
                sh "trivy image --format table -o image-report.html ${IMAGE_REPO}:${IMAGE_TAG} || true"
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {  // DockerHub/ECR creds in Jenkins
                        sh "docker push ${IMAGE_REPO}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Update manifests in CD repo') {
            steps {
                script {
                    // Clean workspace so CD repo clone clean mile
                    cleanWs()

                    sh """
                        git clone ${CD_GIT_REPO} cd-repo
                        cd cd-repo

                        # Update image tag inside Kubernetes manifest
                        sed -i 's|${IMAGE_REPO}:.*|${IMAGE_REPO}:${IMAGE_TAG}|' kubernetes/app/Manifest.yaml

                        echo 'Updated image tag in kubernetes/app/Manifest.yaml:'
                        grep '${IMAGE_REPO}' kubernetes/app/Manifest.yaml

                        git config user.name 'Your Name'
                        git config user.email 'you@example.com'
                        git add kubernetes/app/Manifest.yaml
                        git commit -m 'Update image tag to ${IMAGE_TAG}' || echo 'No changes to commit'
                    """

                    withCredentials([usernamePassword(credentialsId: 'github-cred', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                        sh """
                            cd cd-repo
                            git remote set-url origin https://${GIT_USER}:${GIT_PASS}@github.com/username/Capstone-Mega-CD-Pipeline.git
                            git push origin main || echo 'Nothing to push'
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                def jobName        = env.JOB_NAME
                def buildNumber    = env.BUILD_NUMBER
                def pipelineStatus = currentBuild.result ?: 'UNKNOWN'
                def bannerColor    = pipelineStatus.toUpperCase() == 'SUCCESS' ? 'green' : 'red'

                def body = """
                    <html>
                        <body>
                            <div style="border: 4px solid ${bannerColor}; padding: 10px;">
                                <h2>${jobName} - Build #${buildNumber}</h2>
                                <div style="background-color: ${bannerColor}; padding: 10px;">
                                    <h3 style="color: white;">Pipeline Status: ${pipelineStatus.toUpperCase()}</h3>
                                </div>
                                <p>Check the <a href="${env.BUILD_URL}">Console Output</a> for more details.</p>
                            </div>
                        </body>
                    </html>
                """

                emailext(
                    subject: "${jobName} - Build #${buildNumber} - ${pipelineStatus.toUpperCase()}",
                    body: body,
                    to: 'user@gmail.com',   // <--- change
                    from: 'user@gmail.com', // <--- change
                    replyTo: 'user@gmail.com',
                    mimeType: 'text/html',
                    attachmentsPattern: 'fs-report.html,image-report.html'
                )
            }
        }
    }
}
