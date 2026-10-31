# Korea Imported Car Market 2026 (Jan–Sep) — SQL + Tableau

Tesla became Korea's #1 imported car brand in 2026: 89,148 registrations Jan–Sep (31.9% share),
ahead of BMW (57,929, 20.7%). This project tracks how that shift happened month by month.

## Data
Source: KAIDA (Korea Automobile Importers & Distributors Association) monthly passenger-car
registration releases, as reported in Korean press (Jan–Sep 2026).

| File | Contents |
|---|---|
| `kaida_monthly_totals.csv` | Monthly market total 2026 vs 2025, EV units (where published) |
| `kaida_brand_monthly.csv` | Monthly units for Tesla, BMW, Mercedes-Benz, BYD, Others |

Notes
- February brand figures are derived from published year-to-date totals minus the other months.
- "Others" = monthly market total minus the four tracked brands.
- Brand sums were cross-checked against KAIDA's published YTD totals (Tesla 89,148, BMW 57,929).

## SQL (PostgreSQL)
- `schema.sql` — two tables with primary/foreign keys, plus `\copy` load commands
- `analysis.sql` — 7 queries: YoY growth, market share (JOIN), month-over-month change (LAG),
  monthly rank (RANK), YTD share (subquery), Tesla vs BMW+Benz (FILTER), EV share (NULL handling)

## Tableau dashboard
Tableau Public: [link]

## Key findings
- The market grew 24.1% YoY in Jan–Sep 2026 (279,729 vs 225,348).
- Tesla went from #3 in January (1,966) to #1 every month from February onward.
- Tesla alone outsold BMW and Mercedes-Benz combined in 4 of 9 months (Apr, May, Aug, Sep).
- EVs passed 50% of imported registrations in June (51.1%) and September (52.1%).

