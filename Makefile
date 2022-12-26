
SHELL:=/bin/bash
in_cygwin := $(shell which cygpath 1> /dev/null 2> /dev/null;  echo $$?)
home_dir := $(shell echo "$$HOME")
curr_dir := $(shell pwd)

ifeq (0, $(in_cygwin))
	platform := "windows"
else
	platform := "unix"
endif

##########################################################################################
# run terraform directives from inside container (make docker, >>make plan)
##########################################################################################
docker: check-platform
ifeq ($(platform), "windows")
	@git config core.filemode false
	export AWS_HOME_FOR_DOCKER="$(shell echo "$(home_dir)/.aws" | sed -E 's/cygdrive/\//g')" && \
	export CURR_DIR_FOR_DOCKER="$(shell echo $(curr_dir) | sed -E 's/cygdrive/\//g')" && \
	docker-compose -f $(platform).yml run --rm $(platform)
endif
ifeq ($(platform), "unix")
	docker-compose -f $(platform).yml run --rm $(platform)
endif 

validate: 
	terraform init
	terraform fmt -recursive
	terraform validate

check-platform:
ifndef platform
	$(error platform is not defined)
endif