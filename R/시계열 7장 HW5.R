## Example7.1: 비정상 확률과정

setwd("C:/R")
getwd()
z<-scan("depart.txt")
dept=ts(z,start=c(1984,1), frequency=12)
ldept=log(dept)
ldept
dif_1=diff(ldept,lag=1)
dif_1
dif_12=diff(ldept,lag=12)
dif_112=diff(dif_1,lag=12)
dif_112

ts.plot(dept,ylab="depart",main="그림 7-1 백화점 월별 매출액")
ts.plot(ldept,ylab="ln depart",main="그림 7-2 로그매출액")
ts.plot(dif_1,ylab="diff1",main="그림 7-5 1차 차분된 로그매출액"); abline(h=0)
ts.plot(dif_12,ylab="diff1&12",main="계절 차분된 로그매출액")
ts.plot(dif_112,ylab="diff1&12",main="그림 7-6 계절 차분된 로그매출액"); abline(h=0)




