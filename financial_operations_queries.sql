-- Financial Operations & Cash Flow Analytics
-- Synthetic project dataset; no proprietary Morphle data is used.

CREATE TABLE financial_transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    transaction_date DATE,
    department VARCHAR(50),
    category VARCHAR(60),
    vendor VARCHAR(100),
    region VARCHAR(40),
    transaction_type VARCHAR(30),
    amount_inr DECIMAL(18,2),
    status VARCHAR(30)
);

-- 1. Monthly revenue, expense and net operating cash flow proxy
SELECT
    DATE_TRUNC('month', transaction_date) AS month,
    SUM(CASE WHEN transaction_type = 'Revenue' THEN amount_inr ELSE 0 END) AS revenue,
    SUM(CASE WHEN transaction_type = 'Expense' THEN amount_inr ELSE 0 END) AS expenses,
    SUM(CASE WHEN transaction_type = 'Revenue' THEN amount_inr ELSE 0 END)
      - SUM(CASE WHEN transaction_type = 'Expense' THEN amount_inr ELSE 0 END) AS net_cash_flow_proxy
FROM financial_transactions
GROUP BY 1
ORDER BY 1;

-- 2. Department-wise spending
SELECT
    department,
    SUM(amount_inr) AS total_spend
FROM financial_transactions
WHERE transaction_type IN ('Expense','Payable')
GROUP BY department
ORDER BY total_spend DESC;

-- 3. Vendor concentration
SELECT
    vendor,
    SUM(amount_inr) AS payable_value
FROM financial_transactions
WHERE transaction_type = 'Payable'
GROUP BY vendor
ORDER BY payable_value DESC
LIMIT 10;

-- 4. Accounts receivable aging proxy
SELECT
    status,
    COUNT(*) AS invoice_count,
    SUM(amount_inr) AS amount_inr
FROM financial_transactions
WHERE transaction_type = 'Receivable'
GROUP BY status
ORDER BY amount_inr DESC;

-- 5. Overdue receivables by region
SELECT
    region,
    COUNT(*) AS overdue_items,
    SUM(amount_inr) AS overdue_amount
FROM financial_transactions
WHERE transaction_type = 'Receivable'
  AND status = 'Overdue'
GROUP BY region
ORDER BY overdue_amount DESC;

-- 6. Monthly budget variance example.
-- Replace the budget CTE with actual approved budgets in a real organization.
WITH monthly_actuals AS (
    SELECT
        DATE_TRUNC('month', transaction_date) AS month,
        SUM(CASE WHEN transaction_type='Expense' THEN amount_inr ELSE 0 END) AS actual_expense
    FROM financial_transactions
    GROUP BY 1
),
budgets AS (
    SELECT month, actual_expense * 1.05 AS budget_expense
    FROM monthly_actuals
)
SELECT
    a.month,
    a.actual_expense,
    b.budget_expense,
    a.actual_expense - b.budget_expense AS variance
FROM monthly_actuals a
JOIN budgets b ON a.month = b.month
ORDER BY a.month;
