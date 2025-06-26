--!jinja

-- =================================================================
--  This script deploys external notebooks from a GitHub repository
--      connected to the current notebooks
-- =================================================================

/* Example Call with Payload

SET notebook_list ARRAY [  
    'load_excel_files', 
    'load_metrics']

FOR notebook IN notebook_list DO
    EXECUTE IMMEDIATE FROM @GITHUB_REPO/branches/main/deploy_notebooks.sql
        USING (
            notebook => notebook,
            
            source_wh => 'MHN',
            source_db => 'data_engineering_with_snowflake_notebooks',
            source_schema => 'INTEGRATIONS',
            source_repo => 'data_engineering_with_snowflake_notebooks',
            source_branch => $ENV,
            source_directory =>'notebooks',

            target_db => 'data_engineering_with_snowflake_notebooks',
            target_schema => $ENV || '_Schema', 
            source_db => 'data_engineering_with_snowflake_notebooks',            
            );
 */

-- Create the Notebook
CREATE OR REPLACE NOTEBOOK IDENTIFIER('"{{target_db}}"."{{target_schema}}"."{{notebook}}"')
    FROM '@"{{source_db}}"."{{source_schema}"."{{source_repo}}"/branches/"{{source_branch}}"/"{{source_directory}}"/{{notebook}}/'   
    QUERY_WAREHOUSE = '{{source_wh}}'
    MAIN_FILE = '{{notebook}}.ipynb';
ALTER NOTEBOOK "{{target_db}}"."{{target_schema}}"."{{notebook}}" ADD LIVE VERSION FROM LAST;
