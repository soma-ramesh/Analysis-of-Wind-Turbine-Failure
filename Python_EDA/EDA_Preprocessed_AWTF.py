# Import required libraries
import numpy as np                 # For numerical computation
import pandas as pd                # For Data manipulation and analysis
import matplotlib.pyplot as plt    # For static data visualization
import seaborn as sns              # For advaced data visalization
import scipy.stats as stats        # For statistical analysis
from sqlalchemy import create_engine   # For to connect with Databases and execute SQL query in python
import pymysql                         # For to connect with MySQL DB
import warnings                        # For to ignore warnings
from feature_engine import transformation    # For power transformation
warnings.filterwarnings("ignore")
import sweetviz as sv
from autoviz.AutoViz_Class import AutoViz_Class
import dtale
from ydata_profiling import ProfileReport


# Set the parameters to connect with MySQL DB.
host = "localhost"
user_name = "root"
password = "root"
db_name = "wt"

# Create an engine to connect with MySQL db using sqlalchemy
engine = create_engine(f"mysql+pymysql://{user_name}:{password}@{host}/{db_name}")

# Write a SQL query to fetch the data from a table named "wt_data" in database "wt"
fetch_data = "SELECT * FROM wt_data;"

# Read the data into padas data frame
wt_df = pd.read_sql_query(fetch_data, con= engine)


# Display the dataframe
print(wt_df)


# Check for dataframe dimension
wt_df.shape

# Check the dataframe information
wt_df.info()

# Check the summary statisctics of dataframe
wt_df.describe()


# Check for null values
wt_df.isnull().sum()


"-----------------------------------------------------------------------------------------------"

"Auto-EDA"


"Sweetviz"
# Analyze the dataframe and generate report
sv_report = sv.analyze(wt_df)

# Display the report in html format
sv_report.show_html()
sv_report.show_html(filepath= r"G:\PDA Certification Program\Projects\Analysis of Wind Turbine Failure_267\Project Initial Documents\Python\Sweetviz_Auto_EDA\sweetviz_report.html")

# Save the html into pdf
import pdfkit


# Define the path to wkhtmltopdf
path_wkhtmltopdf = r"C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe"  # update path if yours is different

#  Create the config object
config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)

# Provide your file paths
html_file = r"G:\PDA Certification Program\Projects\Analysis of Wind Turbine Failure_267\Project Initial Documents\Python\Sweetviz_Auto_EDA\sweetviz_report.html"
pdf_file = r"G:\PDA Certification Program\Projects\Analysis of Wind Turbine Failure_267\Project Initial Documents\Python\Sweetviz_Auto_EDA\sweetviz_report.pdf"

# Convert HTML to PDF
pdfkit.from_file(html_file, pdf_file, configuration=config)


"-----------------------------------------------------------------------------------------------"
"-----------------------------------------------------------------------------------------------"


" AutoViz "

# Create an instance of AutoViz_Class
av = AutoViz_Class()

# Generate visualizations for the dataset
Autoviz_Report = av.AutoViz(wt_df, chart_format= "html")
Autoviz_Report = av.AutoViz(wt_df, depVar = "Failure_Status")


"-----------------------------------------------------------------------------------------------"
"-----------------------------------------------------------------------------------------------"

"D-Tale"

# Display the dataframe using D-Tale
dtale_report = dtale.show(wt_df)

# Open the browser to view the interactive D-Tale dashboard
dtale_report.open_browser()


"-----------------------------------------------------------------------------------------------"
"-----------------------------------------------------------------------------------------------"

"Pandas Profiling"

# Generate visualizations for the dataset
pp_report = ProfileReport(wt_df)

# Save the profile report to an HTML file
pp_report.to_file("output.html")


"-----------------------------------------------------------------------------------------------"
"-----------------------------------------------------------------------------------------------"

# Print column names
wt_df.columns

# Rename the column names
wt_df = wt_df.rename(columns= {
                    "date": "Date",
                    "Wind_speed" :  "Wind_Speed", 
                    "Nacelle_ambient_temperature" : "Nacelle_Ambient_Temp" ,
                    "Generator_bearing_temperature" : "Generator_Bearing_Temp",
                    "Gear_oil_temperature" :  "Gear_Oil_Temp" ,
                    "Ambient_temperature": "Ambient_Temp",
                    "Nacelle_temperature" : "Nacelle_Temp" ,
                    "Bearing_temperature" : "Bearing_Temp",
                    "Generator_speed" : "Generator_Speed",
                    "Yaw_angle" : "Yaw_Angle" ,
                    "Wind_direction" : "Wind_Direction",
                    "Wheel_hub_temperature" : "Wheel_Hub_Temp" ,
                    "Gear_box_inlet_temperature" :  "Gearbox_Inlet_Temp",
                    "Failure_status" : "Failure_Status" })


