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

---

## 대시보드 제작 가이드 (본인용, 제출 시 이 섹션은 삭제)

### 0. 준비 (20분)
1. Tableau Public 무료 설치 → public.tableau.com 가입
2. PostgreSQL에 `schema.sql` 실행 후 CSV 두 개 `\copy`로 적재
3. `analysis.sql` 쿼리 한 번씩 돌려보고 결과 캡처 (면접에서 설명용)

### 1. 데이터 연결 (10분)
- Tableau Public은 DB 직접 연결이 안 되므로 CSV로 연결
- `kaida_brand_monthly.csv` 연결 → `kaida_monthly_totals.csv`를 **month** 기준으로 관계(Relationship) 추가

### 2. 시트 4개 만들기
| 시트 | 차트 | 만드는 법 |
|---|---|---|
| ① KPI | 숫자 카드 3개 | 누적 등록대수, 테슬라 누적 점유율, 전년 대비 성장률 |
| ② 월별 브랜드 추이 | 라인 | 열: MONTH(month) / 행: SUM(units) / 색상: brand |
| ③ 브랜드 점유율 | 100% 누적 막대 | 행: SUM(units) → 퀵 테이블 계산 "구성 비율"(테이블 아래로) |
| ④ 전기차 비중 | 막대 + 라벨 | ev_units_2026 / total_2026 계산된 필드 |

계산된 필드 예시
- 점유율: `SUM([units]) / SUM([total_2026])`
- 전년비: `(SUM([total_2026]) - SUM([total_2025])) / SUM([total_2025])`

### 3. 대시보드 구성 (30분)
- 크기 1200×800 고정
- 상단 제목: "Tesla's Rise in Korea's Imported Car Market (2026)"
- 상단 KPI → 중간 라인 차트 크게 → 하단 점유율 + 전기차 비중 나란히
- 브랜드 필터를 "모든 시트에 적용"으로
- 테슬라 색상만 진하게, 나머지는 회색 계열 → 메시지가 한눈에 보이게
- 하단에 출처: "Source: KAIDA monthly registration data (Jan–Sep 2026)"

### 4. 게시
- 파일 → Tableau Public에 저장 → 링크를 이력서 연락처 줄과 이 README에 추가
- GitHub에 이 폴더 업로드 → 이력서 GitHub 링크로 사용

### 면접용 한 줄 설명
"KAIDA 공개 데이터를 PostgreSQL에 적재해 윈도우 함수로 브랜드별 순위·전월 대비 변화를 분석했고,
Tableau로 테슬라가 2월 이후 1위를 지킨 흐름과 전기차 비중 50% 돌파를 시각화했습니다."
