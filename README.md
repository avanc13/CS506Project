# Boston Bus Equity Project

video link: https://www.youtube.com/watch?v=CNgK63r3PCk

**Description of the project.**

This project aims to analyze disparities in bus service performance and equity in the city of Boston using MBTA ridership, reliability, and passenger service data, focusing on delays and excess trip time. We will use operational features, such as routes, schedule vs. actual times, ridership levels, etc. and demographic features such as race, car access, age, and income (from ACS Census Data) to predict the likelihood of trip delays. We are primarily focused on predictive modeling (classification/regression). We want to identify which communities within Boston are most disproportionately affected by potentially unreliable service as well as forecast ridership volume and delay for future bus routes.

---
## How to Reproduce Results

### 1. Environment Setup
This project requires Python 3.9+ and the following packages:

- pandas
- numpy
- scikit-learn
- matplotlib
- openpyxl
- joblib
- pytest

Install dependencies with:

```bash
pip install -r requirements.txt
```
---
## Data

Download the following datasets and place them in a data/ directory:

cleaned_mbta_ridership_2016_2024.csv

Source: https://mbta-massdot.opendata.arcgis.com/
- run notebooks/Ridership/data_vis/combining_data.ipynb -- to get the cleaned csv

MBTA_systemwide_survey_results_by_station_and_line.xlsx

Source: https://www.ctps.org/dv/mbtasurvey2018/index.html#navButton

run: equity.ipynb for model and visualizations
## **Ridership Data**

Datasets: Using ridership data collected from:  
https://mbta-massdot.opendata.arcgis.com/datasets/7acd353c1a734eb8a23caf46a0e66b23_0/explore

Data contains ridership information from 2016–2024, seasons: Fall (all years) (spring 2024 only).

---

### **Key visual Findings: combining_data.ipynb**

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
  <figcaption>Top 10 routes dominate overall ridership, especially routes serving transit-dependent neighborhoods.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/load_heatmap.png" width="60%">
  <figcaption>Crowding heatmap (avg onboard load) reveals persistent peak-hour congestion on core parts (Routes 28, 66, 1).</figcaption>
</figure>

---

## **Predictive Modeling Methods** (Mideterm Report): predictve_ridership.ipynb

Built a baseline ridership forecasting model, using:

- Model Type: Random Forest Regressor (why? handles nonlinear patterns, robust to noise as opposed to single decsiion tree)
- Features: route_id, hour, day_type_name, season, year
- Target: boardings (aggregate per route-hour-season-year)
- Preprocessing: OneHot encoding of categorical variables (used Pipeline + ColumnTransformer in SKlearn)
- Train/Test Split: Chronological split → Train = 2016–2021, Test = 2022–2024

**Key Insights:**
- Ridership is highly predictable using only temporal + route features.
- The model generalizes well to post-pandemic years.
- MAE: 40.011344986012304
- R²: 0.7489096543835372

<figure style="text-align:center;">
  <img src="images/actual_predicted_ridership.png" width="55%">
</figure>

<figure style="text-align:center;">
  <img src="images/route_28.png" width="55%">
</figure>

---

**What have we learned so far? (midterm)**

There is enough signal in the features to predict ridership volume for the post pandemic years. This baseline model explains ~75% of the variability in the target–indicating that the structure of our data is learnable and generalizable. 

---

**New Modeling- Ridership Forecasting with Demographics + Equity Analysis (equity.ipynb)**
Goal: Improve forecast accuracy and test whether errors are systematically related to demographic characteristics of riders.

Added Features (route-level survey percentages):
pct_minority, pct_low_income, pct_zero_vehicle, pct_limited_english, pct_youth, pct_senior

Model: RandomForestRegressor (same pipeline structure; demographics added as numeric features)

Results (test):
- MAE ≈ 20.38
- R² ≈ 0.92
<figure style="text-align:center;">
  <img src="images/predicted_boardings.png" width="55%">
</figure>

This indicates that demographic variables capture additional structure in ridership patterns (especially across post-pandemic years), beyond time + route alone.

---

**Equity / Error Analysis**
After predicting on the test set, I compute residuals:
- residual = predicted − actual
- residual < 0 → underprediction