# Covert the Date column datatype from  object to date  
wt_df["Date"] = pd.to_datetime(wt_df["Date"])

# Check the data types
wt_df.dtypes   

# Sort the dataframe for Date column
wt_df = wt_df.sort_values(by = "Date")

# Reset the index
wt_df.reset_index(drop = True, inplace = True)   

# Check for duplicates in dataframe
wt_df.duplicated().sum()

# Extract year from date column and create a new column in the data frame
wt_df['Year'] = wt_df['Date'].dt.year  


# Assign numerical columns
num_col = wt_df[['Wind_Speed', 'Power', 'Nacelle_Ambient_Temp', 'Generator_Bearing_Temp',
    'Gear_Oil_Temp', 'Ambient_Temp', 'Rotor_Speed', 'Nacelle_Temp','Bearing_Temp', 
    'Generator_Speed', 'Yaw_Angle', 'Wind_Direction', 'Wheel_Hub_Temp', 'Gearbox_Inlet_Temp']]




#-------------------------------------------------------
#-------------- Univariate Analysis --------------------
#-------------------------------------------------------


#---------------- Business Moments----------------------

for col in num_col:
    print(f"\n Descriptive Statistics for {col}")
    
    print(f"First Moment Business Decision for {col}:")
    print(f"Mean: {round(wt_df[col].mean(),2)}")                 # For to display Mean
    print(f"Median: {round(wt_df[col].median(),2)}")             # For to dispaly Median
    print(f"Mode: {round(wt_df[col].mode(),2)}\n")                 # For to dispaly Mode
    
    
    print(f"Second Moment Business Decision for {col}:")
    print(f"Variance: {round(wt_df[col].var(),2)}")                     # For to display Variance
    print(f"Standard Deviation: {round(wt_df[col].std(),2)}")           # For to display Standard Deviation
    print(f"Minimum: {round(wt_df[col].min(),2)}")                      # For to display Minimum
    print(f"Maximum: {round(wt_df[col].max(),2)}")                      # For to display Maximum
    print(f"Range: {round(wt_df[col].max(),2) - round(wt_df[col].min(),2)}\n") # For to display Range
    
    print(f"Third Moment Business Decision for {col}:")
    print(f"Skewness: {round(wt_df[col].skew(),2)}\n")                    # # For to display skewness value
    
    print(f"Fourth Moment Business Decision for {col}:")
    print(f"Kurtosis: {round(wt_df[col].kurt(),2)}\n")                    # # For to display kurtosis value




#---------------- Histogram ----------------------

# Create a function to create histogram for each variabe in the dataframe
def Histogram(series):                                                    # Defining a Function with name Histogram, that will take variable as an argument
    plt.figure(figsize = (8, 5))                                          # Set the dimensions for the histogram plot
    plt.hist(series, color = "Blue", edgecolor = "black", alpha =0.4)     # Plot the histogram with for called vaiable in function with transparency(alpha) = 0.4 and in blue color
    plt.xlabel(series.name, fontsize = 12)                                # Define the xlabel as Variable name 
    plt.ylabel("Frequency", fontsize = 12)                                # Define the ylabel as frequency
    plt.title(f"Frequency of {series.name}", fontsize = 14)               # Define the title
    plt.show()                                                            # Show the plot


# Call the function with Variable name
Histogram(num_col["Wind_Speed"])
Histogram(num_col["Power"])
Histogram(num_col["Nacelle_Ambient_Temp"])
Histogram(num_col["Generator_Bearing_Temp"])
Histogram(num_col["Gear_Oil_Temp"])
Histogram(num_col["Ambient_Temp"])
Histogram(num_col["Rotor_Speed"])
Histogram(num_col["Nacelle_Temp"])
Histogram(num_col["Bearing_Temp"])
Histogram(num_col["Generator_Speed"])
Histogram(num_col["Yaw_Angle"])
Histogram(num_col["Wind_Direction"])
Histogram(num_col["Wheel_Hub_Temp"])
Histogram(num_col["Gearbox_Inlet_Temp"])




# -------------------- Density Plot ---------------------------
wt_df.columns

