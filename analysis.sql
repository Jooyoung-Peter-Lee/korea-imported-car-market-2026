-- 1. 월별 시장 규모와 전년 동월 대비 성장률
SELECT month,
       total_2026,
       total_2025,
       ROUND(100.0 * (total_2026 - total_2025) / total_2025, 1) AS yoy_pct
FROM monthly_totals
ORDER BY month;

-- 2. 브랜드별 월간 점유율 (JOIN)
SELECT b.month,
       b.brand,
       b.units,
       ROUND(100.0 * b.units / t.total_2026, 1) AS share_pct
FROM brand_monthly b
JOIN monthly_totals t ON t.month = b.month
ORDER BY b.month, b.units DESC;

-- 3. 브랜드별 전월 대비 증감 (윈도우 함수 LAG)
SELECT month,
       brand,
       units,
       units - LAG(units) OVER (PARTITION BY brand ORDER BY month) AS mom_change
FROM brand_monthly
WHERE brand <> 'Others'
ORDER BY brand, month;

-- 4. 월별 브랜드 순위 (윈도우 함수 RANK)
SELECT month, brand, units,
       RANK() OVER (PARTITION BY month ORDER BY units DESC) AS rank_in_month
FROM brand_monthly
WHERE brand <> 'Others'
ORDER BY month, rank_in_month;

-- 5. 1~9월 누적과 누적 점유율 (서브쿼리)
SELECT brand,
       SUM(units) AS ytd_units,
       ROUND(100.0 * SUM(units) / (SELECT SUM(total_2026) FROM monthly_totals), 1) AS ytd_share_pct
FROM brand_monthly
GROUP BY brand
ORDER BY ytd_units DESC;

-- 6. 테슬라 vs BMW+벤츠 합산 (조건부 집계)
SELECT month,
       SUM(units) FILTER (WHERE brand = 'Tesla')                    AS tesla,
       SUM(units) FILTER (WHERE brand IN ('BMW','Mercedes-Benz'))   AS bmw_benz
FROM brand_monthly
GROUP BY month
ORDER BY month;

-- 7. 전기차 비중 (NULL 처리)
SELECT month,
       ev_units_2026,
       ROUND(100.0 * ev_units_2026 / total_2026, 1) AS ev_share_pct
FROM monthly_totals
WHERE ev_units_2026 IS NOT NULL
ORDER BY month;
