# Boston Bus Equity Project

* **Description of the project.**

This project aims to analyze disparities in bus service performance and equity in the city of Boston using MBTA ridership, reliability, and passenger service data, focusing on delays and excess trip time. We will use operational features, such as routes, schedule vs. actual times, ridership levels, etc. and demographic features such as race, car access, age, and income (from ACS Census Data) to predict the likelihood of trip delays. We are primarily focused on predictive modeling (classification/regression), but might consider time-series analysis as a complimentary mode of analysis.  We want to identify which communities within Boston are most disproportionately affected by potentially unreliable service.

* **Clear goal(s) (e.g. Successfully predict the number of students attending lecture based on the weather report).**  
1. Analyze performance metrics: Ridership trends, average delays, wait times across all MBTA bus routes (pre pandemic to post pandemic–2018-present)  
2. Identify disparities in service reliability by comparing performance across neighborhoods, demographics, and track changes over time. Specifically, we will model **bus delay & ridership volume** outcomes as a function of **operational variables and neighborhood demographics** (described above).  
3. (with time permitting) Build predictive models to forecast:  
4. Delay risk (P\[delay \> X minutes\]), with some amount of confidence.  
5. Ridership volume per route/time bucket.

* **What data needs to be collected and how you will collect it (e.g. scraping xyz website or polling students).**

Ridership per route (including pre vs. post-pandemic changes) will be obtained using:

# MBTA Bus Ridership by Time Period, Season, Route/Line, and Stop \- Fall: [https://mbta-massdot.opendata.arcgis.com/datasets/7acd353c1a734eb8a23caf46a0e66b23\_0/explore](https://mbta-massdot.opendata.arcgis.com/datasets/7acd353c1a734eb8a23caf46a0e66b23_0/explore)

# MBTA Bus Ridership by Time Period Season Route/Line and Stop \- Spring 2020, 2021: [https://mbta-massdot.opendata.arcgis.com/datasets/adbe3a94edcd44259cfee2621ed9f3a7\_0/explore](https://mbta-massdot.opendata.arcgis.com/datasets/adbe3a94edcd44259cfee2621ed9f3a7_0/explore)

End-to-end travel time per route will take into account scheduled running time vs. observed running time by comparing schedule data to realtime vehicle positionary data. MBTA open performance pipeline will supplement these findings.

# MBTA Bus, Commuter Rail, & Rapid Transit Reliability: [https://mbta-massdot.opendata.arcgis.com/datasets/b3a24561c2104422a78b593e92b566d5\_0/explore](https://mbta-massdot.opendata.arcgis.com/datasets/b3a24561c2104422a78b593e92b566d5_0/explore)

Wait time and average delay across all routes have been redefined by the MBTA to alter what constitutes “on time” or “delayed”. This margin of error from scheduled windows has changed over the past two years to account for dropped trips in a new metric “Excess Trip Time”.

# MBTA Bus Arrival Departure Times 2018: [https://mbta-massdot.opendata.arcgis.com/datasets/d685ba39d9a54d908f49a2a762a9eb47/about](https://mbta-massdot.opendata.arcgis.com/datasets/d685ba39d9a54d908f49a2a762a9eb47/about)

# MBTA Bus Arrival Departure Times 2019: [https://mbta-massdot.opendata.arcgis.com/datasets/1bd340b39942438685d8dcdfe3f26d1a/about](https://mbta-massdot.opendata.arcgis.com/datasets/1bd340b39942438685d8dcdfe3f26d1a/about)

# MBTA Bus Arrival Departure Times 2020: [https://mbta-massdot.opendata.arcgis.com/datasets/4c1293151c6c4a069d49e6b85ee68ea4/about](https://mbta-massdot.opendata.arcgis.com/datasets/4c1293151c6c4a069d49e6b85ee68ea4/about)

# MBTA Bus Arrival Departure Times 2021: [https://mbta-massdot.opendata.arcgis.com/datasets/2d415555f63b431597721151a7e07a3e/about](https://mbta-massdot.opendata.arcgis.com/datasets/2d415555f63b431597721151a7e07a3e/about)

# MBTA Bus Arrival Departure Times 2022: [https://mbta-massdot.opendata.arcgis.com/datasets/ef464a75666349f481353f16514c06d0/about](https://mbta-massdot.opendata.arcgis.com/datasets/ef464a75666349f481353f16514c06d0/about)

# MBTA Bus Arrival Departure Times 2023: [https://mbta-massdot.openda](https://mbta-massdot.opendata.arcgis.com/datasets/b7b36fdb7b3a4728af2fccc78c2ca5b7/about)

# MBTA Bus Arrival Departure Times 2024: [https://mbta-massdot.opendata.arcgis.com/datasets/96c77138c3144906bce93d0257531b6a/about](https://mbta-massdot.opendata.arcgis.com/datasets/96c77138c3144906bce93d0257531b6a/about)

# MBTA Bus Arrival Departure Times 2025: [https://mbta-massdot.opendata.arcgis.com/datasets/924df13d845f4907bb6a6c3ed380d57a/about](https://mbta-massdot.opendata.arcgis.com/datasets/924df13d845f4907bb6a6c3ed380d57a/about)

