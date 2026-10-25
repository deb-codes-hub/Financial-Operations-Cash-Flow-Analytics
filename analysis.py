import pandas as pd
import numpy as np
from pathlib import Path

DATA = Path("financial_transactions.csv")
OUT = Path("outputs")
OUT.mkdir(exist_ok=True)

df = pd.read_csv(DATA, parse_dates=["Date"])

revenue = df.loc[df.Transaction_Type == "Revenue", "Amount_INR"].sum()
expense = df.loc[df.Transaction_Type == "Expense", "Amount_INR"].sum()
receivables = df.loc[df.Transaction_Type == "Receivable", "Amount_INR"].sum()
payables = df.loc[df.Transaction_Type == "Payable", "Amount_INR"].sum()

kpis = pd.DataFrame({
    "KPI": [
        "Total Revenue",
        "Total Operating Expense",
        "Revenue - Expense",
        "Receivables",
        "Payables",
        "Gross Operating Margin Proxy"
    ],
    "Value_INR": [
        revenue, expense, revenue-expense, receivables, payables,
        (revenue-expense)/revenue if revenue else np.nan
    ]
})
kpis.to_csv(OUT/"kpis.csv", index=False)

monthly = (
    df.assign(Month=df["Date"].dt.to_period("M").astype(str))
      .groupby(["Month","Transaction_Type"])["Amount_INR"]
      .sum()
      .unstack(fill_value=0)
      .reset_index()
)
for c in ["Revenue","Expense","Receivable","Payable"]:
    if c not in monthly.columns:
        monthly[c] = 0
monthly["Net_Cash_Flow_Proxy"] = monthly["Revenue"] - monthly["Expense"]
monthly["Expense_Variance_vs_5pct_Buffer"] = monthly["Expense"] - monthly["Expense"]*1.05
monthly.to_csv(OUT/"monthly_financials.csv", index=False)

dept = (
    df[df["Transaction_Type"].isin(["Expense","Payable"])]
    .groupby("Department")["Amount_INR"].sum()
    .sort_values(ascending=False)
    .reset_index()
    .rename(columns={"Amount_INR":"Spend_INR"})
)
dept["Spend_Share"] = dept["Spend_INR"] / dept["Spend_INR"].sum()
dept.to_csv(OUT/"department_spend.csv", index=False)

ar = (
    df[df["Transaction_Type"]=="Receivable"]
    .groupby("Status")["Amount_INR"].agg(["count","sum"])
    .reset_index()
    .rename(columns={"count":"Items","sum":"Amount_INR"})
)
ar.to_csv(OUT/"receivables_aging.csv", index=False)

vendor = (
    df[df["Transaction_Type"]=="Payable"]
    .groupby("Vendor")["Amount_INR"].sum()
    .sort_values(ascending=False)
    .head(10)
    .reset_index()
    .rename(columns={"Amount_INR":"Payable_INR"})
)
vendor.to_csv(OUT/"top_payable_vendors.csv", index=False)

print("Analysis complete.")
print(kpis)
