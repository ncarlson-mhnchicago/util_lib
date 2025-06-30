--!jinja

-- =================================================================
--  This script deploys external notebooks from a GitHub repository
--      connected to the current notebooks
-- =================================================================

-- Create the Notebook
CREATE OR REPLACE NOTEBOOK IDENTIFIER('"{{target_db}}"."{{target_schema}}"."{{notebook}}"')
    FROM '@"{{source_db}}"."{{source_schema}}"."{{source_repo}}"/branches/"{{source_branch}}"/{{notebook}}.ipynb'   
    QUERY_WAREHOUSE = '{{query_wh}}'
    MAIN_FILE = '{{notebook}}.ipynb';
ALTER NOTEBOOK "{{target_db}}"."{{target_schema}}"."{{notebook}}" ADD LIVE VERSION FROM LAST;
