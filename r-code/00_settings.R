library(RPostgreSQL)

drv<-dbDriver("PostgreSQL")
con<-dbConnect(drv,dbname="cacopsylla",host="localhost",port=5432,user="pillo",password="***REMOVED***")
#summary(con)
#dbListTables(con)

#dbDisconnect(con)
#dbUnloadDriver(drv)

# ... <-dbGetQuery(con,"select * FROM .... ORDER BY id")