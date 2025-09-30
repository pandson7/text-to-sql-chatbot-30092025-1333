# Design Document

## Introduction

This document outlines the technical architecture for the Text-to-SQL conversational chatbot system. The solution leverages AWS services including Amazon Bedrock for LLM capabilities, RDS for database storage, Lambda for backend processing, API Gateway for REST endpoints, and a React frontend for the user interface.

## System Architecture

### High-Level Architecture

The system follows a serverless architecture pattern with the following components:

1. **Frontend**: React-based chat interface hosted on S3 with CloudFront distribution
2. **API Layer**: Amazon API Gateway with REST endpoints
3. **Backend Processing**: AWS Lambda functions for query processing and database operations
4. **AI/ML Layer**: Amazon Bedrock with Claude Sonnet model for natural language to SQL conversion
5. **Database Layer**: Amazon RDS PostgreSQL with sample product orders data
6. **Infrastructure**: AWS CDK for infrastructure as code

### Component Details

#### Frontend (React Application)
- **Technology**: React with AWS Amplify for authentication (if needed)
- **Features**: 
  - Chat interface with message history
  - Display of both human-readable answers and SQL queries
  - Error handling and loading states
  - Responsive design

#### API Gateway
- **Endpoints**:
  - `POST /query` - Process natural language queries
  - `GET /health` - Health check endpoint
- **Features**:
  - CORS configuration for frontend access
  - Request/response validation
  - Rate limiting and throttling

#### Lambda Functions
- **Query Processor Function**:
  - Receives natural language input
  - Calls Amazon Bedrock to generate SQL
  - Executes SQL against RDS database
  - Formats response with both human-readable and SQL query
  - Handles errors and edge cases

#### Amazon Bedrock Integration
- **Model**: `global.anthropic.claude-sonnet-4-20250514-v1:0`
- **Functionality**:
  - Convert natural language to SQL queries
  - Generate human-readable explanations
  - Handle context about database schema

#### Database Schema (PostgreSQL)
```sql
-- Products table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2)
);

-- Order Items table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2)
);
```

## Sequence Diagrams

### Query Processing Flow
```
User -> Frontend: Submit natural language query
Frontend -> API Gateway: POST /query with question
API Gateway -> Lambda: Forward request
Lambda -> Bedrock: Generate SQL from natural language
Bedrock -> Lambda: Return SQL query
Lambda -> RDS: Execute SQL query
RDS -> Lambda: Return query results
Lambda -> Bedrock: Generate human-readable response
Bedrock -> Lambda: Return formatted answer
Lambda -> API Gateway: Return response with SQL and answer
API Gateway -> Frontend: Forward response
Frontend -> User: Display both SQL and human-readable answer
```

## Security Considerations

1. **IAM Roles**: Least privilege access for Lambda functions
2. **VPC Configuration**: RDS in private subnets
3. **API Security**: API Gateway with appropriate throttling
4. **Data Validation**: Input sanitization and SQL injection prevention
5. **Secrets Management**: Database credentials in AWS Secrets Manager

## Performance Considerations

1. **Connection Pooling**: Efficient database connections in Lambda
2. **Caching**: Consider caching common queries
3. **Timeout Handling**: Appropriate timeouts for Bedrock and database calls
4. **Error Handling**: Graceful degradation and retry logic

## Sample Analytics Questions

The system will be designed to handle these types of questions:

1. "What are the top 5 selling products this month?"
2. "Show me revenue trends for the last 6 months"
3. "Which customers have spent the most money?"
4. "What's the average order value by product category?"
5. "How many orders were placed last week?"
6. "Which products have the highest profit margins?"
7. "Show me seasonal sales patterns"
8. "What are the most popular product categories?"

## Technology Stack

- **Frontend**: React, HTML5, CSS3, JavaScript
- **Backend**: Node.js (Lambda runtime)
- **Database**: PostgreSQL (Amazon RDS)
- **AI/ML**: Amazon Bedrock (Claude Sonnet)
- **Infrastructure**: AWS CDK (TypeScript)
- **API**: Amazon API Gateway (REST)
- **Hosting**: Amazon S3 + CloudFront
- **Authentication**: AWS Cognito (if required)