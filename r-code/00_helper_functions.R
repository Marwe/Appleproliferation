
#******************************  Data exploration ***************************#


# USEFUL DEFINITIONS
unit <- list(
  mgl = expression(paste("(",mg~l^{-1},")")),
  mgkg = expression(paste("(",mg~kg^{-1},")")),
  mugl = expression(paste("(",mu,g~l^{-1},")")),
  mugkg = expression(paste("(",mu,g~kg^{-1},")")),
  mum = expression(paste("(",mu,m,")")),
  temp = expression(paste("T (",degree,"C)")),
  oxy = expression(paste(O[2]," (",mg~l^{-1},")")),
  phyto= expression(paste("Phytoplankton (",mg~l^{-1},")")),
  phos = expression(paste(PO[4]^{3-phantom(0)},"(",mu,g~l^{-1},")"))
)


# Standard error of a mean
se<-function(x) sqrt(var(x)/length(x))


# Error bars for boxplots
#Usage error.bar(means, standard errors and bar labels)
error.bars<-function(yv,z,nn,ylab,ylim,main,cex.names){
  xv<-barplot(yv,ylim=ylim,names=nn,ylab=ylab,main=main,cex.names=cex.names)
  g=(max(xv)-min(xv))/50
  for (i in 1:length(xv)) {
    lines(c(xv[i],xv[i]),c(yv[i]+z[i],yv[i]-z[i]))
    lines(c(xv[i]-g,xv[i]+g),c(yv[i]+z[i], yv[i]+z[i]))
    lines(c(xv[i]-g,xv[i]+g),c(yv[i]-z[i], yv[i]-z[i]))
  }}



# rounding up: 
# k=2, 321-> 400, 3221->3300
# k=3  321 -> 1000, 3221 -> 4000
roundout <- function(x,k){(floor( abs(x/10^k) +0.499999999999 ) +1)*10^k}



# 3 significant digits
NumToString <- function(nval, sigdig=3, xpcut=4) {   # Filter out zero as a special case; calculate digits after the decimal
  # from number of significant digits 
  if (nval == 0) digs = sigdig - 1 else digs <- sigdig - 1 - floor(log10(abs(nval))) 
  # Can't be negative 
  if (digs < 0) digs <- 0 
  # Switch to scientific notation if digits after the decimal > xp   
  if (digs > xpcut) { fchar <- "e"; digs <- sigdig - 1 } else fchar <- "f" 
  sprintf(paste("%.", digs, fchar, sep=""), nval) }
#library(broman) # rounding




###################
#  randomOrchard  #
###################

# function selects a random number of orchards within a grid
# random number is specified in option "random points"


# > head(grid1000parcelOG)
# id grid_id   parcel orchard_id          name address_id register_ger  st_area        region       st_asewkt
# 1   4    8272      987      10001 Goegele Anton      1_CAF         MAIS 3399.554 Burggrafenamt  SRID=32632;MULTIPOLYGON(((666782.918655855 5168810.80397938,.....
# 2   5    8432  1758/62       8772 Goegele Anton      1_CAF         MAIS 4093.301 Burggrafenamt
# 3   6    8432 1758/298       8772 Goegele Anton      1_CAF         MAIS 2775.889 Burggrafenamt
# 4   7    8432  1758/62       8772 Goegele Anton      1_CAF         MAIS 4093.301 Burggrafenamt
# 5   8    8432 1758/298       8772 Goegele Anton      1_CAF         MAIS 2775.889 Burggrafenamt
# 6 120    9237   2477/1        445  Zoeschg Toni      1_LAN         LANA 3352.076 Burggrafenamt



randomOrchard<-function(df,randomPoints){
  uniqueGrids<-unique(df$grid_id)
  
  df.new<-data.frame(matrix(0,ncol=ncol(df),nrow=randomPoints*length(uniqueGrids)))
  counterNewDf=1
  counterUniqueGrids=1
  
  
# randomPoints = 1
if(randomPoints==1){
  for (i in uniqueGrids){
    if(length(which(df$grid_id==uniqueGrids[counterUniqueGrids]))==1){
      df.new[counterNewDf,] <- df[which(df$grid_id==uniqueGrids[counterUniqueGrids]),]
    }
    else{
      df.new[counterNewDf,] <- df[sample(which(df$grid_id==uniqueGrids[counterUniqueGrids]),randomPoints),]
    }
    counterNewDf=counterNewDf+randomPoints
    counterUniqueGrids=counterUniqueGrids+1
  } # closes loop
} # closes randomPoints = 1


# randomPoints = 3
if(randomPoints==3){
  for (i in uniqueGrids){
    if(length(which(df$grid_id==uniqueGrids[counterUniqueGrids]))>=3){
      df.new[counterNewDf:(counterNewDf+randomPoints-1),] <- df[sample(which(df$grid_id==uniqueGrids[counterUniqueGrids]),randomPoints),]
    }
    else{
      print(paste("Grid ",uniqueGrids[counterUniqueGrids], " with less than 3 parcels",sep=""))
    }
    counterNewDf=counterNewDf+randomPoints
    counterUniqueGrids=counterUniqueGrids+1
  } # closes loop
} # closes randomPoints = 3

colnames(df.new)<-colnames(df)
return(df.new)

} # closes function
