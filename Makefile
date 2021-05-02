build:
	packer build ubuntu-2004.pkr.hcl

fmt:
	packer fmt -recursive .

validate:
	packer validate ubuntu-2004.pkr.hcl


.PHONY: build fmt validate
