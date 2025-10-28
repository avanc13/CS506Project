# Boston Bus Equity Project

**Description of the project.**  
This project aims to analyze disparities in bus service performance and equity in the city of Boston using MBTA ridership, reliability, and passenger service data. We focus on delays and excess trip time. Using both operational features (routes, schedule adherence, demand) and demographic features (race, car access, age, income), we aim to predict the likelihood of trip delays.

We are primarily focused on predictive modeling (classification/regression) to:  
- **Identify communities disproportionately affected by unreliable service**
- **Forecast ridership volume and delay for future bus routes**

---

## **Ridership Data**

Datasets:  
MBTA Ridership (2016–2024)  
https://mbta-massdot.opendata.arcgis.com/datasets/7acd353c1a734eb8a23caf46a0e66b23_0/explore

Seasons included: Fall (all years), Spring (2024 only)

**Key Visual Findings** *(combining_data.ipynb)*

<figure style="text-align:center;">
  <img src="images/ridership_hour_day_type.png" width="55%">
  <figcaption>Hourly demand cycles clearly show AM (~7–9 AM) and PM (~3–6 PM) commuter peaks.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/total_ridership_year.png" width="55%">
  <figcaption>Pandemic impact: Systemwide ridership collapsed in 2020–2021 and has recovered by 2024.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/top_10_routes.png" width="65%">
  <figcaption>Top 10 routes dominate overall ridership, especially transit-dependent neighborhoods.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/load_heatmap.png" width="60%">
  <figcaption>Crowding heatmap reveals persistent peak-hour congestion on core corridors (Routes 28, 66, 1).</figcaption>
</figure>

---

## **Predictive Modeling Methods** *(predictive_ridership.ipynb)*

**Model:** Random Forest Regressor  
**Features:** route_id, hour, day_type_name, season, year  
**Target:** boardings per route-hour-season-year  
**Preprocessing:** One-Hot Encoding via scikit-learn Pipeline  
**Train/Test Split:** Chronological  
- Train: 2016–2021  
- Test: 2022–2024  

**Results:**
- MAE: 40.01
- R²: 0.7489
- Highly predictive — ~75% variability explained

<figure style="text-align:center;">
  <img src="images/actual_predicted_ridership.png" width="55%">
</figure>

<figure style="text-align:center;">
  <img src="images/route_28.png" width="55%">
</figure>

**Insights**  
- Ridership is predictable using only temporal + route features  
- Post-pandemic generalization is strong  

**Limitations**  
- Existing target aggregates across all stops → masks stop-level inequity  

**Future Target**  
P(delay > X min) at (stop, hour, route) + census demographics

---

## **Reliability Data**

<h3><u>Data Processing</u></h3>

Dataset: “MBTA Commuter Rail, Bus, Rapid Transit Reliability”

Steps taken:
- Filter to **Bus** mode only  
- Include service_date >= 2018  
- Handle missing values:  
  - Fill `cancelled_numerator` NaN → 0  
  - Drop rows missing reliability components  
- Engineer **reliability_metric** = otp_numerator / otp_denominator

Result: Daily reliability score per route and service period (peak/off-peak)

<h3><u>Preliminary Visualizations</u></h3>

<figure>
  <img src="images/avg_monthly_reliability.png" width="55%">
</figure>

<figure>
  <img src="images/top_5_reliability.png" width="55%">
</figure>

Key insights:
- Bus Rapid Transit routes (SL2, SL5) remain highly reliable due to **dedicated lanes**
- **Peak hours** are slightly less reliable than off-peak — commuters are impacted most
- Reliability **improves sharply** during the pandemic → congestion drives delays

---

## **Average Delay Data**

<h3><u>Overview</u></h3>

Routes cleaned and filtered to match MBTA public service; exclude inactive/internal routes.  
Metrics computed per route-year:
- Average departure delay
- Passenger wait time (headways)
- End-to-end travel time

<figure>
  <img src="images/avg_delay_route_and_yr.png" width="60%">
</figure>

---

## **Next Steps**

**Modeling Enhancements**
- Add stop-level features: load, headway, boarding counts  
- Predictive targets:  
  - P(delay > X min) per stop per trip  
  - Crowding risk on high-demand routes  

**Equity Evaluation**
- Compare delay exposure across socioeconomic groups
- Highlight inequities on priority routes (22, 28, 29, etc.)
- Identify most impacted neighborhoods











