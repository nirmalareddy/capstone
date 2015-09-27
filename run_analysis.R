# Load the ativity types from the activity_labels.txt file.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

#Load the traning data from x_train.txt
train_x <- read.table("UCI HAR Dataset/train/X_train.txt")

#Load the subjects data from y_train.txt
train_y <- read.table("UCI HAR Dataset/train/y_train.txt")

#Load the subjects data from subject_train.txt
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

#Load the traning data from x_train.txt
test_x <- read.table("UCI HAR Dataset/test/X_test.txt")

#Load the subjects data from y_train.txt
test_y <- read.table("UCI HAR Dataset/test/y_test.txt")

#Load the subjects data from subject_test.txt
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Combine the feature data for the Train and Test data sets 
x <- rbind(train_x,test_x)

#Combine the activity data for the Train and Test data sets 
y <- rbind(train_y,test_y)

#Repalce the activity codes with the desctiption from the activity_labels data frame.
activity <- factor(y$V1,labels = activity_labels$V2)

#Combine the subject data for the Train and Test data sets 
subjects <- rbind(train_subject,test_subject)

#Load the feature names from the features.txt file.
features <-read.table("UCI HAR Dataset/features.txt") 

#Adding a new column to the feaures data frame which stores the column names as per the R standards.
features$V3 <-make.names(features$V2)

#Assing the feature names as column names to the data frame.
colnames(x) <- features$V3

#Name the column as subject_id
colnames(subjects) <- c("subject")

#Combine the dataframe x and y to be able to access the feature data for a given subject.
data <-  cbind(subjects,activity,x)

#Get All the Mean and Std columns from the features Vector.
allRequiredFeatureCols <- rbind(features[grep('mean',features$V2),],
                                features[grep('Mean',features$V2),],
                                features[grep('std',features$V2),])

#Get a vector which contains all the column names including the subject, activity and all the Mean and Std feaure columns.
allRequiredCols <- c("subject","activity",allRequiredFeatureCols$V3)

#Select only the required Columns from the final_data.
final_data <- data[,allRequiredCols]

#loading the sqldf package
library(sqldf)

