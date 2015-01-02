DOCKER_DIR := ./
DOCKER_PRE := wilsaj/

all: docker-images

docker-images: docker-everything-is-osm

$(DOCKER_DIR)/%/ansible: ../ansible/
	cp -r $< $@

$(DOCKER_DIR)/%/variables.yml: ../variables.yml
	cp $< $@

docker-%: $(DOCKER_DIR)/% $(DOCKER_DIR)/%/ansible $(DOCKER_DIR)/%/variables.yml
	docker build -t $(DOCKER_PRE)$(notdir $(<D)) $<
