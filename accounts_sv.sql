--!jinja
CALL SYSTEM$CREATE_SEMANTIC_VIEW_FROM_YAML(
  '{{db}}.SEMANTIC',
  $$
name: ACCOUNTS_SV
description: Salesforce accounts (customer companies)
tables:
  - name: ACCOUNT
    base_table:
      database: SF_RAW_TEST
      schema: SALESFORCE
      table: ACCOUNT
    primary_key:
      columns: [ID]
    dimensions:
      - name: ACCOUNT_NAME
        synonyms: ["customer", "company"]
        expr: NAME
        data_type: VARCHAR
      - name: STATE
        synonyms: ["region", "location"]
        expr: BILLINGSTATE
        data_type: VARCHAR
    metrics:
      - name: ACCOUNT_COUNT
        description: Number of accounts
        expr: COUNT(ID)
  $$
);