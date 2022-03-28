all:buildscripts

setup:
	@chmod 755 script.sh
	@./script.sh setup_client
	@./script.sh setup_server

run-client:
	@chmod 755 script.sh
	@./script.sh run_client

run-server:
	@chmod 755 script.sh
	@./script.sh run_server

test:
	@chmod 755 script.sh
	@./script.sh run_client_tests
	@./script.sh run_server_tests

build-server-docker:
	@chmod 755 script.sh
	@./script.sh build_server_docker_image

run-server-docker:
	@chmod 755 script.sh
	@./script.sh run_server_docker_image