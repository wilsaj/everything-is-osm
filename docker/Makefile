DOCKER_DIR := ./
DOCKER_PRE := wilsaj/

all: docker-images

docker-images: docker-everything-is-osm

%/ansible: ../ansible/
	cp -r $< $@

everything-is-osm/variables.yml: ../variables.yml
	cp $< $@

everything-is-osm-tmpnb/variables.yml: ../variables.yml
	cp $< $@

docker-%: % %/ansible %/variables.yml
	docker build -t $(DOCKER_PRE)$(notdir $(<D)) $<
