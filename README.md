
<html><body><h1 style="font-size:50px;color:blue;">WEZVA TECHNOLOGIES (ADAM) | <font style="color:red;"> www.wezva.com | <font style="color:green;"> +91-9739110917 </h1>
<h1> Subscribe to our youtube channel: 
<a href="https://www.youtube.com/c/DevOpsLearnEasy">https://www.youtube.com/c/DevOpsLearnEasy</a> </h1>
</body></html>


# PRODUCTION GRADE DEVSECOPS CICD Pipeline

## Prereq: Create 2 EC2 servers
- [ ] Build server with 15GB storage - t2.mirco
- [ ] Sonarqube server with 4 GB memory - t2.medium

## Step 1: Ensure all the necessary plugins are installed in Jenkins Master
- [ ] Parameterized trigger plugin
- [ ] Gitlab plugin
- [ ] Docker Pipeline
- [ ] Pipeline: AWS steps
- [ ] SonarQube Scanner
- [ ] Quality Gates

## Step 2: Install Docker, Java8, Java11 & Trivy on Build Server
```
$ sudo ./setup.sh
```

## Step 3: Install Sonrqube on the t2.medium server
```
$ sudo apt update
$ sudo apt install -y docker.io
$ sudo usermod -a -G docker ubuntu
$ sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

## Step 4: Add necessary credentials
- [ ] Generate Sonarqube token of type "global analysis token" and add it as Jenkins credential of type "secret text"
- [ ] Add dockerhub credentials as username/password type
- [ ] Add Gitlab credentials 
- [ ] Add Build server credentials for Jenkins master to connect

## Step 5: Enable Sonarqube webhook for Quality Gates & Install dependency-check plugin
- [ ] Generate webhook & add the Jenkins URL as follows - http://URL:8080/sonarqube-webhook/



# some changes  for demo

```sh
docker pull zricethezav/gitleaks:latest
docker run --rm -v "D:\Tonmoy\ostad\springboot-build-pipeline-demo:/path" zricethezav/gitleaks:latest detect --source="/path" --verbose
```

for linux 
```sh
#!/bin/bash

docker pull zricethezav/gitleaks:latest
docker run --rm -v "/mnt/d/Tonmoy/ostad/springboot-build-pipeline-demo:/path" zricethezav/gitleaks:latest detect --source="/path" --verbose
```