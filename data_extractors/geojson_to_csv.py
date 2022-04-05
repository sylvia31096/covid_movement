import json
import pandas as pd
f = open('counties.geojson')
data = json.load(f)
polygons = []
county_codes = []
county_names = []
for i in data["features"]:
    polygons.append(i['geometry']['coordinates'])
    county_codes.append(i['properties']['COUNTY_COD'])
    county_names.append(i['properties']['COUNTY_NAM'])
def to_tuple(lst):
    return tuple(to_tuple(i) if isinstance(i, list) else i for i in lst)
polygons = to_tuple(polygons)
df = pd.DataFrame({"region_name":county_names, "region_polygon":polygons})

df['region_polygon'] = df['region_polygon'].apply(lambda x: 'POLYGON'+str(x)[1:])
df['region_polygon'] = df['region_polygon'].str.replace(',','')
df['region_polygon'] = df['region_polygon'].str.replace(')',',')
df['region_polygon'] = df['region_polygon'].str.replace('(','')
df['region_polygon'] = df['region_polygon'].str.replace('POLYGON','POLYGON((')
df['region_polygon'] = df['region_polygon'].apply(lambda x: x[:-3]+'))')
df['region_source']='GADM'
df['administrative_level']='county'

df.to_csv("counties.csv", index=False)