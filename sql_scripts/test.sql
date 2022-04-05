SELECT tmp_region.region_name, region.region_id, region.region_name, region.administrative_level  
FROM
    (SELECT 
        tmp_region.region_name, 
        region.region_id, 
        region.region_name, 
        region.administrative_level 
    FROM region
    INNER JOIN tmp_region 
    ON (region.region_name=tmp_region.constituencies) 
    WHERE administrative_level='sub-county'

    INNER JOIN results
    ON (results.tmp_region.region_name=region.region_name)
    WHERE administrative_level='county'


SELECT 
        region.region_name, 
        region.region_id, 
        tmp_region.constituencies, 
        region.administrative_level,
        rank() OVER (PARTITION BY region.region_name)
    FROM tmp_region
    INNER JOIN region 
    ON (region.region_name=tmp_region.region_name);

WITH parent_values AS (
    SELECT 
        region.region_id
    FROM tmp_region
    INNER JOIN region 
    ON (region.region_name=tmp_region.region_name)
    WHERE administrative_level='county')
UPDATE region
SET parent_region_id = parent_values.region_id
FROM parent_values
WHERE administrative_level='sub-county';

SELECT 
        region.region_id, region.region_name
    FROM tmp_region
    RIGHT OUTER JOIN region 
    ON (region.region_name=tmp_region.region_name))
    WHERE administrative_level='county'

WITH parent_values AS (
    SELECT 
        region.region_id, tmp_region.constituencies
    FROM tmp_region
    INNER JOIN region 
    ON (region.region_name=tmp_region.region_name)
    WHERE administrative_level='county')
UPDATE region
SET parent_region_id = 
    (CASE WHEN region.region_name=parent_values.constituencies
        THEN parent_values.region_id
        ELSE null
        END)
FROM parent_values;

WITH v AS (                                                     
    SELECT 
        region.region_id, tmp_covid.region_name
    FROM tmp_covid
    INNER JOIN region 
    ON (region.region_name=UPPER(tmp_covid.region_name)))
UPDATE covid_movement
SET covid_movement.region_id = v.region_id
FROM v

SELECT c.covid_movement_id, c.region_id, r.region_name 
FROM covid_movement AS c 
INNER JOIN region 
AS r 
ON c.region_id=r.region_id;

WITH v AS(
SELECT 
    c.region_id,
    c.covid_movement_id,
    r.region_name,
    r.parent_region_id

FROM covid_movement AS c
INNER JOIN region AS r
ON c.region_id=r.region_id)
SELECT 
    v.region_name,
    v.covid_movement_id,
    v.parent_region_id,
    DENSE_RANK() OVER(ORDER BY parent_region_id) AS rownum
FROM v 
ORDER BY covid_movement_id;

WITH a AS(
SELECT
    r.region_id,
    r.region_name,
    c.region_name AS parent
FROM region as r
INNER JOIN region AS c
ON c.region_id=r.parent_region_id
)
SELECT
    t.covid_movement_id,
    t.region_id,
    a.region_name,
    a.parent
FROM a
INNER JOIN covid_movement as t
ON a.region_id=t.region_id;

WITH t AS(

)
SELECT 
    ntiles,
    CASE ntiles
        WHEN 3 THEN 'Top tier'
        WHEN 2 THEN 'Average'
        WHEN 1 THEN 'Subpr'
    END rating,
    AVG(all_day_bing_tiles_visited_relative_change)
FROM(
SELECT
    c.covid_movement_id,
    c.all_day_bing_tiles_visited_relative_change,
    NTILE(3) OVER(ORDER BY c.all_day_bing_tiles_visited_relative_change) AS ntiles
FROM covid_movement AS c) AS percentiles
GROUP BY ntiles
HAVING AVG(all_day_bing_tiles_visited_relative_change)>0;