import pandas as pd

counties_df = pd.read_csv('data/other_subcounties_counties.csv')
counties_df2 = pd.read_csv('data/counties_sub.csv')

counties_df.columns = ['county_index', 'county', 'constituencies']
counties_df['constituencies'] = counties_df['constituencies'].str.strip()
counties_df['county'] = counties_df['county'].str.strip()
counties_df['county'] = counties_df['county'].str.upper()
counties_df = counties_df[['county','constituencies']]

counties_df2.columns = ['county','constituencies']

counties_df3 = counties_df.append(counties_df2).drop_duplicates()
counties_df3['constituencies'] = counties_df3['constituencies'].str.replace('GARISSA', 'GARISSA TOWNSHIP')

row = pd.DataFrame(
    data={
        'county':['KILIFI', 'KILIFI', 'KILIFI'],
        'constituencies':['KILIFI NORTH', 'CHONYI', 'KAUMA']
    }
)
counties_df3 = counties_df3.append(row)

counties_df.to_csv('data/other_subcounties_counties.csv', index=False)