DOCKER_DIR := ./
DOCKER_PRE := wilsaj/

all: docker-images

docker-images: docker-everything-is-osm

tmpnb: docker-everything-is-osm-tmpnb run-tmpnb

run-tmpnb:
	docker ps | grep -E '(tmpnb|everything|configurable-http-proxy)' | awk '{print $$1}' | xargs docker stop
	$(eval TOKEN := $(shell head -c 30 /dev/urandom | xxd -p))
	docker rm proxy
	docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=${TOKEN} --name=proxy jupyter/configurable-http-proxy --default-target http://127.0.0.1:9999
	docker run --net=host -d -e CONFIGPROXY_AUTH_TOKEN=${TOKEN} \
			   -v /var/run/docker.sock:/docker.sock \
			   jupyter/tmpnb python orchestrate.py --image='wilsaj/everything-is-osm-tmpnb' --command="ipython3 notebook --NotebookApp.base_url={base_path} --ip=0.0.0.0 --port {port}" --pool_size=2


run:
	docker run -p 5432:5432 --rm -it wilsaj/everything-is-osm

%/ansible: ../ansible/
	cp -r $< $@

everything-is-osm/variables.yml: ../variables.yml
	cp $< $@

everything-is-osm-tmpnb/variables.yml: ../variables.yml
	cp $< $@

docker-%: % %/ansible %/variables.yml
	docker build -t $(DOCKER_PRE)$* $<
