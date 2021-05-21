MAKEFLAGS  	+= --silent
SHELL      	 = /bin/bash

export AWS_REGION
export AWS_PAGER

ifndef AWS_REGION
	AWS_REGION	 := us-east-1
endif

ifndef AWS_PAGER
	AWS_PAGER	 := ""
endif

fmt:
	terraform fmt

init: fmt
	terraform init

validate: fmt 
	terraform validate
	
plan: fmt validate
	terraform plan

apply: fmt validate
	terraform apply

destroy: fmt
	terraform destroy