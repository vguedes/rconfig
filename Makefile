help:
	@echo "Options:"
	@echo "    build-image: build the docker image of rConfig"

build-image:
	docker build --rm -t bcouto/rconfig .

clean-images:
	docker images -q -f "dangling=true" | xargs --no-run-if-empty docker rmi

clean-volumes:
	docker volume ls -q -f dangling=true | xargs --no-run-if-empty docker volume rm

clean:
	docker ps -q -f status=exited | xargs --no-run-if-empty docker rm
