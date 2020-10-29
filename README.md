# Customer Churn Prediction with PySpark on AWS
### Table of Contents

1. [Project Overview](#Overview)
2. [File Description](#files)
3. [Analysis Steps](#steps)
4. [Results](#results)
5. [Data Source, Acknowledgements](#source)

The summary of this analysis could be found at the medium post [here](https://kellyhe214.medium.com/customer-churn-prediction-with-pyspark-on-aws-7b889a46e60c).

## Project Overview <a name="Overview"></a>
Predicting churn rates is a very common and challenging problem in any customer-facing business. While bringing in new members is critical, member retention is the other interesting topic that data scientists and data analysts regularly encounter. 

This analysis is the capstone project of the Udacity's Data Science Nanodegree Program and aims to predict member churn using Sparkify subscribers activity data. Sparkify, like Spotify or Apple Music, is a fictitious music streaming service company and have free tiers and paid subscribers.

The full dataset stored on Amazon S3 is 12GB. So I explored the data pattern of a smaller subset (128MB) first and then deployed full analysis including data cleaning and modeling to Spark clusters on the cloud using AWS Elastic MapReduce (EMR).

## File Description <a name="files"></a>
**Sparkify_Churn_Prediction.ipynb**: This notebook includes the analysis on the smaller subset (128MB) before deployment.

**Sparkify_Churn_Prediction_Deploy.ipynb**: This notebook includes the deployment of Spark clusters using AWS EMR for full data analysis (12GB).

**run_jupyter.sh**: This file creates a Docker image which will have an isolated environment to run the Spark application.

**images folder**: All charts or screenshots in the analysis.

## Analysis Steps <a name="steps"></a>
Step 1. Load and Clean Dataset
     
     a. The smaller subset (128MB)
     b. The Full dataset (12GB)
     
Step 2. Exploratory Data Analysis
     
     a. Define Churn
     b. Use Spark SQL and PySpark to explore data pattern
     
Step 3. Feature Engineering

     a. Extract 18 Potential Features:
        - Female: Member gender, female (1) or male (0)
        - Main State Ratio: State with highest frequency / Count of total states
        - Distinct Locations: Count of distinct locations
        - Unique Page Actions: Count of distinct page actions
        - Page Action Ratios:
              - tbup_ratio: Count of Thumbs Up events / Count of total pages
              - tbdw_ratio: Count of Thumbs Down events / Count of total pages
              - addfriend_ratio: Count of Add Friend events / Count of total pages
              - ad_ratio: Count of Roll Advert events / Count of total pages
              - up_ratio: Count of Upgrade events / Count of total pages
              - help_ratio: Count of Help events / Count of total pages
              - error_ratio: Count of Error events / Count of total pages
        - Length of enrollment: max date - min date +1
        - Active Days: Count of distinct dates
        - Active Ratio: Active days / Length of enrollment
        - Distinct Artists per Active Day: Count of distinct artists / active days  
        - Distinct Songs per Active Day: Count of distinct songs / active days  
        - Avg Songs per Active Day: Count of total songs / active days   
        - Avg Items per Session: Count of total items / Count of distinct sessions
    
     b. Features Visualization
     c. Drop features with only one unique value and high correlations
     
Step 4. Modeling and Evaluation

     a. Split the full dataset into train (including validation) and test sets
     b. Build machine learning pipelines and evaluate the performance
        Supervised Learning Algorithms:
        - Logistic Regression
        - Random Forest
        - Gradient-Boosted Tree
        - Linear Support Vector Machine
        
        Performance Metrics:
        - F1 Score
        - Accuracy
        
     c. Implement three methods to deal with the imbalanced class issue
        - Over-sampling
        - Under-sampling
        - Balancing class weights
        
     d. Conduct 3-fold cross-validation and parameter tuning to improve model performance


## Results <a name="results"></a>
**The Linear Support Vector Machine model** has the best performance for churn prediction on the smaller subset (128MB) with a F1 Score of 0.933 and an accuracy of 96.7%, while **the tuned Gradient-boosted Tree (GBT) model** has the best performance on the full dataset (12GB) with a high **F1 Score of 0.934** and an **accuracy of 97.0%**. 

The GBT model also has high recall and precision rates. 91.2% (recall) of true churners are found by the model, and 95.7% (precision) of users the model that predicts are churners are true churners.

**Unique Page Actions** (upage_ct) and **length of enrollment** (enroll_days) are the top two features with high importance. 

The analysis and results are best presented at the medium post [here](https://kellyhe214.medium.com/customer-churn-prediction-with-pyspark-on-aws-7b889a46e60c).

## Data Source, Acknowledgements<a name="source"></a>
The simulated small subset (128MB) and the full dataset (12GB) used in this project are both provided by Udacity. Thank you for providing the user activity data that are so close to the real-world data from streaming music service platforms.

Full dataset stored on Amazon S3: "s3n://udacity-dsnd/sparkify/sparkify_event_data.json"