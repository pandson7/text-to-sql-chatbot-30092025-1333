# Architecture Diagrams

This folder contains the system architecture diagrams for the Text-to-SQL chatbot.

## Files

- `text-to-sql-architecture.png`: Main system architecture diagram showing the complete flow from user interaction through React frontend, API Gateway, Lambda functions, Amazon Bedrock, and RDS PostgreSQL database.

## Architecture Overview

The diagram illustrates:

1. **User Interface**: User interacts with React chat application
2. **Frontend Layer**: React app served via CloudFront CDN from S3
3. **API Layer**: API Gateway handling REST endpoints
4. **Backend Processing**: Lambda function for query processing
5. **AI/ML Services**: Amazon Bedrock with Claude Sonnet for text-to-SQL conversion
6. **Database Layer**: PostgreSQL RDS instance with product orders data
7. **Security**: VPC, NAT Gateway, and Secrets Manager for secure operations

## Data Flow

1. User submits natural language query via React UI
2. Frontend sends request to API Gateway
3. API Gateway triggers Lambda function
4. Lambda function calls Bedrock to convert natural language to SQL
5. Lambda executes SQL query against RDS database
6. Results are formatted and returned to user with both SQL and human-readable response

Note: The actual PNG diagram file is available in the local project directory but may not be visible in GitHub due to file size limitations.