I then evaluate whether residuals trend with demographics (like pct_minority). A negative trend indicates underprediction for higher-minority routes--otherwise the residuals would be pretty uniform.

<figure style="text-align:center;">
  <img src="images/residuals_vs_pct_minority.png" width="55%">
  <figcaption>Residuals vs percent minority on test set. Negative trends indicate underprediction on higher-minority routes.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/pct_minority_resid_line.png" width="55%">
  <figcaption>Residuals vs percent minority on test set. Negative trends indicate underprediction on higher-minority routes.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/colored.png" width="55%">
  <figcaption>Residuals vs percent minority on test set. Negative trends indicate underprediction on higher-minority routes.</figcaption>
</figure>

---

**Fairness-Style Classifier (Error Predictability)**
To test whether underprediction is systematic rather than random, I train a classifier to predict whether an observation is underpredicted, using demographics as inputs.

- Label: underpredicted (based on residual threshold)
- Model: Logistic Regression (interpretable)
- Evaluation: ROC-AUC

Result: ROC-AUC ≈ 0.84
<figure style="text-align:center;">
  <img src="images/auroc.png" width="55%">
</figure>

This suggests underprediction is predictable from demographics, meaning model errors are structured and associated with rider demographics.

What We Learned:
Baseline forecasting works: route + time features predict ridership well (R² ~ 0.75).

Demographics improve predictions substantially (R² ~ 0.92), suggesting ridership patterns are strongly tied to structural rider characteristics (car access, minority share, etc.).
Errors are not uniform: residual analysis indicates systematic underprediction on higher-minority routes.

Underprediction is predictable from demographic variables (AUC ~ 0.84), supporting the idea that errors are structured and equity-relevant.

---

**Limitations**

Demographics are from 2015–2017 and applied across 2016–2024. Post-COVID ridership composition may have shifted.
Demographics are route-level averages, not stop-level; within-route heterogeneity is not captured.

Ridership estimates include sampling noise and inconsistent coverage (sample_size/sample_count), which can affect both prediction and residual analysis.

This analysis is correlational, not really causal: demographic features may proxy other unobserved factors (service frequency, land use, employment patterns, there are many other factros).


## **Reliability Data**

<h3><u>Data Processing:</u></h3>

The initial analysis was performed on the "MBTA Commuter Rail, Bus, Rapid Transit Reliability" dataset. The goal of our processing was to isolate a clean, analysis-ready dataset focused specifically on bus service reliability for the period relevant to our project (2018-present).

In the context of this project, reliability is one of the most important metrics to determine service quality. 

**Reliability Metric:** percentage of observed bus trips that were both on time (schedule adherence) and properly spaced (headway). 

---

The following processing pipeline was executed:

- <u>Data loading</u>: The raw CSV data was loaded into a pandas DataFrame.

- **Mode filtering:** The dataset was filtered to retain only records where the mode_type was 'Bus'. All 'Rail' and 'Commuter Rail' data was discarded.

- **Time filtering:** The data was filtered to include only records where the service_date was on or after January 1, 2018, establishing our pre- and post-pandemic analysis window.

- **Handling missing values:**
  - ‘cancelled_numerator’: Null (NaN) values in this column were filled with 0, based on the assumption that a missing value indicates zero observed cancellations for that service block.
  - ‘otp_numerator / otp_denominator’: Rows with null values in either of these essential columns were dropped, as reliability cannot be calculated without them.

- <u>Feature Engineering (Reliability Metric)</u>:  
  The primary dependent variable, reliability_metric, was engineered by dividing otp_numerator by otp_denominator.

This metric represents the percentage of observed bus trips that met service standards. This metric serves as our primary proxy for service quality and the inverse of delay risk.
The resulting cleaned dataset contains a daily reliability score for each unique bus route (gtfs_route_short_name) and service period (peak_offpeak_ind).

---

<h3><u>Preliminary Visualizations</u></h3>

We produced a system-wide reliability time series. This plot shows average reliability across all bus routes, aggregated monthly.

The plot displays two lines: one for 'PEAK' (weekday rush hour) and one for 'OFF_PEAK' (all other times). A vertical red line marks the start of the COVID-19 pandemic in March 2020.

<figure style="text-align:center;">
  <img src="images/avg_monthly_reliability.png" width="55%">
</figure>

