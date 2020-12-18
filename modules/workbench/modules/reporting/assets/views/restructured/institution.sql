SELECT
    i.display_name,
    STRUCT(i.institution_id,
           i.short_name) AS metadata,
    STRUCT(i.organization_type_enum AS type,
           i.organization_type_other_text AS details) AS organization_type,
    i.dua_type_enum AS dua_type
FROM
    `${project}`.${dataset}.live_institution i
