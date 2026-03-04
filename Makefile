
docker:
	docker build --build-arg ROOT_PASSWORD=1234 --build-arg JENKINS_USER_PASSWORD=1234 -t "biswasakash/docker-ssh-agent:latest" -f agents/docker-ssh-agent.Dockerfile .
