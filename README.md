# Streamroot Data Analysis
The following is a small data exploration task over the Streamroot dataset.
- The datasets can be found in this repository along with the R script and an export of the Superset dashboard used.
- For the Superset dashboard it is necessary to create a table called `Streamroot` and filled it with the dataset generated at the end of the R script. (Is it possible that the URL for the connection to the database has to be fixed in order for it to be imported).

## Technology Used
For this task a mixture between R and Superset as a programming language for a statistical approach and a data exploration platform respectively were used. In this case R provides the right tools to develop explorative analysis over the given data set, while Superset allows the creation of beautiful image representations of the data in order to have a better understanding of it. As Streamroot already works with this technologies, this approach makes sense for exploring the given dataset.

## Description
The first step to approach this task is having an understanding of the data. For this a short description is given below.
![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/1_variables.png)

From this infomation a couple features can be generated: 
- total: Total of data transmitted to an user (p2p + cdn)
- percentage_p2p: Percentage of the total data transmitted through P2P (p2p / cdn).

If we visualize the data, we can notice a couple interesting findings.

![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/2_isp_browser.png)
- EarthWolf is the most used browser followed by Iron, while Vetrice and Swamp are significantly less used.
- BTP, Arange and Fire are the most used ISPs, while Datch Telecam and Olga are significantly less used.
- BTP is by far the ISP that uses the most of the P2P network.
- It is important to understand as well that when a user is not connected to the Streamroot backend there is no data downloaded from the P2P network.

![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/2_isp_relation.png)
- It becomes clear as well that ISP BTP makes the most usage of the P2P network, while ISPs Datch Telecam and Olga have little to none P2P usage.
- For Arange and Fro the usage is very small as well, but the logarithmic scale allows us to view more properly the usage of the P2P, compared to the other browsers.

 ![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/2_browser_relation.png)
- For browsers, both Earthwolf and Iron take the most advantage of the traffic through the P2P network, whereas Vectrice does not use it at all (maybe is not supported).
- It is interesting to notice that the Swamp browser has the biggest relation between P2P/CDN (even if the amount of total data is relatively low), making it the browser with most efficient use of the P2P network.


Aditional to this, a simple MCA analysis was made over the data provided. For this the continous data was categorized and the results can seen below.

![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/3_mca_results.png)
![alt tag](https://raw.githubusercontent.com/jampmil/Streamroot/master/images/3_mca_plot.png)

Although no much data is grouped in the first two dimensions, this analysis gives us a couple interesting ideas about the dataset:
- There is a strong correlation between the ISP Datch Telecam and having no connection to the P2P network.
- There is a strong correlation between the ISP Olga and having a low percentage of usage of the P2P network.
- The analysis also confirms that the ISP BTP presents the highest percentage of usage of the P2P network.
- There is no relevant information derived for the browsers in this analysis.


## Data-driven Recommendations to Improve the service

According to the presented results, the following recommendations can be followed to improve the service.
- Add support to the Vetrice browser in order to reduce the workload over the server for users using this browser.
- Investigate why the ISP Data Telecam are not supporting traffic over the P2P network.
- Investigate why the ISP Olga has a low usage of the P2P network.
- Investigate the reason why the Swamp browser uses in average the P2P network the most. If possible replicate results in the implementation for other browsers.


## Future Work

Considering the dataset received and the task in hand, a further exploration could follow the presented work. It is possible to think that a clustering analysis could throw new ideas that could be used to improve the performance of the service.

Along with this, a study over the relationship of the P2P and the CDN transmitted data could be done where, with the other features (and including a time related dimension),  a prediction of the amount of data that is going to be transmitted for both the P2P and CDN network could be done, so the infrastructure could react and automatically change its configuration to provide a better service. 


