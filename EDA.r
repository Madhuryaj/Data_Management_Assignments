R_1
######## START - Import the excel files into R . ########
# Install necessary packages
install.packages("readxl")
# Load required libraries
library(readxl)
#get the current working directory
getwd()
#output is "/Users/madhuryaj/R_STATS"
# Set the working directory in which our 4 Excel files are located
setwd("/Users/madhuryaj/Desktop/DATA_MANAGEMENT/ASSIGNMENT/R_Code
_File")
getwd()
#output
"/Users/madhuryaj/Desktop/DATA_MANAGEMENT/ASSIGNMENT/R_Code_File"
# Read the Excel files into R
customers <- read_excel("Data 1_Customer.xlsx")
motor_policies <- read_excel("Data 2_Motor Policies.xlsx")
health_policies <- read_excel("Data 3_Health Policies.xlsx")
travel_policies <- read_excel("Data 4_Travel Policies.xlsx")
######## END - Import the excel files into R . ########
R_2
# Explore Summary Statistics for numeric columns
22
summary(customers)
summary(travel_policies)
summary(health_policies)
summary(motor_policies)
______________________________________________________________
R_3
# Check for duplicates in each dataset - Checking is any Data Quality Issues
duplicated_rows_customers <- customers[duplicated(customers), ]
duplicated_rows_travel <- travel_policies[duplicated(travel_policies), ]
duplicated_rows_health <- health_policies[duplicated(health_policies), ]
duplicated_rows_motor <- motor_policies[duplicated(motor_policies), ]
______________________________________________________________
R_4
# Checking for missing values in each dataset - Checking if any Data Quality
Issues
colSums(is.na(customers))
colSums(is.na(travel_policies))
colSums(is.na(health_policies))
colSums(is.na(motor_policies))
______________________________________________________________
R_5
###### START - Addressing a Data Quality issue in Age column #####
# Removing the Outliers in the data
boxplot(customers$Age, main = "Age Distribution of Customers", xlab = "Age")
# Replace negative ages with absolute values using ifelse
customers$Age<-ifelse(customers$Age< 0, abs(customers$Age), customers$Age)
# Assuming 'customers' is your dataframe
average_age <- 42
customers$Age[customers$Age > 100] <- average_age
# Visualizating the Age data after removing outliers
boxplot(customers$Age, main = "Age Distribution of Customers", xlab = "Age")
###### END - Addressing a Data Quality issue in Age column #####
R_6
# Replace '0' with 'Unknown' in 'CardType' column to address Data Quality Issue
customers$CardType [customers$CardType == '0'] <- 'Unknown'
______________________________________________________________
R_7
######### START - Joining the data frames to form ABT ########
# Install necessary packages if you haven't already
install.packages("dplyr")
# Load required libraries
library(dplyr)
# Joining datasets using dplyr
analytics_base_table <- customers %>%
left_join(travel_policies, by = "TravelID") %>%
left_join(health_policies, by = "HealthID") %>%
left_join(motor_policies, by = "MotorID")
######### END - Joining the data frames to form ABT ########
______________________________________________________________