# Create a function to create KDE Plot for each variabe in the dataframe
def KDE_Plot(series):                                                    # Defining a Function with name KDE_plot, that will take variable as an argument
    plt.figure(figsize = (8, 5))                                         # Set the dimensions for the KDE plot
    sns.kdeplot(series)                                                  # Plot the KDE_plot with for called vaiable in function with transparency(alpha) = 0.4 and in blue color
    plt.xlabel(series.name, fontsize = 12)                               # Define the xlabel as Variable name 
    plt.ylabel("Density", fontsize = 12)                                 # Define the ylabel as Density
    plt.title(f"Distribution of {series.name}", fontsize = 14)           # Define the title
    plt.show()                                                           # Show the plot


# Call the function with Variable name
KDE_Plot(num_col["Wind_Speed"])
KDE_Plot(num_col["Power"])
KDE_Plot(num_col["Nacelle_Ambient_Temp"])
KDE_Plot(num_col["Generator_Bearing_Temp"])
KDE_Plot(num_col["Gear_Oil_Temp"])
KDE_Plot(num_col["Ambient_Temp"])
KDE_Plot(num_col["Rotor_Speed"])
KDE_Plot(num_col["Nacelle_Temp"])
KDE_Plot(num_col["Bearing_Temp"])
KDE_Plot(num_col["Generator_Speed"])
KDE_Plot(num_col["Yaw_Angle"])
KDE_Plot(num_col["Wind_Direction"])
KDE_Plot(num_col["Wheel_Hub_Temp"])
KDE_Plot(num_col["Gearbox_Inlet_Temp"])



# -------------------- Box Plot --------------------------------

# Create a function to create Box Plot for each variabe in the dataframe
def Box_Plot(series):
    plt.figure(figsize = (5, 5))                                     # Set the dimensions for the Box plot
    sns.boxplot(series)                                              # Plot the Box_plot with for called vaiable in function
    plt.title(f"Box plot of {series.name}", fontsize = 14)           # Define the title         
    plt.show()                                                       # Show the plot

# Call the function with Variable name
Box_Plot(num_col["Wind_Speed"])
Box_Plot(num_col["Power"])
Box_Plot(num_col["Nacelle_Ambient_Temp"])
Box_Plot(num_col["Generator_Bearing_Temp"])
Box_Plot(num_col["Gear_Oil_Temp"])
Box_Plot(num_col["Ambient_Temp"])
Box_Plot(num_col["Rotor_Speed"])
Box_Plot(num_col["Nacelle_Temp"])
Box_Plot(num_col["Bearing_Temp"])
Box_Plot(num_col["Generator_Speed"])
Box_Plot(num_col["Yaw_Angle"])
Box_Plot(num_col["Wind_Direction"])
Box_Plot(num_col["Wheel_Hub_Temp"])
Box_Plot(num_col["Gearbox_Inlet_Temp"])




# ---------Find Outliers for each variable using IQR method---------------------------

wt_df.columns



def find_outliers(series):
    Q1 = series.quantile(0.25)                                          # For Q1 as 25 Percentile
    Q3 = series.quantile(0.75)                                          # For Q3 as 75 Percentile
    IQR = Q3- Q1                                                                       # Inter Quartile Range
    k = 1.5                                                                            # For suspected outliers         
    LB = Q1 - (k* IQR)                                                                 # Lower Bound or Lower Limit
    UB = Q3 + (k * IQR)                                                                # pper Bound or Upper Limit
    outliers = num_col[(series < LB) | (series > UB)]    # Find outliers which are less than lower limit and greater than upper limit and store them in a data frame

    print(f"Outliers details for variable {series.name}:\n")
    print(f"Lower Quartile(Q1): {Q1}")                                   # Print Lower Quartile(Q1)
    print(f"Upper Quartile(Q3): {Q3}")                                   # Print Upper Quartile(Q3)
    print(f"Inter Quartile Range(IQR): {IQR}")                           # Print Inter Quartile Range(IQR)
    print(f"Lower Bound(LB): {LB}")                                      # Print Lower Bound(Q1)
    print(f"Upper Bound(UB): {UB}")                                      # Print Upper Bound(Q3)
    print(f"Total outliers found in {series.name}: {len(outliers)}")    # Print Total outliers
    # print(outliers["Wind_Speed"])

