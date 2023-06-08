
CREATE OR REPLACE FUNCTION mdp_ods.reset_sequence_value_if_table_exists(
    t_name text, reset_sql text, t_schema text
) 
returns void AS
$$
BEGIN
    IF exists (SELECT tablename FROM pg_catalog.pg_tables 
                   WHERE tablename = t_name  AND schemaname= t_schema ) THEN
        EXECUTE reset_sql;
    ELSE
        RAISE NOTICE 'Table % does not exist, skipping sequence value reset', t_name;
    END IF;
END;
$$ language 'plpgsql' VOLATILE;
