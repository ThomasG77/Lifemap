sudo apt-get --yes update
sudo apt-get --yes upgrade
sudo apt-get --yes install libboost-all-dev git-core tar unzip wget bzip2 build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler libfreetype6-dev libpng-dev libtiff5-dev libicu-dev libgdal-dev libcairo-dev libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont lua5.1 liblua5.1-dev libgeotiff-epsg node-carto
sudo apt-get --yes install postgresql postgresql-contrib postgis postgresql-10-postgis-2.4
sudo -u postgres dropdb tree #remove db if exists
sudo -u postgres dropuser lm #removes lm if exists
sudo -u postgres createuser lm -P #creates user lm and prompts for password
sudo -u postgres createdb -E UTF8 -O lm tree
sudo -u postgres psql -d tree -f dbSetup.sql
sudo apt-get --yes install gdal-bin libgdal-dev libmapnik-dev mapnik-utils python-mapnik
#cd
#mkdir src
cd ~/src
git clone git://github.com/damiendevienne/mod_tile_deepzoom.git
mv mod_tile_deepzoom mod_tile
#cd mod_tile
#cd ~/src
#git clone https://github.com/damiendevienne/Lifemap.git
cd ~/src/mod_tile
./autogen.sh
./configure
make
sudo make install
sudo make install-mod_tile
sudo ldconfig
sudo mkdir /var/lib/mod_tile
sudo mkdir /var/run/renderd
sudo cp ~/src/Lifemap/SetupServer/mod_tile.conf /etc/apache2/conf-available/mod_tile.conf
sudo a2enconf mod_tile
sudo service apache2 reload
sudo cp ~/src/Lifemap/SetupServer/renderd.conf /etc/ ## a faire avant de relancer apache2
sudo cp ~/src/Lifemap/SetupServer/000-default.conf /etc/apache2/sites-available/ #replace apache config file 
sudo service apache2 restart
# ##configure python
sudo apt-get --yes install python-numpy python-qt4 python-lxml python-six python-pip
sudo pip install --upgrade pip
sudo pip install --upgrade psycopg2-binary
sudo pip install --upgrade ete3
##configure solr
sudo apt-get --yes install default-jre default-jdk
cd ~/src
wget http://mirrors.ircam.fr/pub/apache/lucene/solr/6.6.5/solr-6.6.5.tgz
tar xvzf solr-6.6.5.tgz
cd ~/src/solr-6.6.5
bin/solr start
bin/solr create -c taxo
bin/solr create -c addi
cp ~/src/Lifemap/OTHER/solr-config/schema.taxo.xml ~/src/solr-6.6.5/server/solr/taxo/conf/schema.xml
cp ~/src/Lifemap/OTHER/solr-config/solrconfig.taxo.xml ~/src/solr-6.6.5/server/solr/taxo/conf/solrconfig.xml
