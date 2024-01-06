#시계열 9주차

##Example 4.1: 분해법 -> 교재 참고 안함. 

setwd("C:/R")
getwd()

z<-scan("food.txt")
t<-1:length(z)
food<-ts(z, start=c(1981,1), frequency = 12)
food

fit <- lm(food~t)
anova(fit) #<표 4-1>
trend <-fitted(fit)
trend
fit
ts.plot(food,trend,col=1:2,lty=1:2,ylab="food",xlab="time", 
        main="그림 4-1 원시계열과 분해법에 의한 추세성분")
legend("topleft",col=1:2,lty=1:2, c("원시계열","분해") )
adjtrend = food/trend
plot(adjtrend)

y=factor(cycle(adjtrend)) #범주로 놓자. factor=> 범주화 함수


fit1<-lm(adjtrend ~ 0+y) #상수항 제거 sas noint & lm(adjtrend ~ y-1)과 동일
fit1 #<표 4-2>
seasonal = fitted(fit1)
pred = trend*seasonal
irregular=food/pred

ts.plot(seasonal, main="그림 4-2 분해법에 의한 계절성분")
ts.plot(irregular, main="그림 4-3 분해법에 의한 불규칙성분")
acf(irregular, main="불규칙성분의 ACF")
ts.plot(food,pred,lty=1:2,ylab="food", col=c("blue", "red"), 
        main="그림 4-4 원시계열과 예측값")
legend("topleft", lty=1:2, col=c("blue", "red"), c("원시계열", "예측값"))

date<- ymd("810101") + months(1:length(food)-1)
table4 <- data.frame(food, trend, seasonal, irregular)
table4 # <표 4-3>
##라이브러리 ymd


