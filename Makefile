image_name = leddzip/python-poetry
env_prefix = $$(bash ./build-scripts/build-env-prefix.sh)
python_tag = $$(bash ./build-scripts/get_python_tag.sh)
poetry_version = $$(bash ./build-scripts/get_poetry_version.sh)


.ONESHELL:
SHELL = /bin/bash
generate-dockerfile:
	echo "export INJECT_PYTHON_DOCKER_TAG=$(python_tag)" > args
	echo "export INJECT_POETRY_VERSION=$(poetry_version)" >> args
	source args
	envsubst "`printf '$${%s} ' $$(cat args | cut -d' ' -f2 | cut -d'=' -f1)`" < Dockerfile.template > Dockerfile

.ONESHELL:
SHELL = /bin/bash
build:
	source args
	docker build \
		-t $(image_name):$(env_prefix)py$(python_tag)-po$(poetry_version) \
		.

.ONESHELL:
SHELL = /bin/bash
push:
	source args
	docker push $(image_name):$(env_prefix)py$(python_tag)-po$(poetry_version)

.ONESHELL:
SHELL = /bin/bash
clean:
	source args
	docker rmi $(image_name):$(env_prefix)py$(python_tag)-po$(poetry_version)
	rm Dockerfile
	rm args


.ONEHSELL:
SHELL = /bin/bash
test:
	source args
	bash ./build-scripts/test_python_version.sh $(image_name):$(env_prefix)py$(python_tag)-po$(poetry_version)
	bash ./build-scripts/test_poetry_version.sh $(image_name):$(env_prefix)py$(python_tag)-po$(poetry_version)