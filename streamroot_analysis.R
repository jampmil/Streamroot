
############ Used Libraries ############
# install.packages("klaR") 
# install.packages("corrplot")
require(klaR)
require(stats)
library(FactoMineR)
library(ggplot2)

############ Working Directory Hot Fix ############

# Changes the working directory to the folder of the current file
this.dir <- NULL
tryCatch(this.dir <- dirname(sys.frame(1)$ofile), error = function(e) print('Getting file path from location of the file.'))

if(is.null(this.dir))
  this.dir <-dirname(rstudioapi::getActiveDocumentContext()$path)
if(is.null(this.dir)){
  print("Setting working directory failed. Script might fail to work.")
}else{
  setwd(this.dir)
  print(paste("Working directory changed successfully to: ", this.dir))
}


############ Data Import ############

#Read CSV File
mydata = read.csv("data.csv")

#view the dataset
#stream: ID of the video content (values from 1 to 9)
#isp: Name of the user's ISP (5 different values)
#browser: Name of the user's browser (4 different values)
#connected: True if the user is connected to the Streamroot backend
#p2p: The data downloaded through the P2P network
#cdn: The data downloaded directly from the CDN
summary(mydata)
str(mydata)

############ Data Cleansing ############
#Fix the column names
colnames(mydata) <- c("stream", "isp", "browser", "connected", "p2p", "cdn")

#Fix NA's
mydata$cdn[is.na(mydata$cdn)] <- 0

#Add total and percentage columns
mydata$total <- mydata$p2p + mydata$cdn
mydata$percentage_p2p <- (mydata$p2p / mydata$total)

#convert stream an connected variables to factors
mydata$stream <- factor(mydata$stream)
mydata$connected <- factor(mydata$connected)

#cut the p2p and cdn variables into categorical and fix the labels
mydata$c_p2p<-cut(mydata$p2p, 10)
mydata$c_cdn<-cut(mydata$cdn, 10)
mydata$c_percentage_p2p<-cut(mydata$percentage_p2p, 10)

levels(mydata$c_p2p) <- c("1_p2p", "2_p2p", "3_p2p", "4_p2p", "5_p2p", "6_p2p", "7_p2p", "8_p2p", "9_p2p", "10_p2p")
levels(mydata$c_cdn) <- c("1_cdn", "2_cdn", "3_cdn", "4_cdn", "5_cdn", "6_cdn", "7_cdn", "8_cdn", "9_cdn", "10_cdn")
levels(mydata$c_percentage_p2p) <- c("1_per", "2_per", "3_per", "4_per", "5_per", "6_per", "7_per", "8_per", "9_per", "10_per")


############ MCA ############

#Create the dataframe for the MCA
mca_mydata <- mydata[,c("isp","browser","connected", "c_percentage_p2p")]

#Obtain the differerent categories of the dataframe
cats = apply(mca_mydata, 2, function(x) nlevels(as.factor(x)))

# apply MCA
mca_res = MCA(mca_mydata, graph = FALSE)

# list of results
summary(mca_res, nb.dec = 2, ncp = 3, nbelements = 18)

# create a data frame with the variable coordinates
mca_res_vars_df = data.frame(mca_res$var$coord, Variable = rep(names(cats), cats))

# create data frame with the observation coordinates
mca_res_obs_df = data.frame(mca_res$ind$coord)

# plot of variable categories
ggplot(data=mca_res_vars_df, 
       aes(x = Dim.1, y = Dim.2, label = rownames(mca_res_vars_df))) +
    geom_hline(yintercept = 0, colour = "gray70") +
    geom_vline(xintercept = 0, colour = "gray70") +
    geom_text(aes(colour=Variable)) +
    ggtitle("MCA for Streamroot Data")

############ Export Data for Superset ############

#Create the dataframe to export
mydata_export <- mydata[, c("stream", "isp", "browser", "connected", "p2p", "cdn", "total", "percentage_p2p")]

# Export the dataframe
write.csv(mydata_export, file = "data_superset.csv")
