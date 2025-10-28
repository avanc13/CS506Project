# Boston Bus Equity Project

* **Description of the project.**

This project aims to analyze disparities in bus service performance and equity in the city of Boston using MBTA ridership, reliability, and passenger service data, focusing on delays and excess trip time. We will use operational features, such as routes, schedule vs. actual times, ridership levels, etc. and demographic features such as race, car access, age, and income (from ACS Census Data) to predict the likelihood of trip delays. We are primarily focused on predictive modeling (classification/regression). We want to identify which communities within Boston are most disproportionately affected by potentially unreliable service as well as forecast ridership volume and delay for future bus routes.

* **Ridership**  
Datasets: Using ridership data collected from: https://mbta-massdot.opendata.arcgis.com/datasets/7acd353c1a734eb8a23caf46a0e66b23_0/explore

Data contains ridership information from 2016-2024, seasons: Fall (all years) (spring 2024 only).

**Key visual Findings: combining_data.ipynb**
<figure>
  <img src="images/ridership_hour_day_type.png" width="45%">
  <figcaption>Hourly demand cycles clearly show AM (~7–9 AM) and PM (~3–6 PM) commuter peaks.</figcaption>
</figure>

![Pandemic impact: Systemwide ridership collapsed in 2020–2021 and has recovered by 2024.](images/total_ridership_year.png)

![Top 10 routes dominate overall ridership, especially routes serving transit-dependent neighborhoods.](images/top_10_routes.png)

![Crowding heatmap (avg onboard load) reveals persistent peak-hour congestion on core parts(Routes 28, 66, 1).](images/load_heatmap.png)

**Predictive Modeling Methods** (So Far): predictve_ridership.ipynb

Built a baseline ridership forecasting model, using:

Model Type: Random Forest Regressor (why? handles nonlinear patterns, robust to noise as opposed to single decsiion tree)
Features: route_id, hour, day_type_name, season, year
Target: boardings (aggregate per route-hour-season-year)
Preprocessing: OneHot encoding of categorical variables (used Pipeline + ColumnTransformer in SKlearn)
Train/Test Split: Chronological split → Train = 2016–2021, Test = 2022–2024

Key Insights: 
- Ridership is highly predictable using only temporal + route features.
- The model generalizes well to post-pandemic years.
- MAE: 40.011344986012304
- R²: 0.7489096543835372

!(images/actual_predicted_ridership.png)

!(images/actual_predicted_ridership.png)

![alt text](images/route_28.png)

What have we learned so far? 

There is enough signal in the features to predict ridership volume for the post pandemic years. This baseline model explains ~75% of the variability in the target–indicating that the structure of our data is learnable and generalizable. 

Limitations and Next Steps:
The current graph models total boardings per route per hour across ALL stops–good for macro-level ideas but not enough for stop level equity and noise. 

Future modeling target: combine boardings per stop, delay per stop, load per stop, and demographics to answer the question: 
P(delay > X) at Stop a, hour=7AM, weekday, Route 28











