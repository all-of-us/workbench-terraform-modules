SELECT
    TIMESTAMP_MILLIS(u.snapshot_timestamp) AS snapshot,
    u.user_id AS user_id,
    u.username,
    COUNT(w.workspace_id) AS total_active_workspaces,
FROM
    `${project}`.${dataset}.live_workspace AS w
INNER JOIN
    `${project}`.${dataset}.live_user AS u
ON
    u.user_id = w.creator_id
GROUP BY
    u.snapshot_timestamp,
    u.user_id,
    u.username
ORDER BY
    total_active_workspaces DESC;