# Call the function with Variable name
find_outliers(num_col["Wind_Speed"])
find_outliers(num_col["Power"])
find_outliers(num_col["Nacelle_Ambient_Temp"])
find_outliers(num_col["Generator_Bearing_Temp"])
find_outliers(num_col["Gear_Oil_Temp"])
find_outliers(num_col["Ambient_Temp"])
find_outliers(num_col["Rotor_Speed"])
find_outliers(num_col["Nacelle_Temp"])
find_outliers(num_col["Bearing_Temp"])
find_outliers(num_col["Generator_Speed"])
find_outliers(num_col["Yaw_Angle"])
find_outliers(num_col["Wind_Direction"])
find_outliers(num_col["Wheel_Hub_Temp"])
find_outliers(num_col["Gearbox_Inlet_Temp"])



# --------------------Normality check using Q-Q Plot --------------------------------


wt_df.columns
# Checking whether the variables in the dataset are  normally distributed using a Q-Q plot

def QQ_Plot(series):
    plt.figure(figsize = (8,5))
    stats.probplot(series, dist = "norm", plot  = plt)
    plt.title(f"Q-Q Plot for {series.name}")
    plt.show()


# Call the function with Variable name
QQ_Plot(num_col["Wind_Speed"])
QQ_Plot(num_col["Power"])
QQ_Plot(num_col["Nacelle_Ambient_Temp"])
QQ_Plot(num_col["Generator_Bearing_Temp"])
QQ_Plot(num_col["Gear_Oil_Temp"])
QQ_Plot(num_col["Ambient_Temp"])
QQ_Plot(num_col["Rotor_Speed"])
QQ_Plot(num_col["Nacelle_Temp"])
QQ_Plot(num_col["Bearing_Temp"])
QQ_Plot(num_col["Generator_Speed"])
QQ_Plot(num_col["Yaw_Angle"])
QQ_Plot(num_col["Wind_Direction"])
QQ_Plot(num_col["Wheel_Hub_Temp"])
QQ_Plot(num_col["Gearbox_Inlet_Temp"])





# --------------------Pie Chart for Failure Status--------------------------------

 
failure_counts = wt_df["Failure_Status"].value_counts()                   # Count values in Failure_Status column

plt.figure(figsize=(4, 4))                                                # Set the figure size
plt.pie(failure_counts, labels = failure_counts.index, autopct='%1.1f%%',
        startangle=100, colors=["lightcoral", "lightgreen"], textprops={'fontsize': 10})              # Plot the pie chart 
plt.title("Failure Status Distribution", fontsize = 14)                                  # Set the title 
plt.axis('equal')                                                         # Equal aspect ratio to make the pie circular
plt.show()                                                                # Show the plot





#-------------------------------------------------------
#-------------- Bivariate Analysis --------------------
#-------------------------------------------------------


# -----Time Series Analysis ---------------------------

def Time_series(variable):
    plt.figure(figsize = (8,5))
    sns.lineplot(x = wt_df['Date'], y = variable)
    plt.xlabel("Date", fontsize=10)
    plt.ylabel(f"{variable.name}", fontsize = 10)
    plt.xticks(rotation=45)
    plt.title(f"{variable.name} Generation Over Time")
    plt.tight_layout()  # Avoid overlap
    plt.show()


Time_series(wt_df["Wind_Speed"])
Time_series(wt_df["Power"])
Time_series(wt_df["Nacelle_Ambient_Temp"])
Time_series(wt_df["Generator_Bearing_Temp"])
Time_series(wt_df["Gear_Oil_Temp"])
Time_series(wt_df["Ambient_Temp"])
Time_series(wt_df["Rotor_Speed"])
Time_series(wt_df["Nacelle_Temp"])
Time_series(wt_df["Bearing_Temp"])
Time_series(wt_df["Generator_Speed"])
Time_series(wt_df["Yaw_Angle"])
Time_series(wt_df["Wind_Direction"])
Time_series(wt_df["Wheel_Hub_Temp"])
Time_series(wt_df["Gearbox_Inlet_Temp"])


plt.figure(figsize = (10,5))
sns.lineplot(x = wt_df['Date'], y = wt_df["Failure_Status"])
plt.xlabel("Date", fontsize=10)
plt.ylabel("Failure_Status", fontsize = 10)
plt.xticks(rotation=45)
plt.title("Failure_Status Over Time")
plt.tight_layout()  # Avoid overlap
plt.show()



# ---------------------------------- Box Plot for variable vs failure status------------------------------------------

# Create a function to create Box Plot for each variabe in the dataframe
def Bp(variable):
    plt.figure(figsize = (5, 5))                                     # Set the dimensions for the Box plot
    sns.boxplot(x = wt_df["Failure_Status"], y = variable)           # Plot the Box_plot with for called vaiable in function
    plt.title(f"Failure Status vs {variable.name}", fontsize = 14)   # Define the title         
    plt.show()                                                       # Show the plot

