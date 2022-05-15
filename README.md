# **covid_movement**
## **Data Columns**
1. **ds**: Date stamp for movement range data row in YYYY-MM-DD form
2. **country**: Three-character ISO-3166 country code
3. **polygon_source**: Source of region polygon, either “FIPS” for U.S. data or “GADM” for global data
4. **polygon_id**: Unique identifier for region polygon, either numeric string for U.S. FIPS codes or alphanumeric string for GADM regions
5. **polygon_name**: Region Name
6. **all_day_bing_tiles_visited_relative_change**: Positive or negative change in movement relative to baseline.  Change in Movement looks at how much people are moving around and compares it with a baseline period that predates most social distancing measures
7. **all_day_ratio_single_tile_users**:	Positive proportion of users staying put within a single location. Stay Put looks at the fraction of the population that appear to stay within a small area during an entire day
8. **baseline_name**: When baseline movement was calculated pre-COVID-19	
9. **baseline_type**: How baseline movement was calculated pre-COVID-19
