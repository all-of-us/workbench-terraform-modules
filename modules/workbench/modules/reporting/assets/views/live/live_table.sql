-- All ${table_name} rows from the most recent snapshot
SELECT
    t.*
FROM
    `${project}`.${dataset}.${table_name} t
WHERE
        t.snapshot_timestamp = (
        SELECT
            MAX(vs.snapshot_timestamp)
        FROM
            `${project}`.${dataset}.verified_snapshot vs)
         WHERE vs.verified is TRUE;