# Call the function with Variable name
Bp(wt_df["Wind_Speed"])
Bp(wt_df["Power"])
Bp(wt_df["Nacelle_Ambient_Temp"])
Bp(wt_df["Generator_Bearing_Temp"])
Bp(wt_df["Gear_Oil_Temp"])
Bp(wt_df["Ambient_Temp"])
Bp(wt_df["Rotor_Speed"])
Bp(wt_df["Nacelle_Temp"])
Bp(wt_df["Bearing_Temp"])
Bp(wt_df["Generator_Speed"])
Bp(wt_df["Yaw_Angle"])
Bp(wt_df["Wind_Direction"])
Bp(wt_df["Wheel_Hub_Temp"])
Bp(wt_df["Gearbox_Inlet_Temp"])



# --------------------------------- Scatter Plot -----------------------------------

wt_df.columns


def scatter_plot(variable):
    plt.figure(figsize = (8, 6))                                                 # Set figure size
    plt.scatter(x = variable, y = wt_df['Power'], color = "green", alpha = 0.3)  # Scatter plot with transparency
    plt.xlabel(f"{variable.name}")                                               # Label for x-axis
    plt.ylabel("Power")                                                          # Label for y-axis
    plt.title(f"Scatter Plot of {variable.name} vs Power")                       # Set title
    plt.grid(True)                                                               # Enable grid for better readability
    plt.show()                                                                   # Show the plot


# Call the function with Variable name
scatter_plot(wt_df["Wind_Speed"])
scatter_plot(wt_df["Power"])
scatter_plot(wt_df["Nacelle_Ambient_Temp"])
scatter_plot(wt_df["Generator_Bearing_Temp"])
scatter_plot(wt_df["Gear_Oil_Temp"])
scatter_plot(wt_df["Ambient_Temp"])
scatter_plot(wt_df["Rotor_Speed"])
scatter_plot(wt_df["Nacelle_Temp"])
scatter_plot(wt_df["Bearing_Temp"])
scatter_plot(wt_df["Generator_Speed"])
scatter_plot(wt_df["Yaw_Angle"])
scatter_plot(wt_df["Wind_Direction"])
scatter_plot(wt_df["Wheel_Hub_Temp"])
scatter_plot(wt_df["Gearbox_Inlet_Temp"])
scatter_plot(wt_df["Failure_Status"])


# --------------------------------- Violin Plot -----------------------------------


def violin_plot(variable):
    plt.figure(figsize = (6, 5)) 
    sns.violinplot(x = wt_df["Failure_Status"], y = variable, color = "orange")
    plt.title(f"Violin plot of Failure Status vs {variable.name}")
    plt.show()

# Call the function with Variable name
violin_plot(wt_df["Wind_Speed"])
violin_plot(wt_df["Power"])
violin_plot(wt_df["Nacelle_Ambient_Temp"])
violin_plot(wt_df["Generator_Bearing_Temp"])
violin_plot(wt_df["Gear_Oil_Temp"])
violin_plot(wt_df["Ambient_Temp"])
violin_plot(wt_df["Rotor_Speed"])
violin_plot(wt_df["Nacelle_Temp"])
violin_plot(wt_df["Bearing_Temp"])
violin_plot(wt_df["Generator_Speed"])
violin_plot(wt_df["Yaw_Angle"])
violin_plot(wt_df["Wind_Direction"])
violin_plot(wt_df["Wheel_Hub_Temp"])
violin_plot(wt_df["Gearbox_Inlet_Temp"])




#-------------------------------------------------------
#-------------- Multivariate Analysis --------------------
#-------------------------------------------------------

# ------------------Time Series Analysis -------------------
# -----------Variable trend by Failure Status --------------

wt_df.columns

def trend_failure(variable):
    plt.figure(figsize = (8,5))
    sns.lineplot(x = wt_df['Date'], y = variable, hue = wt_df['Failure_Status'])
    plt.xlabel("Date", fontsize=10)
    plt.ylabel(f"{variable.name}", fontsize = 10)
    plt.xticks(rotation=45)
    plt.title(f"{variable.name} Generation Trends by Failure Status")
    plt.tight_layout()  # Avoid overlap
    plt.show()


