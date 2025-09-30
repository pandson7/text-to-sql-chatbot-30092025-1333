# Text-to-SQL Conversational Chatbot

A conversational chatbot that converts natural language questions into SQL queries and executes them against a product orders database. Built using AWS services including Amazon Bedrock, RDS PostgreSQL, Lambda, API Gateway, and React frontend.

## Architecture

![Architecture Diagram](generated-diagrams/text-to-sql-architecture.png)

## Features

- **Natural Language Processing**: Convert plain English questions into SQL queries using Amazon Bedrock (Claude Sonnet)
- **Real-time Query Execution**: Execute generated SQL queries against a PostgreSQL database
- **Dual Response Format**: Display both human-readable answers and the executed SQL queries
- **Interactive Chat Interface**: Modern React-based chat UI with sample questions
- **Sample Analytics Data**: Pre-populated database with product orders, customers, and sales data

## Sample Questions

- "What are the top selling products?"
- "Show me revenue by category"
- "Who are the top customers by spending?"
- "What products were sold in the last month?"
- "How many orders were placed this week?"

## Technology Stack

### Backend
- **Amazon Bedrock**: Claude Sonnet model for natural language to SQL conversion
- **AWS Lambda**: Serverless query processing function
- **Amazon RDS**: PostgreSQL database for product orders data
- **API Gateway**: REST API endpoints
- **AWS Secrets Manager**: Secure database credential storage
- **VPC**: Secure networking for database access

### Frontend
- **React**: Modern chat interface with TypeScript
- **Amazon S3**: Static website hosting
- **Amazon CloudFront**: CDN for global content delivery

### Infrastructure
- **AWS CDK**: Infrastructure as Code using TypeScript
- **GitHub**: Source code repository

## Database Schema

The system uses a PostgreSQL database with the following tables:

- `products`: Product information (ID, name, category, price)
- `customers`: Customer details (ID, name, email)
- `orders`: Order records (ID, customer, date, total amount)
- `order_items`: Individual items in orders (order ID, product ID, quantity, prices)

## Deployment

### Prerequisites
- AWS CLI configured with appropriate permissions
- Node.js and npm installed
- AWS CDK CLI installed

### Deploy Infrastructure
```bash
cd cdk-app
npm install
npm run build
npx cdk deploy
```

### Deploy Frontend
```bash
cd frontend
npm install
npm run build
aws s3 sync build/ s3://your-bucket-name/
```

## API Endpoints

- `POST /query`: Submit natural language queries
- `GET /health`: Health check endpoint

### Example API Usage

```bash
curl -X POST https://your-api-url/prod/query \
  -H "Content-Type: application/json" \
  -d '{"query": "What are the top selling products?"}'
```

## Project Structure

```
text-to-sql-chatbot-30092025-1333/
├── specs/                          # Project specifications
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
├── cdk-app/                        # AWS CDK Infrastructure
│   ├── lib/
│   ├── lambda/
│   └── bin/
├── frontend/                       # React Frontend
│   ├── src/
│   ├── public/
│   └── build/
├── generated-diagrams/             # Architecture diagrams
├── database-setup.sql              # Database schema and sample data
└── deployment-outputs.md           # Deployment information
```

## Live Demo

- **Frontend URL**: https://d2000gv6mffwnv.cloudfront.net
- **API URL**: https://lra1bn2v94.execute-api.us-east-1.amazonaws.com/prod/

## Development Process

This project was built using a specification-driven development approach:

1. **Requirements Phase**: Defined user stories and acceptance criteria
2. **Design Phase**: Created technical architecture and system design
3. **Implementation Phase**: Built infrastructure, backend, and frontend components
4. **Testing Phase**: Validated functionality with sample queries
5. **Deployment Phase**: Deployed to AWS and created documentation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built using AWS services and best practices
- Follows AWS Well-Architected Framework principles
- Uses specification-driven development methodology