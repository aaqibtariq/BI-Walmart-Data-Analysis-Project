

# Create a Snowflake Storage Integration

This is the bridge between Snowflake and AWS

# setup databse and schema
```sql
USE ROLE ACCOUNTADMIN;
Create DATABASE WALMART_DB;
Use DATABASE WALMART_DB; 
Create SCHEMA Bronze; 
USE SCHEMA Bronze;
```

```sql
CREATE OR REPLACE STORAGE INTEGRATION s3_walmart_bi_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = S3
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/snowflake-s3-read-role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://<path to folder>');
```

```sql
DESC STORAGE INTEGRATION s3_walmart_bi_integration;
```

This will return values including:

STORAGE_AWS_IAM_USER_ARN

STORAGE_AWS_EXTERNAL_ID


# Update IAM Role Trust Policy (Snowflake ↔ AWS handshake)
 Use this Trust Relationship JSON (paste exactly)
 

Go to AWS Console → IAM → Roles → snowflake-s3-read-role → Trust relationships → Edit trust policy
Replace the entire trust policy with:


```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "SnowflakeAssumeRole",
      "Effect": "Allow",
      "Principal": {
        "AWS": "< STORAGE_AWS_IAM_USER_ARN from snowflake >"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": " < STORAGE_AWS_EXTERNAL_ID from snowflake >"
        }
      }
    }
  ]
}
```

Save it


N️ext : Create External Stage + LIST files (proves access)
Create a file format (CSV)

```sql
CREATE OR REPLACE FILE FORMAT walmart_csv_ff
  TYPE = CSV
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  NULL_IF = ('', 'NULL', 'null', 'NA', 'N/A')
  EMPTY_FIELD_AS_NULL = true;

CREATE OR REPLACE STAGE walmart_raw_stage
  URL = 's3://<path to folder>'
  STORAGE_INTEGRATION = s3_walmart_bi_integration
  FILE_FORMAT = walmart_csv_ff;

```

# you should see your files by belopw command and it will confirm that your connection between S3 and snowflake working
```sql
LIST @walmart_raw_stage;
```