trend_failure(wt_df["Wind_Speed"])
trend_failure(wt_df["Power"])
trend_failure(wt_df["Nacelle_Ambient_Temp"])
trend_failure(wt_df["Generator_Bearing_Temp"])
trend_failure(wt_df["Gear_Oil_Temp"])
trend_failure(wt_df["Ambient_Temp"])
trend_failure(wt_df["Rotor_Speed"])
trend_failure(wt_df["Nacelle_Temp"])
trend_failure(wt_df["Bearing_Temp"])
trend_failure(wt_df["Generator_Speed"])
trend_failure(wt_df["Yaw_Angle"])
trend_failure(wt_df["Wind_Direction"])
trend_failure(wt_df["Wheel_Hub_Temp"])
trend_failure(wt_df["Gearbox_Inlet_Temp"])



# ------------------ Pairplot -----------------------------------
plt.figure(figsize = (20,20))
sns.pairplot(num_col, diag_kind = "kde")
plt.suptitle("Pairplot - Multivariate Analysis")
plt.show()



# ---------------------Correlation Heatmap-----------------------------
plt.figure(figsize = (10,10))
sns.heatmap(num_col.corr(), annot = True, cmap = 'coolwarm')
plt.title("Correlation Heatmap")
plt.show()



#-------------------------------------------------------
#-------------- Outlier Treatment --------------------
#-------------------------------------------------------
# Replace the outliers by the maximum and minimum limit

wt_df.columns

wt_modified = wt_df.copy()
wt_modified.columns


# Define a function for outlier treament
def Outlier_Treatment(df, column_name):
    """
    This function detects and treats outliers using the IQR method for a given column in a DataFrame.
    It returns a new Series with capped (Winsorized) values.
    """
    # Step 1: Calculate IQR
    Q1 = df[column_name].quantile(0.25)
    Q3 = df[column_name].quantile(0.75)
    IQR = Q3 - Q1

    # Step 2: Define lower and upper limits
    lower_limit = Q1 - 1.5 * IQR
    upper_limit = Q3 + 1.5 * IQR

    # Step 3: Identify outliers (just for reporting)
    outliers = df[(df[column_name] < lower_limit) | (df[column_name] > upper_limit)]
    print(f"Outliers detected in '{column_name}': {len(outliers)}")

    # Step 4: Apply Winsorization (capping and flooring)
    df[column_name] = pd.DataFrame(np.where(df[column_name] > upper_limit, upper_limit,
                     np.where(df[column_name] < lower_limit, lower_limit,
                              df[column_name])))


def Boxplot_after_outlier_treatment(series):
    plt.figure(figsize = (5, 5))                                     # Set the dimensions for the Box plot
    sns.boxplot(series)                                              # Plot the Box_plot with for called vaiable in function
    plt.title(f"Box plot of {series.name}", fontsize = 14)           # Define the title         
    plt.show()                                                       # Show the plot


# Ooulier treatment for defined column in defined data frame in function and Box plot after outlier treatment
Outlier_Treatment(wt_modified, "Wind_Speed")
Boxplot_after_outlier_treatment(wt_modified.Wind_Speed)
            
Outlier_Treatment(wt_modified, "Power")
Boxplot_after_outlier_treatment(wt_modified.Power)

Outlier_Treatment(wt_modified, "Nacelle_Ambient_Temp")
Boxplot_after_outlier_treatment(wt_modified.Nacelle_Ambient_Temp)

Outlier_Treatment(wt_modified, "Generator_Bearing_Temp")
Boxplot_after_outlier_treatment(wt_modified.Generator_Bearing_Temp)

Outlier_Treatment(wt_modified, "Ambient_Temp")
Boxplot_after_outlier_treatment(wt_modified.Ambient_Temp)  

Outlier_Treatment(wt_modified, "Nacelle_Temp")
Boxplot_after_outlier_treatment(wt_modified.Nacelle_Temp)

Outlier_Treatment(wt_modified, "Bearing_Temp")
Boxplot_after_outlier_treatment(wt_modified.Bearing_Temp)

Outlier_Treatment(wt_modified, "Generator_Speed")
Boxplot_after_outlier_treatment(wt_modified.Generator_Speed)  

Outlier_Treatment(wt_modified, "Wind_Direction")
Boxplot_after_outlier_treatment(wt_modified.Wind_Direction)

Outlier_Treatment(wt_modified, "Gearbox_Inlet_Temp")
Boxplot_after_outlier_treatment(wt_modified.Gearbox_Inlet_Temp)




# export "wt_modified" data frame to csv for data visualization
wt_modified.to_csv(r"G:\PDA Certification Program\Projects\Analysis of Wind Turbine Failure_267\Project Initial Documents\Python\wt_cleaned.csv", index = False)


