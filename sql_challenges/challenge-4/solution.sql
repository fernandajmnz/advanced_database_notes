-- oracle sql 

SELECT b.*,
       count(*) OVER (
           PARTITION BY shape
       ) bricks_per_shape,
       median(weight) over (
           PARTITION BY shape
       ) median_weight_per_shape
FROM bricks b
order by shape, weight, brick_id;

SELECT b.brick_id, b.weight,
       round(
           avg(weight) over (
               ORDER BY brick_id
           ), 2
       ) running_average_weight
FROM bricks b
ORDER BY brick_id;


SELECT b.*,
       min(colour) over (
         ORDER BY brick_id
         rows between 2 preceding and 1 preceding
       ) first_colour_two_prev,
       count(*) over (
         ORDER BY weight
         range between current row and 1 following
       ) count_values_this_and_next
FROM   bricks b
ORDER BY weight;


-- Interview Question 

SELECT department_name, name, salary
FROM (
    SELECT d.department_name,
           e.name,
           e.salary,
           DENSE_RANK() OVER (
               PARTITION BY e.department_id
               ORDER BY e.salary DESC
           ) AS rnk
    FROM employee e
    JOIN department d
      ON e.department_id = d.department_id
) t
WHERE rnk <= 3
ORDER BY department_name ASC, salary DESC, name ASC;