<figure style="text-align:center;">
  <img src="images/top_5_reliability.png" width="55%">
</figure>

---

**Key insights:**
- Infrastructure is a decisive factor, the top performing routes, such as the SL2 and SL5, are Bus Rapid Transit (BRT) routes that operate in dedicated, bus only lanes. Their high performance is not random but a direct result of infrastructure that physically separates them from car traffic.
- The performance gap between PEAK and OFF_PEAK is minimal or non-existent. This is a critical finding, giving us hints that with proper infrastructure, it is possible to run a highly reliable bus service even during rush hour.
- Unlike the system-wide plot, these top performing routes showed almost no change in reliability after the March 2020 pandemic line. Their performance was already high and remained high, proving they are largely decoupled from the traffic congestion that plagues other routes.

---

**Results:**
- Service disparities are evident: The analysis confirms that performance is not evenly distributed. The ability to identify the low and high performing routes is the first crucial step in linking service quality to specific communities or demographics. 
- "Rush hour" is less reliable: The data confirms that PEAK service is consistently less reliable than OFF_PEAK service. This implies that commuters, who are most likely to travel during PEAK hours, are disproportionately affected by delays.
- Reliability shows a clear inversely correlation with traffic: The pandemic provided the situation where reliability increased as traffic vanished. This supports the hypothesis that delays on low-performing routes are primarily driven by congestion from mixed traffic.

---

## **MBTA Bus Delay & Passenger Wait Time Analysis (2018–2024)**

<h3><u>Overview</u></h3>

This report summarizes MBTA bus arrival and departure data from 2018–2024 to quantify service reliability, passenger wait times, and delay patterns across selected high-ridership routes. The analysis integrates large-scale data cleaning, feature engineering, exploratory data analysis (EDA), and machine learning models to predict bus delays and evaluate system performance.

Key goals of include:
- Understanding how long passengers wait for buses (on-time vs. delayed)
- Measuring average delay patterns by route and year
- Visualizing end-to-end travel time behavior
- Building classification and regression models to predict delays
- Evaluating model performance using standard ML metrics
- Target routes were selected to ensure consistent data availability and meaningful comparisons across years.

<h3><u>Data Cleaning and Filtering</u></h3>

Raw MBTA Bus Arrival/Departure CSV files vary significantly across years in column naming, formatting, and data completeness. A standardized preprocessing pipeline was developed to ensure consistency.

Cleaning steps:
- Standardized column names across all years (e.g., ```route_id```, ```scheduled```, ```actual```, ```headway```)
- Dropped unused or inconsistently reported fields
- Converted timestamps to datetime objects
- Computed delay values in minutes
- Filtered data to a fixed set of target routes
- Removed corrupted, incomplete, or malformed rows

<h3><u>Feature Engineering</u></h3>

Several features were engineered to support both EDA and modeling:
- Delay (minutes): Difference between scheduled and actual arrival time
- On-time vs. Delayed label: Binary classification based on a 5-minute threshold
- Passenger wait time (minutes): Estimated wait time experienced by riders
- Scheduled vs. actual headways
- Year extraction from service dates
- Route-level aggregations

---

**Preliminary Visualizations:**

<h3><u>Average Bus Delay per Route by Year</u></h3>

Average delay was computed for each route-year combination to assess long-term reliability trends.
This analysis:
- Highlights routes with persistent delay issues
- Identifies year-over-year performance changes
- Supports fairness by ensuring all routes are represented consistently

<figure style="text-align:center;">
  <img src="images/avg_delay_route_and_yr_2.png" width="60%">
  <figcaption>Average delay by route and year visualized using target routes from the Livable Streets report.</figcaption>
</figure>

<h3><u>Heatmap: End-to-End Travel Time per Route</u></h3>

A heatmap visualization was created to show end-to-end travel time patterns across routes and years.
This visualization helps:
- Identify routes with consistently longer travel times
- Compare relative performance across the network

<figure style="text-align:center;">
  <img src="images/e2e_travel_time.png" width="60%">
  <figcaption>The plot shows consistent travel times across the years observed, with route 14 having the longest of travel times end to end.</figcaption>
</figure>

<h3><u>Average Passenger Wait Time (On-Time vs. Delayed)</u></h3>
Passenger wait time was analyzed separately for on-time and delayed buses.

