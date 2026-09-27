pipeline {

    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '992382458064'
        ECR_REPO = 'lab1tests'
        EKS_CLUSTER = 'lab1'

        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        IMAGE_TAG = "${BUILD_NUMBER}"
        IMAGE_URI = "${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}"
    }

    stages {

        stage('Checkout Source') {
            steps {
                checkout scm
            }
        }

        stage('Build NGINX Image') {
            steps {
                sh '''
                    docker build -t ${ECR_REPO}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Login to Amazon ECR') {
            steps {
                sh '''
                    aws ecr get-login-password \
                      --region ${AWS_REGION} | \
                    docker login \
                      --username AWS \
                      --password-stdin ${ECR_REGISTRY}
                '''
            }
        }

        stage('Push NGINX Image to ECR') {
            steps {
                sh '''
                    docker tag \
                      ${ECR_REPO}:${IMAGE_TAG} \
                      ${IMAGE_URI}

                    docker push ${IMAGE_URI}
                '''
            }
        }

        stage('Deploy NGINX to EKS') {
            steps {
                sh '''
                    aws eks update-kubeconfig \
                      --region ${AWS_REGION} \
                      --name ${EKS_CLUSTER}

                    sed "s|IMAGE_URI|${IMAGE_URI}|g" deployment.yaml | \
                    kubectl apply -f -

                    kubectl apply -f service.yaml
                '''
            }
        }

        stage('Verify NGINX Deployment') {
            steps {
                sh '''
                    kubectl rollout status deployment/nginx-deployment

                    kubectl get deployment nginx-deployment
                    kubectl get pods -l app=nginx
                    kubectl get service nginx-service
                '''
            }
        }
    }
}
