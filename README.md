# Credit Risk analysis project using Online Banking data (Lending Club).

## This is a Data cleaning, Data analysis and Machine Learning project using MySQL, Python and PowerBI.

### Description
The project involves data analysis of a peer-to-peer (P2P) service Lending Club that connected potential borrowers with lenders. The main aim of the project was to analyse the risk factors amongst different cohorts, as well as to build a predictive model, capable of flagging potential defaults before a loan is issued, assisting the decision making.

The dataset consists of 2 million records of loan data, including loan amount, grade, dti, interest rate, recoveries, defaults and customer information.

It is publicly available on Kaggle through https://www.kaggle.com/datasets/adarshsng/lending-club-loan-data-csv/data

### Final results:
Dashboard:

<img width="1191" height="697" alt="image" src="https://github.com/user-attachments/assets/cd2b40a3-0f22-4f9d-8ec8-dc646d23a553" />

<img width="1176" height="686" alt="image" src="https://github.com/user-attachments/assets/eb42ac78-0e1b-42cf-b0b1-90482bcee171" />

ML model:

<img width="453" height="564" alt="image" src="https://github.com/user-attachments/assets/6d88c5a2-eb18-446c-93b4-354e93f198ea" />
<img width="857" height="642" alt="image" src="https://github.com/user-attachments/assets/df374b00-1c47-4971-8f37-45cdea7aba23" />


## Completed steps in order:
  1. Importing and cleaning dataset in MySQL
  2. Filling missing values
  3. Statistical significance testing (Mann-Whitney U, Chi-Squared)
  4. Exploratory Data Analysis
  5. Preprocessing
  6. Building and evaluating different ML models, choosing the best
  7. Exporting it as a file
  8. Building a dashboard
## Languages and platforms used:
* Python
  * pandas
  * numpy
  * scikit-learn
  * XGBoost
  * matplotlib, seaborn
  * SHAP

* VSCode (Jupyter Notebook)
  
* MySQL
* PowerBI
  
* GitHub version control

# Screenshots
## Data cleaning

<img width="691" height="421" alt="image" src="https://github.com/user-attachments/assets/a28e6ac9-d6f2-4801-abe5-0c802e2adaee" />

<img width="811" height="457" alt="image" src="https://github.com/user-attachments/assets/ccba7ffa-8961-4f9d-ab78-839058e8e0d1" />

## Hypothesis Testing

First the features needed to be checked for statistical significance. Continuous features were tested using Mann-Whitney U, while categorical were tested with Chi-squared.

<img width="570" height="384" alt="image" src="https://github.com/user-attachments/assets/029c71df-c4d3-4c72-9c28-555630ba1f46" />

<img width="485" height="152" alt="image" src="https://github.com/user-attachments/assets/ea5a1f3a-597f-4dca-9bb0-b4ecb824abf8" />

Results show every feature being significant, which is expected for a large dataset. The point was to ensure no insignificant feature got into the model.

## Exploratory Data Analysis

EDA was done through pandas, matplotlib and seaborn

<img width="840" height="652" alt="image" src="https://github.com/user-attachments/assets/bd49f308-715d-446c-907a-c61d131330a3" />

The visual above, while not very comprehensible, shows correlation between features. Any above 0.8 were dropped.

<img width="758" height="724" alt="image" src="https://github.com/user-attachments/assets/0249d800-7de9-4dd3-bdbf-2b161665d0f6" />

Distributions showed a moderate to heavy right skew within the 99th percentile. Large outliers however aren't required to be removed for tree-based algorithms.

## Preprocessing, Model Building and Evaluating

First were the categorical features encoded into matrices with One-Hot

<img width="1365" height="655" alt="image" src="https://github.com/user-attachments/assets/538f1ea9-2b50-4a4b-aa6c-c4669da08aaf" />

The data was then split with scikit-learn into training and testing, fitted and scaled

<img width="630" height="231" alt="image" src="https://github.com/user-attachments/assets/b39a9bc1-c74f-46cf-b579-26d041737c6f" />

The target variable was scaled due to major class imbalance.

<img width="323" height="89" alt="image" src="https://github.com/user-attachments/assets/0203589d-67fc-497e-9744-67f9513e5b2c" />

Next, the optimal hyperparameters were found via Cross Validation (CV)

<img width="674" height="546" alt="image" src="https://github.com/user-attachments/assets/9e57414d-7704-4dcb-a031-7d68c32bd32d" />

Two models were tried, one optimized for f-score, the other optimized for recall


<img width="374" height="448" alt="image" src="https://github.com/user-attachments/assets/085b33cb-d160-40d2-a4d1-cab8f0285a26" />

<img width="343" height="437" alt="image" src="https://github.com/user-attachments/assets/6c9a3a57-88cc-45fa-aba7-eee8fc9a30f6" />

The first one had the best balance overall, while the second caught the most defaults. As such, when substituting values for losses per default, the second model was the clear winner in terms of profitability. However not without a cost, as the model flagged more of good loans as risky. So both models were extracted.

<img width="1286" height="288" alt="image" src="https://github.com/user-attachments/assets/7e58244e-a06b-4f79-95a1-67784faece8a" />

In the end, a dashboard was built to dynamically showcase findings and recommend further actions

<img width="1194" height="678" alt="image" src="https://github.com/user-attachments/assets/5d87935c-7671-4244-8453-ea2d4c24b9e5" />

<img width="1176" height="679" alt="image" src="https://github.com/user-attachments/assets/336851c1-ccb4-4420-b200-24fe82d46b05" />

<img width="1176" height="690" alt="image" src="https://github.com/user-attachments/assets/04ca1b63-27f3-4c04-a578-e4c94deff014" />

<img width="1176" height="686" alt="image" src="https://github.com/user-attachments/assets/eb42ac78-0e1b-42cf-b0b1-90482bcee171" />


