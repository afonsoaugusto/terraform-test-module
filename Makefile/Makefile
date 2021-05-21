MAKEFLAGS  	+= --silent
SHELL      	 = /bin/bash

export NAME

ifndef NAME
	NAME	 := "my-test-nginx"
endif


envsub:
	envsubst < deployment.yaml | tee t
