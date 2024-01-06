## Example 8.6  : 가스로 자료 분석

install.packages("astsa")
install.packages("lmtest")
install.packages("forecast")
library(astsa)       # library for function acf2 & sarima
library(lmtest)      # library for function coeftest
library(forecast)    # Arima & ndiffs 함수 사용


gas <- scan("c:/R/gas.txt", what=list(0,0))  #두개의 리스트 첫번째는 첫번쨰에 넣고 두번째는 두번쨰에 넣기
gas
str(gas)
names(gas) <- c("rate","co2")  # 변수명 생성
gasrate <- data.frame(gas)  
time <- 1:nrow(gasrate)
rate <- ts(gas$rate)
co2 <- ts(gas$co2)


ts.plot(rate)
acf(rate)
pacf(rate) #기둥 3개

acf2(rate, max.lag=24) # acf(p) 확률 1인 애 없애고 보여줌& pacf(q) 같이 출력 


fit1 <- arima(rate, order=c(3,0,0))  # 절편있는 AR(3) 모형적합
fit1
summary(fit1)
coeftest(fit1)

fit2 <- arima(rate, order=c(3,0,0), include.mean=F)  # 절편없는 AR(3) 모형적합
fit2
summary(fit2)
coeftest(fit2)

fit3 <- Arima(rate, order=c(3,0,0), include.mean=F)  # 절편없는 AR(3) 모형적합
fit3
summary(fit3)
coeftest(fit3)


ts.plot(resid(fit2))
acf2(resid(fit2), maxlag=24)


qqnorm(resid(fit2), main="그림 8-5   잔차의 정규성 검정")
qqline(resid(fit2), col = "red")


tsdiag(fit2)


sarima(rate, 3,0,0)  # sarima를 이용한 모형 적합을 이용한 경우
sarima.for(rate, 12, 3, 0, 0) #예측값의 시계열 그림
 
## Example 8.7 : 과대적합
library(astsa)       # library for function acf2 & sarima
library(lmtest)      # library for function coeftest

z <- scan("c:/R/eg8_7.txt")
z.ts <- ts(z)
ts.plot(z.ts, ylab="z", main="그림  8-6 모의 실험 자료 ")
acf2(z.ts, max.lag=24, main="그림 8-6  ACF & PACF") 
fit <- arima(z.ts,order=c(1,0,0));  ###과대적합
summary(fit)
coeftest(fit)
ts.plot(resid(fit),  main="그림 8-7  잔차", ylab="residual");  abline(h=0)
acf2(resid(fit), maxlag=24, main="그림 8-8 잔차 SACF와 SPACF")
qqnorm(resid(fit), main="그림 8-9  잔차의 정규성 검정 ") #난수발생해서 나온건데 정규분포를 잘 따르고 있음( 흔하지 않다)
qqline(resid(fit), col = "red")

tsdiag(fit)
sarima.for(z.ts, 25, 1,0,0)  
sarima(z.ts, 2,0,0)    
sarima(z.ts, 1,0,1) 



#-----------------------------------------------------------여기까지 시험범위 8.7까지-----------



## Example 8.8  : 단위근 검정
library(astsa)       # library for function acf2 & sarima
library(lubridate)    # library for function ymd
library(tseries)   # library for function adf.test & pp.test

z <- scan("c:/data_R/elecstock.txt")
stock <- ts(z)
ts.plot(stock, ylab="stock", main="그림 8-10  주가지수의 시계열그림")
acf2(stock, max.lag=24, main="그림 8-10  주가지수의 ACF & PACF")

# ADF 검정 
adf.test(stock)    # ADF 검정
pp.test(stock)     # PP 검정

dstock <- diff(stock, lag=1)  
ts.plot(dstock, ylab="diff(stock)", 
        main="그림 8-11  차분된 주가지수");  abline(h=0)
acf2(dstock, maxlag=24)  

fit = arima(stock, order=c(1,0,0), method="CSS");  fit
acf2(resid(fit))
fit1 = arima(stock, order=c(0,1,0));
summary(fit1)
acf2(resid(fit1))

## Example 8.9 : Female Worker
library(astsa)       # library for function acf2 & sarima
library(lubridate)    # library for function ymd
library(lmtest)      # library for function coeftest
library(ggplot2)     # library for function ggplot

z <- scan("c:/data_R/female.txt")
female <- ts(z)
ts.plot(female, ylab="female", main="그림 8-9  여성 근로자")
date <- ymd("821201") + months(1:length(female)-1) 
femaledf <- data.frame(female, date) 
acf2(female, max.lag=24, main="그림 8-9  여성 근로자의 ACF & PACF")

adf.test(female)

fit1 <- lm(female~date, data=femaledf)  # 선형모형 적합
coefficients(fit1)  
residual <- residuals(fit1)

resdf <- data.frame(date, residual) 
ggplot(aes(x=date, y=residual), data=resdf) + geom_line() 
dfemale <- diff(female, lag=1) 
ts.plot(dfemale, ylab="diff(female)", 
        main="그림 8-10  차분된 여성 근로자 ");  abline(h=0) 
acf2(dfemale, maxlag=24, main="그림 8-10  ACF & PACF") 
fit2 <- arima(female, order=c(0,1,0), method="ML", include.mean=T)  
fit2 
coeff(fit2)
summary(fit2)