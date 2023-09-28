#!/bin/bash







# layer geoaddress:
rm -rf /tmp/sandbox/_pk21800000101_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk21800000101_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org https://dl.digital-guard.org/77329f34a71ed1dcf470ac74a96b5a93ee27245060b5980a1153a6bd81e2e7ea.zip
sudo chown postgres:www-data /var/www/dl.digital-guard.org/77329f34a71ed1dcf470ac74a96b5a93ee27245060b5980a1153a6bd81e2e7ea.zip && sudo chmod 664 /var/www/dl.digital-guard.org/77329f34a71ed1dcf470ac74a96b5a93ee27245060b5980a1153a6bd81e2e7ea.zip
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk21800000101101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk21800000101_001; 7z  x -y /var/www/dl.digital-guard.org/77329f34a71ed1dcf470ac74a96b5a93ee27245060b5980a1153a6bd81e2e7ea.zip "*numeracion_casas_direccion/numeracion_casas_t_direcc*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32717"
cd /tmp/sandbox/_pk21800000101_001; shp2pgsql -D   -s 32717 "numeracion_casas_direccion/numeracion_casas_t_direcc.shp" pk21800000101101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/_pk21800000101_001/numeracion_casas_direccion/numeracion_casas_t_direcc.shp','geoaddress_full','pk21800000101101_p1_geoaddress','21800000101101','77329f34a71ed1dcf470ac74a96b5a93ee27245060b5980a1153a6bd81e2e7ea.zip',array['gid', 'numero AS hnum', 'calle as via', 'geom'],1,1)"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk21800000101101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk21800000101_001/*numeracion_casas_direccion/numeracion_casas_t_direcc.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','EC-F-Azogues','/var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-EC2021/data/F/Azogues/_pk0001.01/geoaddress -type f -exec chmod 664 {} \;







