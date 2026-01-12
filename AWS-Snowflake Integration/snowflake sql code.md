

# Create a Snowflake Storage Integration

Snowflake will give us:

AWS Account ID

External ID

We’ll use those to securely update the IAM role trust policy

```sql
USE ROLE ACCOUNTADMIN;
Create DATABASE WALMART_DB;
Use DATABASE WALMART_DB; 
Create SCHEMA Bronze; 
USE SCHEMA Bronze;
```