- On-time bus: Arrival within 5 minutes of the scheduled time
- Delayed bus: Arrival more than 5 minutes after the scheduled time

Key Insight
On-time wait time represents the expected wait under normal service, while delayed wait time reflects excess passenger burden caused by service disruptions. Comparing the two isolates the passenger-level impact of delays beyond scheduling assumptions.

<figure style="text-align:center;">
  <img src="images/avg_pass_wait_time.png" width="60%">
  <figcaption>The plot shows a decline in wait time across all routes post pandemic with a spike in delays calculated in 2024.</figcaption>
</figure>

---

**Next Steps**

We will expand from route-level ridership forecasting to stop-level equity analysis, incorporating service reliability and neighborhood demographics.

**Modeling Enhancements**

<h4><u>Classification Model: Random Forest</u></h4>
A Random Forest classifier was trained to predict whether a bus arrival would be on-time or delayed. Evaluation included:
- Confusion matrix analysis
- Accuracy, precision, recall, and error inspection

<figure style="text-align:center;">
  <img src="images/ran_for_cm.png" width="60%">
  <figcaption>Confusion matrix for the binary classification model predicting bus arrival status (on-time vs. delayed). The matrix summarizes correct and incorrect predictions across the test dataset, highlighting the model’s ability to distinguish between delayed and on-time bus arrivals.</figcaption>
</figure>

The classification model achieves an overall accuracy of 72%
- Class 0 (On-time buses):
  - Precision: 0.67
  - Recall: 0.65
  - F1-score: 0.66
  - The model correctly identifies a majority of on-time arrivals but occasionally misclassifies delayed buses as on-time, reflecting overlap in operational conditions near the delay threshold.
- Class 1 (Delayed buses):
  - Precision: 0.75
  - Recall: 0.77
  - F1-score: 0.76
  - Stronger performance is observed for delayed buses, suggesting the model is more effective at detecting delay-related patterns in the data.

The confusion matrix shows:
- 10,044 true on-time predictions
- 16,618 true delayed predictions
- 5,409 false positives (on-time predicted as delayed)
- 4,991 false negatives (delayed predicted as on-time)

---

**Regression Models**

<h3><u>Linear Regression</u></h3>
- MAE ≈ 3.02
- R^2 score ≈ 0.29

The linear regression model yields an MAE of approximately 3.02 minutes, meaning that on average, predictions are about three minutes away from the actual delay value. The R² score of 0.29 indicates that the model explains roughly 29% of the variance in bus delays.

<h3><u>Gradient Boosting Regression</u></h3>
- MAE ≈ 2.95
- R^2 score ≈ 0.34

The gradient boosting regression model achieves a mean absolute error (MAE) of approximately 2.95 minutes, indicating improved predictive accuracy compared to the linear regression baseline. The R² score of 0.34 shows that the model explains roughly 34% of the variance in bus delay duration.

<h3><u>XGBoost Regression</u></h3>
- MAE ≈ 2.85
- R^2 score ≈ 0.36

The XGBoost regression model achieves the strongest performance among all evaluated models, with a mean absolute error (MAE) of approximately 2.85 minutes and an R² score of 0.36. This indicates that the model explains roughly 36% of the variance in bus delay duration.

<h3><u>Residual Plot: XGBoost Regression</u></h3>

<figure style="text-align:center;">
  <img src="images/residual_plot_xgboost.png" width="60%">
  <figcaption>Residuals are centered around zero with increasing variance for larger predicted delays, indicating reasonable fit with limitations for extreme cases.</figcaption>
</figure>

<figure style="text-align:center;">
  <img src="images/p_v_a_xgboost.png" width="60%">
  <figcaption>Predictions closely track actual delays for typical conditions but diverge for extreme delays.</figcaption>
</figure>

<h4><u>Conclusion</u></h4>

This section provides an analysis of MBTA bus performance from 2018–2024, combining data cleaning, feature engineering, visualization, and machine learning to evaluate service reliability and passenger wait times. Results show meaningful differences between on-time and delayed service, with delays imposing additional burden on riders. Classification and regression models demonstrate reasonable predictive performance for real-world transit data, with XGBoost achieving the best results (MAE ≈ 2.85 minutes, R² ≈ 0.36).