# ------------------- zero variance and near zero variance-------------------- 

# Assign numerical columns
num_cols = wt_modified[['Wind_Speed', 'Power', 'Nacelle_Ambient_Temp', 'Generator_Bearing_Temp',
    'Gear_Oil_Temp', 'Ambient_Temp', 'Rotor_Speed', 'Nacelle_Temp','Bearing_Temp', 
    'Generator_Speed', 'Yaw_Angle', 'Wind_Direction', 'Wheel_Hub_Temp', 'Gearbox_Inlet_Temp']]

num_cols.var()             # Calculating the variance of each numeric variable in the DataFrame
num_cols.var() == 0        # Checking if the variance of each numeric variable is equal to 0 and returning a boolean Series




#-------------------------------------------------------
#-------------- Discretization --------------------
#-------------------------------------------------------

Discretized = wt_modified.copy()

Discretized.columns

"""
min to Q1 :   Low
Q1 to Mean:   Moderate
Mean to  Q3:  High
Q3 to max:    Very High

"""

# Create a function for to discrretize eac variable in the data frame 
def Discretize(df, variable, target_variable):                                 # Create function for to call dataframe, variable, target variable name
    df[target_variable] = pd.cut(df[variable], bins=[min(df[variable]),        # Find Min value from variable                 
                                        df[variable].quantile(0.25),           # Find first quartile and assign "Low", if the value lies between min and first quartile
                                        df[variable].mean(),                   # Find mean value from varible and assign "Moderate", if the value lies between first quartile and mean                   
                                        df[variable].quantile(0.75),           # Find third quartile and assign "High", if the value lies between mean and third quartile
                                        max(df[variable])],                    # Find Max value from variable and assign "Very High", if the value lies between third quartile and Max value.
                                        include_lowest = True,
                                        labels = ["Low", "Moderate", "High", "Very High"])


Discretize(Discretized, "Wind_Speed", "WS_Discretized")
Discretize(Discretized, "Power", "P_Discretized")
Discretize(Discretized, "Nacelle_Ambient_Temp", "NAT_Discretized")
Discretize(Discretized, "Generator_Bearing_Temp", "GBT_Discretized")
Discretize(Discretized, "Gear_Oil_Temp", "GOT_Discretized")
Discretize(Discretized, "Ambient_Temp", "AT_Discretized")
Discretize(Discretized, "Rotor_Speed", "RS_Discretized")
Discretize(Discretized, "Nacelle_Temp", "NT_Discretized")
Discretize(Discretized, "Bearing_Temp", "BT_Discretized")
Discretize(Discretized, "Generator_Speed", "GS_Discretized")
Discretize(Discretized, "Yaw_Angle", "YA_Discretized")
Discretize(Discretized, "Wind_Direction", "WD_Discretized")
Discretize(Discretized, "Wheel_Hub_Temp", "WHT_Discretized")
Discretize(Discretized, "Gearbox_Inlet_Temp", "GIT_Discretized")




# Counting the number of occurrences of each category in the 'Wind_Speed' column
Discretized["WS_Discretized"].value_counts()
Discretized["P_Discretized"].value_counts()
Discretized["NAT_Discretized"].value_counts()
Discretized["GBT_Discretized"].value_counts()
Discretized["GOT_Discretized"].value_counts()
Discretized["AT_Discretized"].value_counts()
Discretized["RS_Discretized"].value_counts()
Discretized["NT_Discretized"].value_counts()
Discretized["BT_Discretized"].value_counts()
Discretized["GS_Discretized"].value_counts()
Discretized["YA_Discretized"].value_counts()
Discretized["WD_Discretized"].value_counts()
Discretized["WHT_Discretized"].value_counts()
Discretized["GIT_Discretized"].value_counts()






#--------------------------------------------------------------------------------
#-------------- Transforming the data to Normal distribution --------------------
#--------------------------------------------------------------------------------

# ------Normality check after outlier treatent using Q-Q Plot -------------------


wt_modified.columns    # Show the columns

# Make a new data frame named "wt_transformation" by copying from "wt_modified"
wt_transformation = wt_modified.copy()

wt_transformation.columns    # Show the columns


# Checking whether the variables in the dataset "wt_transformation"  are  normally distributed using a Q-Q plot

def QQ_plot(series):
    plt.figure(figsize = (8,5))
    stats.probplot(series, dist = "norm", plot  = plt)
    plt.title(f"Q-Q Plot for {series.name}")
    plt.show()


