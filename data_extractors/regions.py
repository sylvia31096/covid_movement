import pandas as pd
cols_list=['polygon_name', '']
df = pd.read_csv("movement_ken.csv")
df[['polygon_name','covid_movement_id']] = df[['polygon_name', 'Unnamed: 0']]
df[['polygon_name','covid_movement_id']].to_csv("regions.csv", index=False)