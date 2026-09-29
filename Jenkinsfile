pipeline {

    agent any

    environment {
<<<<<<< HEAD

        AWS_REGION = 'ap-south-1'

        ECR_REPO = 'lab1test'

        EKS_CLUSTER = 'Lab1_Test'

        AWS_ACCOUNT_ID = '992382458064'

        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

        IMAGE_TAG = "${BUILD_NUMBER}"

=======
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '992382458064'
        ECR_REPO = 'lab1tests'
        EKS_CLUSTER = 'lab1'

        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_TAG = "${BUILD_NUMBER}"
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
        IMAGE_URI = "${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {

<<<<<<< HEAD
        stage('Checkout') {
=======
        stage('Checkout Source') {
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
            steps {
                checkout scm
            }
        }

<<<<<<< HEAD
        stage('Verify Tools') {
            steps {
                sh '''
                    echo "===== TOOL VERSION ====="

                    git --version
                    docker --version
                    aws --version
                    kubectl version --client

                    echo "===== CONFIGURATION ====="

                    echo "AWS Region     : ${AWS_REGION}"
                    echo "ECR Repository : ${ECR_REPO}"
                    echo "EKS Cluster    : ${EKS_CLUSTER}"
                    echo "Image URI      : ${IMAGE_URI}"
=======
        stage('Build NGINX Image') {
            steps {
                sh '''
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
                '''
            }
        }

<<<<<<< HEAD
        stage('AWS Identity') {
            steps {
                sh '''
                    echo "===== AWS IDENTITY ====="

                    aws sts get-caller-identity
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "===== BUILD DOCKER IMAGE ====="

                    docker build \
                        -t ${ECR_REPO}:${IMAGE_TAG} .

                    docker images | grep ${ECR_REPO}
                '''
            }
        }

        stage('Login to ECR') {
            steps {
                sh '''
                    echo "===== LOGIN TO ECR ====="

                    aws ecr get-login-password \
                        --region ${AWS_REGION} | \
                    docker login \
                        --username AWS \
                        --password-stdin ${ECR_REGISTRY}
=======
        stage('Login to Amazon ECR') {
            steps {
                sh '''
                    aws ecr get-login-password \
                      --region ${AWS_REGION} | \
                    docker login \
                      --username AWS \
                      --password-stdin ${ECR_REGISTRY}
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
                '''
            }
        }

<<<<<<< HEAD
        stage('Push Image to ECR') {
            steps {
                sh '''
                    echo "===== TAG IMAGE ====="

                    docker tag \
                        ${ECR_REPO}:${IMAGE_TAG} \
                        ${IMAGE_URI}

                    echo "===== PUSH IMAGE ====="
=======
        stage('Push NGINX Image to ECR') {
            steps {
                sh '''
                    docker tag \
                      ${ECR_REPO}:${IMAGE_TAG} \
                      ${IMAGE_URI}
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe

                    docker push ${IMAGE_URI}
                '''
            }
        }

<<<<<<< HEAD
        stage('Configure EKS') {
            steps {
                sh '''
                    echo "===== UPDATE EKS KUBECONFIG ====="

                    aws eks update-kubeconfig \
                        --region ${AWS_REGION} \
                        --name ${EKS_CLUSTER}

                    echo "===== CHECK EKS CONNECTION ====="

                    kubectl cluster-info
                '''
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    echo "===== DEPLOY APPLICATION ====="

                    sed "s|IMAGE_URI|${IMAGE_URI}|g" \
                        deployment.yaml | \
=======
        stage('Deploy NGINX to EKS') {
            steps {
                sh '''
                    aws eks update-kubeconfig \
                      --region ${AWS_REGION} \
                      --name ${EKS_CLUSTER}

                    sed "s|IMAGE_URI|${IMAGE_URI}|g" deployment.yaml | \
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
                    kubectl apply -f -

                    kubectl apply -f service.yaml
                '''
            }
        }

<<<<<<< HEAD
        stage('Verify Deployment') {
            steps {
                sh '''
                    echo "===== WAIT FOR ROLLOUT ====="

                    kubectl rollout status \
                        deployment/jenkins-nginx \
                        --timeout=180s

                    echo "===== DEPLOYMENT ====="

                    kubectl get deployment jenkins-nginx

                    echo "===== PODS ====="

                    kubectl get pods \
                        -l app=jenkins-nginx \
                        -o wide

                    echo "===== SERVICE ====="

                    kubectl get service jenkins-nginx-service
=======
        stage('Verify NGINX Deployment') {
            steps {
                sh '''
                    kubectl rollout status deployment/nginx-deployment

                    kubectl get deployment nginx-deployment
                    kubectl get pods -l app=nginx
                    kubectl get service nginx-service
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
                '''
            }
        }
    }
<<<<<<< HEAD

    post {

        success {
            echo '''
            ========================================
            Jenkins EKS Deployment SUCCESSFUL
            ========================================
            '''
            echo "Application : lab1testdemo"
            echo "ECR Repo    : ${ECR_REPO}"
            echo "EKS Cluster : ${EKS_CLUSTER}"
            echo "AWS Region  : ${AWS_REGION}"
            echo "Image       : ${IMAGE_URI}"
        }

        failure {
            echo '''
            ========================================
            Jenkins EKS Deployment FAILED
            ========================================
            Check Jenkins Console Output.
            '''
        }
    }
=======
>>>>>>> e1ec15059a9572f9ab5a08683b7b4d8833a8ccfe
}