# Call the function with Variable name
QQ_plot(wt_transformation["Wind_Speed"])
QQ_plot(wt_transformation["Power"])
QQ_plot(wt_transformation["Nacelle_Ambient_Temp"])
QQ_plot(wt_transformation["Generator_Bearing_Temp"])
QQ_plot(wt_transformation["Gear_Oil_Temp"])
QQ_plot(wt_transformation["Ambient_Temp"])
QQ_plot(wt_transformation["Rotor_Speed"])
QQ_plot(wt_transformation["Nacelle_Temp"])
QQ_plot(wt_transformation["Bearing_Temp"])
QQ_plot(wt_transformation["Generator_Speed"])
QQ_plot(wt_transformation["Yaw_Angle"])
QQ_plot(wt_transformation["Wind_Direction"])
QQ_plot(wt_transformation["Wheel_Hub_Temp"])
QQ_plot(wt_transformation["Gearbox_Inlet_Temp"])


# Check once skewness for each variable
for col in wt_transformation:
    print(f"\n Descriptive Statistics for {col}")
    
    print(f"Third Moment Business Decision for {col}:")
    print(f"Skewness: {round(wt_transformation[col].skew(),2)}\n")                    # # For to display skewness value
    
    
# --------------------Yeo Johnson Transformation -------------- "

# Transforming 'Wind_Speed'varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Wind_Speed")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Wind_Speed, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Wind_Speed After Yeo-Johnson Transformation")
plt.show()



# Transforming 'Power' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Power")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Power, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Power After Yeo-Johnson Transformation")
plt.show()



# Transforming 'Nacelle_Ambient_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Nacelle_Ambient_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Nacelle_Ambient_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Nacelle_Ambient_Temp After Yeo-Johnson Transformation")
plt.show()





# Transforming 'Generator_Bearing_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Generator_Bearing_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Generator_Bearing_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Generator_Bearing_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Gear_Oil_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Gear_Oil_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Gear_Oil_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Gear_Oil_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Ambient_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Ambient_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Ambient_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Ambient_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Rotor_Speed' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Rotor_Speed")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Rotor_Speed, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Rotor_Speed After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Nacelle_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Nacelle_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Nacelle_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Nacelle_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Bearing_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Bearing_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Bearing_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Bearing_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Generator_Speed' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Generator_Speed")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Generator_Speed, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Generator_Speed After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Yaw_Angle' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Yaw_Angle")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Yaw_Angle, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Yaw_Angle After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Wind_Direction' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Wind_Direction")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Wind_Direction, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Wind_Direction After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Wheel_Hub_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Wheel_Hub_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Wheel_Hub_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Wheel_Hub_Temp After Yeo-Johnson Transformation")
plt.show()




# Transforming 'Gearbox_Inlet_Temp' varaible to Normal Distribution by applying Yeo Johnson Transformation
tf = transformation.YeoJohnsonTransformer(variables = "Gearbox_Inlet_Temp")
df_tf = tf.fit_transform(wt_transformation)

plt.figure(figsize = (8,5))
stats.probplot(df_tf.Gearbox_Inlet_Temp, dist = stats.norm, plot = plt)
plt.title("Q-Q Plot for Gearbox_Inlet_Temp After Yeo-Johnson Transformation")
plt.show()






#-------------------------------------------------------
#----------------------- Scaling -----------------------
#-------------------------------------------------------

# ---------------- Normalization -------------------------
# Importing MinMaxScaler from the sklearn.preprocessing module
from sklearn.preprocessing import MinMaxScaler                                          # Scales features to a fixed range (usually 0 to 1) for normalization  

exclude_columns = ['Date', 'Failure_Status', 'Year']                                    # Columns to be excluded from scaling

# Create a list of columns to scale (numeric columns excluding the above)
columns_to_scale = [col for col in wt_transformation.select_dtypes(include='number').columns 
                    if col not in exclude_columns]                                      # Only numeric columns that are not in the exclude list


minmaxscale = MinMaxScaler()                                                            # Initializing the MinMaxScaler and create scalar object

# Make a copy of the original dataframe to store scaled values
wt_scaled = wt_transformation.copy()                                                    # Copying the original DataFrame

wt_scaled[columns_to_scale] = minmaxscale.fit_transform(wt_transformation[columns_to_scale]) # Scaling the dataset using MinMaxScaler

wt_scaled.describe(include='number')     # Generating descriptive statistics of the dataset after Min-Max scaling


