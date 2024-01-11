# SQL Exploratory Data Analysis in VSCode

## Overview
This VSCode repository contains SQL queries for conducting exploratory data analysis on a fictional dataset of invoices using PostgreSQL. These queries cover diverse aspects, including feature engineering, branch performance, customer insights, product line analysis, payment method trends, and temporal analysis. They aim to provide valuable insights into sales trends, customer behavior, and other pertinent aspects of the dataset.

## Prerequisites
- **PostgreSQL**: Ensure PostgreSQL is installed either locally or on a remote server.
- **Database Setup**: Create a database named 'invoices' containing the necessary tables.

## Setup
1. Open VSCode.
2. Connect to your PostgreSQL database.
3. Copy and paste the provided queries into your SQL editor.

## Feature Engineering
- **Time of Day Transactions Took Place**: Derives and adds a 'time_of_day' column.
- **Day of Week Transaction Was Made**: Adds a 'day_of_week' column.
- **Month of Transactions**: Adds a 'month_name' column.

## Branch Performance
- **Total Sales of Each Branch Month-over-Month**: Compares total sales of each branch.
- **Highest Average Transaction Value by Branch**: Identifies the branch with the highest average transaction value.
- **Sales Figures for Each Branch by Day of the Week**: Analyzes sales variations for each branch.
- **Product Line Contribution for Normal vs. Member Customers**: Examines product lines contributing most to purchases for Normal and Member customers.

## Customer Insights
- **Distribution of Customer Types Across Branches**: Shows the distribution of customer types (Normal vs. Member) across different branches.
- **Product Lines Attracting Higher Ratio of Member Customers**: Identifies product lines with a higher ratio of Member customers.
- **Payment Method Popularity Changes Within Branches and Product Lines**: Explores seasonal changes in payment method popularity.

## Product Line Analysis
- **Product Line Growth in Sales Over Months**: Determines which product line shows the highest growth in sales over the months.
- **Seasonality in Sales of Specific Product Lines**: Investigates seasonality in the sales of specific product lines.
- **Variance in Unit Prices Within Each Branch and Product Line**: Identifies the product line with the highest variance in unit prices within each branch.

## Payment Method Trends
- **Distribution of Payment Methods Across Months and Days of the Week**: Analyzes the distribution of payment methods over time.
- **Preferred Payment Method Changes Over Time Within Each Branch**: Explores changes in preferred payment methods within each branch.

## Temporal Analysis
- **Times of Day and Days of the Week with Higher Sales Volume**: Identifies specific times of the day or days of the week with higher sales volume.
- **Sales Peaking at Specific Times During Weekdays in Each Branch**: Examines if sales tend to peak at specific times during weekdays in each branch.
- **Correlation Between Time of Day and Average Quantity of Products Purchased**: Explores the correlation between time of day and the average quantity of products purchased.
- **Months or Days When Specific Product Lines Show Surge or Drop in Sales**: Identifies specific months or days when particular product lines show a surge or drop in sales.
- **Impact of Time of Year on Average Transaction Value Considering Seasonal Trends**: Analyzes whether the time of year impacts the average transaction value.

Feel free to customize or modify the queries to suit your specific dataset or analysis requirements.