# Arrival Prediction Accuracy: [https://www.mbta.com/performance-metrics/arrival-prediction-accuracy](https://www.mbta.com/performance-metrics/arrival-prediction-accuracy)

# Rapid Transit and Bus Prediction Accuracy Data: [https://mbta-massdot.opendata.arcgis.com/datasets/155ab68df00145cabddfb90377201b0e/explore](https://mbta-massdot.opendata.arcgis.com/datasets/155ab68df00145cabddfb90377201b0e/explore)

Exploring the target route average delay is derived from the “64 Hours” bus equity campaign by LivableStreets, which found that Black bus riders in Boston spend on average 64 more hours per year waiting for or riding late buses than white riders.

Using the data from the target route average delay, our group will explore equity linkage by creating a walk-shed (¼–½ mile buffer) around each bus stop or route segment to represent the area it serves. Using U.S. Census American Community Survey (ACS) data, we then link the demographics of residents in those areas (race, income, age, car access) to the service quality of the buses. Finally, we weight bus delay measures by these demographics to estimate which groups are most affected by poor service.

In order to collect the appropriate data for ridership per bus route, end-to-end travel times, and locating service level disparities, our group will need geoDOT access. With geoDOT access, our group will be able to access the datasets reflecting seasonal ridership, system wide passenger surveys, and bus reliability based on arrival and departure times. 

* **How you plan on modeling the data (e.g. clustering, fitting a linear model, decision trees, XGBoost, some sort of deep learning method, etc.).**

As for modeling the data, for identifying disparities, we will start with base level descriptive stats, which can be done using bar charts, maps, and demographic breakdowns. Once we obtain a cleaned data csv, we can use the Pandas python library to group by data/neighborhood, and Seaborn to create histograms, bar plots, line plots, etc to get a base level understanding of our data and identify important features that affect ridership and service( for example: is a certain geographic area more prone to delays? Is a certain income area more affected? etc).

Once we gain an understanding of feature importance and cleaned data, we will expand into predictive modeling to answer some of our deeper questions. The specifics of these will be subject to change as our project progresses. If we want to predict whether a bus trip will be delayed beyond some X amount of time– (binary classification problem), we will use Logistic regression, random forest classifier, or XGBoost. For an unsupervised task, we can apply K-means clustering, Gaussian Mixture Modeling (GMMs), or other forms of clustering to discover hidden patterns in our data (say to identify inequities across the network that occur in a higher dimensional space that is not obvious visually).

This is a two step process that will be modified as per the needs of the project. 

* **How do you plan on visualizing the data? (e.g. interactive t-SNE plot, scatter plot of feature x vs. feature y).**

These are some static and interactive visualizations that our team will use to communicate performance metrics and equity findings:

1) Heat maps that will show delay intensity by routes and/or time of the day.  
2) Time Series plots to compare pre-pandemic vs post-pandemic changes and trends.  
3) Bar charts and histograms to compare delay distributions and service reliability across neighborhoods or demographic groups.   
4) Creating interactive dashboards (with Ploty Dash or Jupyter-based tools) could be also useful to provide dynamic visualizations and filters by route, time period, or demographic, which will enable us to observe patterns and get a better understanding of them.  
     
* **What is your test plan? (e.g. withhold 20% of data for testing, train on data collected in October and test on data collected in November, etc.).**

As part of the project is attempting to look at changes over time (with time permitting), and regular updates are not available for a factor of the data sets we are looking at, using a chronological train/test split would be the most appropriate to evaluate our models.

The test plan is designed to validate our predictive models, and it is essential for successfully achieving the following objectives:

* Forecasting Delay Risk (P\[delay \> X minutes\])  
* Forecasting Ridership Volume per route

The plan also will help the modeling component of our goal to identify disparities, where we will test the model’s ability to predict delay outcomes based on demographic factors. However, it is important to mention that this plan does not apply to our primary analytical goal of “analyzing  performance metrics and historical trends” given that this analysis will use the entire dataset to describe past events, on the  other hand, the test plan will evaluate the predictive ability of the model.

Our chronological train/test split will include data from 2018 through 2025\. This method ensures we evaluate our model’s performance on recent, completely unseen data, which best simulates a real-world forecasting scenario:

* Full modeling period: Years of 2018, 2021, 2023, and 2025 for Arrival and Departure Data, Years of 2016 to 2024 for Ridership Data  
* Training set: 80% of total data (First 41 months roughly for Arrival and Depature Data and first 6 years of Ridership Data).This period captures a wide range of conditions, including pre-pandemic, pandemic, and post-pandemic recovery trends  
* Test set: We will withhold the data from the last 20% of the total data (last 7 months for Arrival and Departure Data and last 2 years for Ridership Data), as our final unseen test set, which will provide a robust evaluation of the model’s prediction of performance in the most recent operational environment

Furthermore, we will use rolling-window cross-validation on the training with increasing chronological subsets of the years, so we can find our optimal models' tuning parameters. 

