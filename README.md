Everything is OSM
=================

A super easy way to setup PostGIS with OpenStreetMap data extracts from
[mapzen](https://mapzen.com/metro-extracts/) and
[geofabrik](http://download.geofabrik.de/). More free time for your OSM
community!


First
-----

Install recent versions of these:

- [Vagrant](http://vagrantup.com/)
- [Virtualbox](https://www.virtualbox.org/)



Then
----

Choose which areas you want to extract. The [metro
extracts](https://mapzen.com/metro-extracts/) focus metropolitan areas, and the
[geofabrik](http://download.geofabrik.de/) extracts are larger country and
regional level areas. Large extracts of regions or multiple large countries
involve a lot of data so they will take longer to import and may require
more virtual machine memory to successfully import (see the [Customize it](#customize-it)
section below for how to increase the amount of RAM).


Edit `variables.yml` so it contains the extracts that you want to include. For
example:

    metro_extracts:
      - "austin"
      - "barcelona"
      - "portland"



Then from the command line, just run `vagrant up` and give it a few minutes to
do it does its thing. When it finishes running, a PostGIS database will be ready
to go and loaded up with OSM data! Connect to the database on port 5432. For
example, you can use this string to connect to the PostGIS database from
Tilemill:

    dbname=osm host=localhost port=5432 user=osm password=osm


![Tilemill Screenshot](tilemill-screenshot.png)



Stopping
--------

To stop the server, run `vagrant halt`.



Customize it
------------

The file `variables.yml` contains the database name, user and password (all
default to "osm"), as well as port number (default 5432), and settings for
virtual machine memory and number of cpus. Feel free to open up `variables.yml`
and change any of these values.
