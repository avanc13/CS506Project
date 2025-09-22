# Boston Bus Equity Project

## Description of the project
This project aims to analyze bus service performance and equity in the city of Boston using MBTA ridership, reliability, and passenger service data. Public transportation is very essential to the daily operations of people in the city of Boston; we want to analyze how service disparities exist among certain neighborhoods and demographics.

---

## Clear goal(s) (e.g. Successfully predict the number of students attending lecture based on the weather report).
- **Analyze performance metrics**: Ridership trends, average delays, wait times across all MBTA bus routes (pre pandemic to post pandemic–2018-present)  
- **Identify disparities** in service reliability by comparing performance across neighborhoods, demographics, and track changes over time.  
- **(With time permitting) Build predictive models to forecast**:  
  - Delay risk (P[delay > X minutes]), with some amount of confidence.  
  - Ridership volume per route/time bucket.  

---

## What data needs to be collected and how you will collect it (e.g. scraping xyz website or polling students).
- **Ridership per route** (including pre vs. post-pandemic changes) will be obtained using the MBTA Blue Book open datasets to compute weekday boardings by route for 2015-2017 and most recently 2023-2025.  
- **End-to-end travel time per route** will take into account scheduled running time vs. observed running time by comparing schedule data to realtime vehicle positionary data. MBTA open performance pipeline will supplement these findings.  
- **Wait time and average delay across all routes** have been redefined by the MBTA to alter what constitutes “on time” or “delayed”. This margin of error from scheduled windows has changed over the past two years to account for dropped trips in a new metric “Excess Trip Time”.  
- **Exploring the target route average delay** is derived from the “64 Hours” bus equity campaign by LivableStreets, which found that Black bus riders in Boston spend on average 64 more hours per year waiting for or riding late buses than white riders.  
- Using the data from the target route average delay, our group will **explore equity linkage** by creating a walk-shed (¼–½ mile buffer) around each bus stop or route segment to represent the area it serves. Using U.S. Census American Community Survey (ACS) data, we then link the demographics of residents in those areas (race, income, age, car access) to the service quality of the buses. Finally, we weight bus delay measures by these demographics to estimate which groups are most affected by poor service.  
- For every metric above, produce trend lines and before/after deltas. TransitMatters dashboards provide recovery context you can sanity-check against our computed numbers.  
- In order to collect the appropriate data for ridership per bus route, end-to-end travel times, and locating service level disparities, our group will need geoDOT access. With geoDOT access, our group will be able to access the datasets reflecting seasonal ridership, system wide passenger surveys, and bus reliability based on arrival and departure times.  

---

## How you plan on modeling the data (e.g. clustering, fitting a linear model, decision trees, XGBoost, some sort of deep learning method, etc.).
As for modeling the data, for identifying disparities, we will start with base level descriptive stats, which can be done using **bar charts, maps, and demographic breakdowns**. Once we obtain a cleaned data csv, we can use the **Pandas python library** to group by data/neighborhood, and **Seaborn** to create histograms, bar plots, line plots, etc to get a base level understanding of our data and identify important features that affect ridership and service (for example: is a certain geographic area more prone to delays? Is a certain income area more affected? etc).  

Once we gain an understanding of feature importance and cleaned data, we will expand into **predictive modeling** to answer some of our deeper questions. The specifics of these will be subject to change as our project progresses. If we want to predict whether a bus trip will be delayed beyond some X amount of time– (binary classification problem), we will use **Logistic regression, random forest classifier, or XGBoost**. For an **unsupervised task**, we can apply **K-means clustering, Gaussian Mixture Modeling (GMMs)**, or other forms of clustering to discover hidden patterns in our data (say to identify inequities across the network that occur in a higher dimensional space that is not obvious visually).  

This is a **two step process** that will be modified as per the needs of the project.  

---

## How do you plan on visualizing the data? (e.g. interactive t-SNE plot, scatter plot of feature x vs. feature y).
These are some static and interactive visualizations that our team will use to communicate performance metrics and equity findings:  
- Heat maps that will show delay intensity by routes and/or time of the day.  
- Time Series plots to compare pre-pandemic vs post-pandemic changes and trends.  
- Bar charts and histograms to compare delay distributions and service reliability across neighborhoods or demographic groups.  
- Creating interactive dashboards (with Ploty Dash or Jupyter-based tools) could be also useful to provide dynamic visualizations and filters by route, time period, or demographic, which will enable us to observe patterns and get a better understanding of them.  

---

## What is your test plan? (e.g. withhold 20% of data for testing, train on data collected in October and test on data collected in November, etc.).
As part of the project is attempting to look at **changes over time** (with time permitting), and regular updates are not available for a factor of the data sets we are looking at, using a **chronological train/test split** would be the most appropriate to evaluate our models.  

- We will hold the final 20% of data (roughly the most recent months or year or two) in data sets for testing, and use the first 80% for training.  
- Further, we could use rolling-window cross-validation to train on increasing chronological subsets of the years with validating the model on the following year to verify performance stability over time (ie 2018-2020 to train and 2021 to validate, then 2018-2021 to train and 2022 to validate, etc).  

As the other components of the project are looking for **full analysis and identification of trends across the data as a whole**, these will not require a train/test plan of splitting the data up.  
