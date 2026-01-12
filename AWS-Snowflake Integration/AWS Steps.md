
# STEP 1️⃣: Create S3 bucket for the Walmart project

Create one S3 bucket

Organize it so it clearly represents Bronze (raw data)

Upload your 3 source CSV files

This bucket will act as the Bronze layer entry point.

# 1️⃣ Decide bucket naming 

Use a clear, professional name.

Recommended format
<project>-<env>-<purpose>

Example (current project)
walmart-bi-dev-raw


# Why this is good:

walmart-bi → project name

dev → environment (easy to add prod later)

raw → Bronze layer intent


# 2️⃣ Create the S3 bucket (AWS Console)

Log in to AWS Console

Go to S3

Click Create bucket

Enter:

Bucket name: walmart-bi-dev-raw

Region: choose ONE region and remember it (example: us-east-1)

Leave defaults:

Block all public access ✅

Bucket versioning ❌ (can enable later)

Click Create bucket

✔️ Bucket created

# 3️⃣ Create folder structure (very important)

Inside the bucket, create folders so it will be helpful one from security prospective and another it will organize the files

I created as walmart-bi-dev-raw/raw_data/

# 4️⃣ Upload your source files

Rename files before uploading (important) and upload into folder



# STEP 2️⃣: Create policy and IAM Role for Snowflake → S3 access

# Policy

# 1️⃣ 

From IAM click policy and click Create policy

# 2️⃣

Click Json and paste below policy

###

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSnowflakeRead",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3::: <bucket>/<folder>/*",
      ]
    }
  ]
}



###

Save policy

Policy name: SnowflakeS3Read_walmart_bi

Click Create policy


# ROLE

# 1️⃣ Go to IAM

Open AWS Console

Search IAM

Click Roles

Click Create role

# 2️⃣ Select trusted entity
Choose:

Trusted entity type: AWS account

Click Current account
Also check External ID and type 0000 for now


# 3️⃣ Attach permissions

attach the policy you created - SnowflakeS3Read_walmart_bi

# 4️⃣ Name the role
Role name:
snowflake-s3-read-role

Description:
IAM role for Snowflake to read raw Walmart BI data from S3


Click Create role
