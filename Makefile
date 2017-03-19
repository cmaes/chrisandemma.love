all: bay_area_geo.json bay_area_highway.json

#shn2014v3_Segments.shp obtained from http://www.dot.ca.gov/hq/tsip/gis/datalibrary/Metadata/StateHighway.html
# http://www.dot.ca.gov/hq/tsip/gis/datalibrary/zip/highway/shn2014v3_Segments.zip

#statesp020.shp obtained from https://catalog.data.gov/dataset/usgs-small-scale-dataset-state-boundaries-of-the-united-states-200506-shapefile
#https://prd-tnm.s3.amazonaws.com/StagedProducts/Small-scale/data/Boundaries/statesp020_nt00032.tar.gz

bay_area_highway.shp: shn2014v3_Segments.shp
	#ogr2ogr -clipsrc -123.3353 37.4738 -122.1378 38.5192  bay_area_highway.shp shn2014v3_Segments.shp
	ogr2ogr -where "Route=101 OR Route=12 OR Route=121 OR Route=37 OR Route=80 OR Route=880" -clipsrc -123.3353 37.4738 -122.1378 38.5192 bay_area_highway.shp shn2014v3_Segments.shp

bay_area_highway.json: bay_area_highway.shp
	ogr2ogr -f GeoJSON bay_area_highway.json bay_area_highway.shp

bay_area.shp: statesp020.shp 
	ogr2ogr -clipsrc -123.3353 37.4738 -122.1378 38.5192  bay_area.shp statesp020.shp 

bay_area_geo.json: bay_area.shp
	ogr2ogr -f GeoJSON bay_area_geo.json bay_area.shp

clean:
	$(RM) bay_area.shp bay_area_geo.json 
	$(RM) bay_area_highway.shp bay_area_highway.json

tidy:
	$(RM) bay_area.shp
	$(RM) bay_area_highway.shp