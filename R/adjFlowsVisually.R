
# adjust flows visually based on png images 
# data stored in img/imgAdjFlow.xls

adjustFlowsVisually <- function(f){
  
  f$flow[f$date == '2017-08-23'] <- 24.6
  f$flow[f$date == '2017-10-27'] <- 30
  f$flow[f$date == '2017-10-26'] <- 30
  f$flow[f$date == '2017-06-22'] <- 20
  f$flow[f$date == '2017-11-03'] <- 90
  f$flow[f$date == '2017-10-25'] <- 100
  f$flow[f$date == '2017-03-27'] <- 50
  f$flow[f$date == '2017-05-09'] <- 60
  f$flow[f$date == '2017-04-13'] <- 60
  f$flow[f$date == '2017-04-21'] <- 60
  f$flow[f$date == '2017-10-29'] <- 70
  f$flow[f$date == '2017-10-30'] <- 300
  
  return(f)
}