#Summarise the final data grouping by subject and activity id. Here I used the sqldf library and wrote the SQL to group the data.
summarised_data <- sqldf('SELECT subject,activity
                         ,avg("tBodyAcc.mean...X")                   
                         ,avg("tBodyAcc.mean...Y")                   
                         ,avg("tBodyAcc.mean...Z")                   
                         ,avg("tGravityAcc.mean...X")                
                         ,avg("tGravityAcc.mean...Y")                
                         ,avg("tGravityAcc.mean...Z")                
                         ,avg("tBodyAccJerk.mean...X")               
                         ,avg("tBodyAccJerk.mean...Y")               
                         ,avg("tBodyAccJerk.mean...Z")               
                         ,avg("tBodyGyro.mean...X")                  
                         ,avg("tBodyGyro.mean...Y")                  
                         ,avg("tBodyGyro.mean...Z")                  
                         ,avg("tBodyGyroJerk.mean...X")              
                         ,avg("tBodyGyroJerk.mean...Y")              
                         ,avg("tBodyGyroJerk.mean...Z")              
                         ,avg("tBodyAccMag.mean..")                  
                         ,avg("tGravityAccMag.mean..")               
                         ,avg("tBodyAccJerkMag.mean..")              
                         ,avg("tBodyGyroMag.mean..")                 
                         ,avg("tBodyGyroJerkMag.mean..")             
                         ,avg("fBodyAcc.mean...X")                   
                         ,avg("fBodyAcc.mean...Y")                   
                         ,avg("fBodyAcc.mean...Z")                   
                         ,avg("fBodyAcc.meanFreq...X")               
                         ,avg("fBodyAcc.meanFreq...Y")               
                         ,avg("fBodyAcc.meanFreq...Z")               
                         ,avg("fBodyAccJerk.mean...X")               
                         ,avg("fBodyAccJerk.mean...Y")               
                         ,avg("fBodyAccJerk.mean...Z")               
                         ,avg("fBodyAccJerk.meanFreq...X")           
                         ,avg("fBodyAccJerk.meanFreq...Y")           
                         ,avg("fBodyAccJerk.meanFreq...Z")           
                         ,avg("fBodyGyro.mean...X")                  
                         ,avg("fBodyGyro.mean...Y")                  
                         ,avg("fBodyGyro.mean...Z")                  
                         ,avg("fBodyGyro.meanFreq...X")              
                         ,avg("fBodyGyro.meanFreq...Y")              
                         ,avg("fBodyGyro.meanFreq...Z")              
                         ,avg("fBodyAccMag.mean..")                  
                         ,avg("fBodyAccMag.meanFreq..")              
                         ,avg("fBodyBodyAccJerkMag.mean..")          
                         ,avg("fBodyBodyAccJerkMag.meanFreq..")      
                         ,avg("fBodyBodyGyroMag.mean..")             
                         ,avg("fBodyBodyGyroMag.meanFreq..")         
                         ,avg("fBodyBodyGyroJerkMag.mean..")         
                         ,avg("fBodyBodyGyroJerkMag.meanFreq..")     
                         ,avg("angle.tBodyAccMean.gravity.")         
                         ,avg("angle.tBodyAccJerkMean..gravityMean.")
                         ,avg("angle.tBodyGyroMean.gravityMean.")    
                         ,avg("angle.tBodyGyroJerkMean.gravityMean.")
                         ,avg("angle.X.gravityMean.")                
                         ,avg("angle.Y.gravityMean.")                
                         ,avg("angle.Z.gravityMean.")                
                         ,avg("tBodyAcc.std...X")                    
                         ,avg("tBodyAcc.std...Y")                    
                         ,avg("tBodyAcc.std...Z")                    
                         ,avg("tGravityAcc.std...X")                 
                         ,avg("tGravityAcc.std...Y")                 
                         ,avg("tGravityAcc.std...Z")                 
                         ,avg("tBodyAccJerk.std...X")                
                         ,avg("tBodyAccJerk.std...Y")                
                         ,avg("tBodyAccJerk.std...Z")                
                         ,avg("tBodyGyro.std...X")                   
                         ,avg("tBodyGyro.std...Y")                   
                         ,avg("tBodyGyro.std...Z")                   
                         ,avg("tBodyGyroJerk.std...X")               
                         ,avg("tBodyGyroJerk.std...Y")               
                         ,avg("tBodyGyroJerk.std...Z")               
                         ,avg("tBodyAccMag.std..")                   
                         ,avg("tGravityAccMag.std..")                
                         ,avg("tBodyAccJerkMag.std..")               
                         ,avg("tBodyGyroMag.std..")                  
                         ,avg("tBodyGyroJerkMag.std..")              
                         ,avg("fBodyAcc.std...X")                    
                         ,avg("fBodyAcc.std...Y")                    
                         ,avg("fBodyAcc.std...Z")                    
                         ,avg("fBodyAccJerk.std...X")                
                         ,avg("fBodyAccJerk.std...Y")                
                         ,avg("fBodyAccJerk.std...Z")                
                         ,avg("fBodyGyro.std...X")                   
                         ,avg("fBodyGyro.std...Y")                   
                         ,avg("fBodyGyro.std...Z")                   
                         ,avg("fBodyAccMag.std..")                   
                         ,avg("fBodyBodyAccJerkMag.std..")           
                         ,avg("fBodyBodyGyroMag.std..")              
                         ,avg("fBodyBodyGyroJerkMag.std..")          
                         from final_data
                         group by subject                             
                         ,activity')
  
colnames(summarised_data) <- allRequiredCols

#Write the Summarised Data to summarised_data.txt file.
write.table(summarised_data , "summarised_data.txt",row.names = FALSE)
