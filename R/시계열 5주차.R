## Example 2.1: 선형모형 적합

getwd()
setwd("C:/regression")
getwd()



z<-scan("population.txt")
z
pop=round(z/10000)           
pop=ts(pop,start=c(1960))
pop
t<-1:length(pop)
t2 = t*t
m1<-lm(pop~t)
summary(m1)

install.packages("lmtest")
library(lmtest)              #library for DW
dwtest(m1)

ts.plot(pop,fitted(m1),xlab="year",ylab="population", 
        lty=1:2, main="그림 2-3 총인구와 선형모형 예측값")
legend("topleft",legend=c("pop","fitted"),lty=1:2)

ts.plot(resid(m1),type="o",xlab="year",ylab="residual", 
         main="그림 2-4 선형모형 적합 후 잔차"); abline(h=0)

acf(resid(m1), main="잔차의 ACF")

#------------------------------------쉅
m2<-lm(pop~t+t2)
summary(m2)
ts.plot(pop,fitted(m2),xlab="year",ylab="population", 
        lty=1:2, main="그림 2-5 2차 추세모형 예측값")
ts.plot(resid(m2), type="o", ylab= "residual", main="그림 2-6 2차 추세모형 적합 후의 잔차"); abline(h=0)
legend("topleft", legend=c("pop", "fitted"), lty=1:2)
acf(resid(m2), main="잔차의 ACF")
#3차 모형----------------------
lnpop <- log(pop)
m3 <-lm(lnpop ~ t+t2)
dwtest(m3)
summary(m3)
ts.plot(lnpop, fitted(m3), xlab="year", ylab= "log population", lty= 1:2,
        main="로그변환 후 2차 추세모형 예측값")
legend("topleft", legend=c("lnpop", "fitted"), lty= 1:2)
ts.plot(resid(m3), ylab="residual",
main="그림 2-7 로그변환 후 2차 추세모형 적합 후 잔차") ; abline(h=0)
acf(resid(m3), main="잔차의 ACF")




 #2.2 지시함수를 이용한 계절모형 적합<<추세성분과 계절성분 동시에 갖는 모형>>

install.packages("lmtest")
install.packages("astsa")
library(astsa)
library(lmtest)

z<-scan("depart.txt")
dep<-ts(z,frequency=12,start=c(1984,1))
ts.plot(dep,ylab="depart",main="그림 2-9 백화점매출액")
lndep<-log(dep)
ts.plot(lndep,ylab="depart",main="그림 2-10 로그매출액")
trend=time(lndep)-1984


y=factor(cycle(lndep))
y
reg<-lm(lndep~0+trend+y)   # trend + y -1 같음
reg<-lm(lndep~trend+y-1) 
dwtest(reg)
summary(reg)
model.matrix(reg)
resid=ts(resid(reg),start=c(1984,1),frequency=12)
ts.plot(resid(reg),ylab="residual",main="그림 2-11 잔차"); abline(h=0) #양의 자기상관이 있음
acf2(resid(reg),main="잔차의 ACF & PACF")


#6주차
##Example 2.4 : 자기회귀오차모형
library(astsa) # library for function acf2 dept <- scan("d:/depart.txt")
dept<-scan("depart.txt")
n<- 1:length(dept)

time <- ts(n, frequency= 12, start= c(1984,1))


dept.ts <- ts(dept, frequency=12, start=c(1984,1))
lndept=log(dept.ts)
y = factor(cycle(time))
fit <- lm(lndept~ 0+time +y)
anova(fit)
summary (fit)
resid=ts(resid(fit), start =c(1984,1), frequency=12)
acf2(resid, main= "Residual ACF & PACF")
autoreg <- arima(residuals(fit), order=c(3,0,0))# 자기회귀오차모형
summary (autoreg)
plot(resid(autoreg), main="그림 2-17 자기회귀모형 적합 후 잔차")
abline(h=0)
 


