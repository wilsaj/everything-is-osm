Everything is OSM
=================

Super easy setup for getting a postgis database running with OpenStreetMap
[metro extracts](https://mapzen.com/metro-extracts/). More free time for your
OSM community!


First
-----

Install recent versions of these:

- [Vagrant](http://vagrantup.com/)
- [Ansible](http://docs.ansible.com/)



Then
----

Choose which metro areas you want to use. Edit `variables.yml` so that the last
line contains a list of [metro extracts](https://mapzen.com/metro-extracts/)
that you want to include. For example:

    metro_extracts:
      - "austin"
      - "barcelona"
      - "portland"



Run:

    vagrant up


After it does it's thing, a postgis database will be available at port 5432 with
osm data available for use! Default database name, user and password are "osm",
but you can change them.



More Customizing
----------------


You can change the username, password and database name by in `variables.yml`.

To serve out of a different port, edit `Vagrantfile`.
