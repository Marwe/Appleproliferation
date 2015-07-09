---
author: "Bernd Panassiti" 
title: "Presentation of percentual disease prevalence"
output: pdf_document
---
date created: 20.02.2015, date modified:  


Presentation of percentual disease prevalence
========================================================




```r
rm(list=ls(all=TRUE))
source("r-code/00_settings.r")

library(ggplot2)
set.seed(2013)
```


In PostgreSQL:

CREATE TABLE ap_prevalence AS
(Select 
a.id,a.site_id,a.row,a.monitoring_id,a.witchs_broom_2014,a.enlarged_stipules_2014,
a.small_fruit_2014,a.reddening_2014,a.dense_shoots_2014,a.late_blooming_2014,
a.new_planting_2014,a.comments_2014,a.cut,a.checkplant,a.cultivar,b.region
FROM og_appletrees a LEFT JOIN og_parcel_randomorchard b
ON a.site_id = b.id
ORDER BY a.id);




```r
appletreesRegion<-dbGetQuery(con,"select 
site_id,row,id,monitoring_id,witchs_broom_2014,enlarged_stipules_2014,
small_fruit_2014,reddening_2014,dense_shoots_2014,late_blooming_2014,
new_planting_2014,comments_2014,cut,checkplant,cultivar,region
FROM ap_prevalence ORDER BY id")
```




```r
df <- appletreesRegion[!is.na(appletreesRegion$monitoring_id),] # get all orchards that are processed -> monitoring_id != NULL
dfVOG <- df[df$region=="Burggrafenamt",]
dfVIP <- df[df$region=="Vinschgau",]
dfVOGGolden <- df[which(df[,16]=="Burggrafenamt" & df[,15] == "Golden"),]
dfVIPGolden <- df[which(df[,16]=="Vinschgau" & df[,15] == "Golden"),]
```




```r
nrow(df[which(df[,c(5,6,8)]==1),])/nrow(df)*100 # total prevalence (%)
```

```
## [1] 0.9780602
```

```r
nrow(dfVOG[which(dfVOG[,c(5,6,8)]==1),])/nrow(dfVOG)*100 # total prevalence (%) for Burggrafenamt
```

```
## [1] 1.095658
```

```r
nrow(dfVIP[which(dfVIP[,c(5,6,8)]==1),])/nrow(dfVIP)*100 # total prevalence (%) for Vinschgau
```

```
## [1] 0.6406008
```

```r
nrow(dfVOGGolden[which(dfVOGGolden[,c(5,6,8)]==1),])/nrow(dfVOGGolden)*100 # total prevalence (%) for Burggrafenamt for Golden Delicious
```

```
## [1] 0.6707222
```

```r
VIPGoldenPreval <- nrow(dfVIPGolden[which(dfVIPGolden[,c(5,6,8)]==1),])/nrow(dfVIPGolden)*100 # total prevalence (%) for Vinschgau for Golden Delicious
```



2

