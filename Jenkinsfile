pipeline {

  environment {
    PROJECT = "iti-project-281015"
    APP_NAME = "iti-wp"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-d"
    IMAGE_TAG = "wordpress"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'wordpress'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  containers:
  - name: golang
    image: golang:1.10
    command:
    - cat
    tty: true
  - name: gcloud
    image: gcr.io/cloud-builders/gcloud
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
"""
}
  }
  stages {
    stage('Deploy wp') {
      // Canary branch
      
      steps {
        container('kubectl') {
          // Change deployed image in canary to the one we just built
          sh("sed -i.bak 's#wordpress:5.4#${IMAGE_TAG}#' Jenkins/k8s/wordpress/wordpress-deployment-1.yaml")
          sh("sed -i.bak 's#wordpress:5.4#${IMAGE_TAG}#' Jenkins/k8s/wordpress/wordpress-deployment-2.yaml")
          step([$class: 'KubernetesEngineBuilder', namespace:'default', projectId: env.PROJECT, clusterName: env.CLUSTER, zone: env.CLUSTER_ZONE, manifestPattern: 'Jenkins/k8s/wordpress/wordpress-deployment-1.yaml', credentialsId: env.JENKINS_CRED, verifyDeployments: true])
          step([$class: 'KubernetesEngineBuilder', namespace:'default', projectId: env.PROJECT, clusterName: env.CLUSTER, zone: env.CLUSTER_ZONE, manifestPattern: 'Jenkins/k8s/wordpress/wordpress-deployment-2.yaml', credentialsId: env.JENKINS_CRED, verifyDeployments: true])
	      step([$class: 'KubernetesEngineBuilder', namespace:'default', projectId: env.PROJECT, clusterName: env.CLUSTER, zone: env.CLUSTER_ZONE, manifestPattern: 'Jenkins/k8s/mysql/mysql-deployment.yaml', credentialsId: env.JENKINS_CRED, verifyDeployments: true])
          step([$class: 'KubernetesEngineBuilder', namespace:'default', projectId: env.PROJECT, clusterName: env.CLUSTER, zone: env.CLUSTER_ZONE, manifestPattern: 'Jenkins/k8s/services/svc.yaml', credentialsId: env.JENKINS_CRED, verifyDeployments: false])
          }
      }
    }  
    }}