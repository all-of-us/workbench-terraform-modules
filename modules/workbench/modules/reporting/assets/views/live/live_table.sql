-- All ${table_name} rows from the most recent snapshot
SELECT
    t.*
FROM
    `${project}`.${dataset}.${table_name} t
WHERE
        t.snapshot_timestamp = (
        SELECT
            MAX(u.snapshot_timestamp)
        FROM
            `${project}`.${dataset}.user u)
ORDER BY
    t.${table_name}_id;
