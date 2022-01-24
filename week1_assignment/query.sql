-- How many taxi trips were there on January 15?
SELECT
COUNT(1)
FROM
	yellow_taxi_trips
WHERE 
	tpep_pickup_datetime = '2021-01-05 00:00:00'
AND
	tpep_dropoff_datetime = '2021-01-05 23:59:00';


-- On which day it was the largest tip in January?
SELECT tpep_pickup_datetime, MAX(Tip_amount) AS "tip"
FROM
	yellow_taxi_trips
GROUP BY (1)
ORDER BY "tip" DESC;

-- What was the most popular destination for passengers picked up in central park on January 14?
SELECT
	tpep_pickup_datetime,
	COUNT(zdo."Zone") AS "zone_count",
	zpu."Zone" AS "pickup_loc",
	zdo."Zone" AS "dropoff_loc"
FROM 
	yellow_taxi_trips t 
	JOIN zones zpu
    ON t."PULocationID" = zpu."LocationID"
    JOIN zones zdo
    ON t."DOLocationID" = zdo."LocationID"
WHERE
	zpu."Zone" = 'Central Park' AND tpep_pickup_datetime = '2021-01-14 16:00:44'
GROUP BY
	1,3, 4
ORDER BY
	"zone_count" DESC, 1 ASC;

-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?
SELECT
	AVG(total_amount) AS "price",
	CONCAT(zpu."Zone", ' / ', zdo."Zone") AS "pickup_dropoff" 

FROM
    yellow_taxi_trips t,
    zones zpu,
	zones zdo
 
WHERE
	t."PULocationID" = zpu."LocationID" AND
	t."DOLocationID" = zdo."LocationID"
GROUP BY (2)
ORDER BY
  "price" DESC;
  

SELECT
  CAST(tpep_pickup_datetime AS DATE) AS "DAY",
  COUNT(*) AS "count" 
FROM
  yellow_taxi_trips t
GROUP BY
  CAST(tpep_pickup_datetime AS DATE)
ORDER BY "DAY" ASC;