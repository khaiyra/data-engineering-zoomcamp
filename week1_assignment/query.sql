-- Question 3
-- How many taxi trips were there on January 15?
SELECT
  CAST(tpep_pickup_datetime),
  COUNT(index)  
FROM
  yellow_taxi_trips
WHERE
    CAST(tpep_pickup_datetime) = '2021-01-05'
GROUP BY
  CAST(tpep_pickup_datetime);

-- Question 4
-- On which day it was the largest tip in January?
SELECT 
    CAST(tpep_pickup_datetime),
    MAX(Tip_amount) AS 'largest_tip'
FROM
	yellow_taxi_trips
GROUP BY CAST(tpep_pickup_datetime)
ORDER BY 'largest_tip' DESC;

-- Question 5
-- What was the most popular destination for passengers picked up in central park on January 14?
SELECT
	tpep_pickup_datetime,
	COUNT(zdo.'Zone') AS 'zone_count',
	zpu.'Zone' AS 'pickup_loc',
	zdo.'Zone' AS 'dropoff_loc'
FROM 
	yellow_taxi_trips t 
	JOIN zones zpu
    ON t.'PULocationID' = zpu.'LocationID'
    JOIN zones zdo
    ON t.'DOLocationID' = zdo.'LocationID'
WHERE
	zpu.'Zone' = 'Central Park' AND CAST(tpep_pickup_datetime) = '2021-01-14'
GROUP BY
	1,3, 4
ORDER BY
	zone_count DESC, 1 ASC;

-- Question 6
-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?
SELECT
	AVG(total_amount) AS 'avg_total_amount',
	CONCAT(zpu.'Zone', ' / ', zdo.'Zone') AS 'pickup_dropoff'

FROM
    yellow_taxi_trips t,
    zones zpu,
	zones zdo
 
WHERE
	t.'PULocationID' = zpu.'LocationID' AND
	t.'DOLocationID' = zdo.'LocationID'
GROUP BY 
    zpu.'Zone', zdo.'Zone'
ORDER BY
  'avg_total_amount' DESC;