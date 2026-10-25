# Financial Operations & Cash Flow Analytics

## Purpose
A software-only finance operations project designed for a Fin Ops / Business Finance internship.
The dataset is synthetic and is intentionally modeled around a growing MedTech operations business
with manufacturing, R&D, sales, operations, finance and customer-support transactions.

**Important:** This project does NOT use Morphle Labs proprietary data.

## Business questions answered
1. How are revenue and operating expenses trending month over month?
2. Which departments drive the largest operational spend?
3. What is the open/overdue receivables exposure?
4. Which vendors account for the largest payable balances?
5. How does actual expense compare with a simple budget buffer?
6. What are the main financial KPIs management should monitor?

## Tech stack
- Python: Pandas, NumPy
- SQL: aggregation, CASE statements, CTEs
- Excel: KPI reporting, budget variance, AR aging
- Power BI: recommended dashboard layer

## Files
- financial_transactions.csv — 24,000 synthetic transactions
- analysis.py — automated KPI and finance analysis
- financial_operations_queries.sql — SQL schema + analytical queries
- Financial_Operations_Analytics.xlsx — ready-made workbook/dashboard
- README.md — project documentation

## How to run
1. Install Python 3.10+.
2. Install dependencies:
   pip install pandas numpy
3. Run:
   python analysis.py
4. Open Financial_Operations_Analytics.xlsx for the management view.

## Suggested Power BI dashboard
Page 1 — Executive Finance:
- Revenue
- Operating Expense
- Net Cash Flow Proxy
- Open Receivables
- Overdue Receivables
- Monthly Revenue vs Expense

Page 2 — Cost & Operations:
- Spend by Department
- Spend by Category
- Top Vendors
- Region-wise expense

Page 3 — Working Capital:
- AR status
- Overdue receivables
- Payable status
- Vendor concentration

## Interview explanation
"I built a synthetic financial operations analytics system for a MedTech-style business.
I modeled transaction data across revenue, expenses, receivables and payables, then used SQL
and Python to calculate monthly KPIs, department-level spend, receivables aging and vendor
concentration. I also built an Excel management dashboard and budget-variance analysis.
The goal was to demonstrate how finance teams can turn transaction data into operational
and cash-flow decisions."

## Resume bullets
- Built a financial operations analytics pipeline on 24K synthetic transactions using Python, SQL and Excel, tracking revenue, expenses, receivables, payables and monthly cash-flow KPIs.
- Developed SQL-based KPI, department-spend, vendor-concentration and AR-aging analyses to identify working-capital exposure and operational cost drivers.
- Created an Excel management dashboard with monthly trend analysis and budget-variance reporting to support finance and operations decision-making.

## Honest project framing
Use "synthetic dataset" in your README/project discussion. Do not claim that the numbers are
Morphle's actual financial data.
