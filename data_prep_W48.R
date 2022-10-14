# data from Household Pulse Wave 48, which was July 27 - August 8 in 2022

# https://www.census.gov/programs-surveys/household-pulse-survey/datasets.html

require(gdata)
require(plyr)
require(dplyr)
require(tidyverse)


d1 <- read.csv("pulse2022_puf_48.csv")

d2 <- d1[c("RHISPANIC","RRACE","EEDUC","MS","EGENID_BIRTH","GENID_DESCRIBE","SEXUAL_ORIENTATION",
           "KIDS_LT5Y","KIDS_5_11Y","KIDS_12_17Y",
           "TENROLLPUB","TENROLLPRV","TENROLLHMSCH","ENROLLNONE",
           "RECVDVACC","NUMDOSES","BOOSTERRV","KIDDOSESRV", "KIDGETVAC_LT5Y","KIDGETVAC_5_11Y", "KIDGETVAC_12_17Y",
           "HADCOVIDRV", "LONGCOVID", "SYMPTOMS", "WRKLOSSRV","ANYWORK","KINDWORK","RSNNOWRKRV",
           "CHLDCARE", "TWDAYS", "TSPNDFOOD",
           "CURFOODSUF","CHILDFOOD","ANXIOUS","WORRY",
           "TENURE","LIVQTRRV","RENTCUR","MORTCUR","EVICT","FORCLOSE",
           "EST_ST","PRIVHLTH","PUBHLTH","REGION","INCOME","TBIRTH_YEAR")]

# compared with W36, changes in varbs
# add:
# NUMDOSES BOOSTERRV KIDDOSESRV KIDGETVAC_LT5Y KIDGETVAC_5_11Y KIDGETVAC_12_17Y HADCOVIDRV LONGCOVID TWDAYS TSPNDFOOD
# del:
#   DOSESRV GETVACRV KIDDOSES KIDGETVAC HADCOVID ACTIVITY1 ACTIVITY2 ACTIVITY3 ACTIVITY4 TENROLLPUB TENROLLPRV TENROLLHMSCH ENROLLNONE 



d2$RHISPANIC <- as.factor(d2$RHISPANIC)
levels(d2$RHISPANIC) <- c("Not Hispanic","Hispanic")

d2$RRACE <- as.factor(d2$RRACE)
levels(d2$RRACE) <- c("White","Black","Asian","Other")

d2$EEDUC <- as.factor(d2$EEDUC)
levels(d2$EEDUC) <- c("less than hs","some hs","HS diploma","some coll","assoc deg","bach deg","adv deg")

d2$MS <- as.factor(d2$MS)
levels(d2$MS) <- c("NA","married","widowed","divorced","separated","never")

d2$EGENID_BIRTH <- as.factor(d2$EGENID_BIRTH)
levels(d2$EGENID_BIRTH) <- c("male","female")

d2$GENID_DESCRIBE <- as.factor(d2$GENID_DESCRIBE)
levels(d2$GENID_DESCRIBE) <- c("NA","male","female","transgender","other")

d2$SEXUAL_ORIENTATION <- as.factor(d2$SEXUAL_ORIENTATION)
levels(d2$SEXUAL_ORIENTATION) <- c("NA","gay or lesbian","straight","bisexual","something else","dont know")

d2$KIDS_LT5Y <- as.factor(d2$KIDS_LT5Y)
levels(d2$KIDS_LT5Y) <- c("NA","NA","Yes children under 5 in HH")

d2$KIDS_5_11Y <- as.factor(d2$KIDS_5_11Y)
levels(d2$KIDS_5_11Y) <- c("NA","NA","Yes children 5 - 11 in HH")

d2$KIDS_12_17Y <- as.factor(d2$KIDS_12_17Y)
levels(d2$KIDS_12_17Y) <- c("NA","NA","Yes children 12 - 17 in HH")


is.na(d2$TENROLLPUB) <- which((d2$TENROLLPUB == -99) | (d2$TENROLLPUB == -88)) # number of kids enrolled in public school
is.na(d2$TENROLLPRV) <- which((d2$TENROLLPRV == -99) | (d2$TENROLLPRV == -88)) # number of kids enrolled in private school
is.na(d2$TENROLLHMSCH) <- which((d2$TENROLLHMSCH == -99) | (d2$TENROLLHMSCH == -88)) # number of kids in home school
d2$ENROLLNONE <- as.factor(d2$ENROLLNONE)
levels(d2$ENROLLNONE) <- c("NA","NA","children not in any type of school")

d2$RECVDVACC <- as.factor(d2$RECVDVACC)
levels(d2$RECVDVACC) <- c("NA","yes got vaxx", "no did not get vaxx")

# d2$DOSESRV <- as.factor(d2$DOSESRV)
# levels(d2$DOSESRV) <- c("NA","NA","yes got all doses","yes plan to get all doses","no will not get all doses")

# d2$GETVACRV <- as.factor(d2$GETVACRV)
# levels(d2$GETVACRV) <- c("NA","NA","definitely will get vaxx","probably will get vaxx","unsure about vaxx","probably not","definitely not")
# 
# d2$KIDDOSES <- as.factor(d2$KIDDOSES)
# levels(d2$KIDDOSES) <- c("NA","NA","Yes kids got or will get all doses","no kids did not or will not")
# 
# d2$KIDGETVAC <- as.factor(d2$KIDGETVAC)
# levels(d2$KIDGETVAC) <- c("NA","NA","definitely will get vaxx","probably will get vaxx","unsure about vaxx","probably not","definitely not","dont know yet")
# 
# d2$HADCOVID <- as.factor(d2$HADCOVID)
# levels(d2$HADCOVID) <- c("NA","NA","yes doctor told had covid","no did not","not sure")

d2$WRKLOSSRV <- as.factor(d2$WRKLOSSRV)
levels(d2$WRKLOSSRV) <- c("NA","NA","yes recent HH job loss","no recent HH job loss")

d2$ANYWORK <- as.factor(d2$ANYWORK)
levels(d2$ANYWORK) <- c("NA","NA","yes employment in last 7 days","no employment in last 7 days")

d2$KINDWORK <- as.factor(d2$KINDWORK)
levels(d2$KINDWORK) <- c("NA","NA","work for govt","work for private co","work for nonprofit","self employed","work in family biz")

d2$RSNNOWRKRV <- as.factor(d2$RSNNOWRKRV)
levels(d2$RSNNOWRKRV) <- c("NA","NA","did not want","am/was sick w covid or caring for sick w covid","caring for kids","caring for elderly","concerned about spreading","sick or disabled","retired","laid off","employer closed because covid","employer out of business because covid","no transport","other")

d2$CHLDCARE <- as.factor(d2$CHLDCARE)
levels(d2$CHLDCARE) <- c("NA","NA","yes impacts to childcare because pandemic","no","NA")

# d2$ACTIVITY1 <- as.factor(d2$ACTIVITY1)
# levels(d2$ACTIVITY1) <- c("NA","NA","worked onsite","no")
# d2$ACTIVITY2 <- as.factor(d2$ACTIVITY2)
# levels(d2$ACTIVITY2) <- c("NA","NA","worked remotely","no")
# d2$ACTIVITY3 <- as.factor(d2$ACTIVITY3)
# levels(d2$ACTIVITY3) <- c("NA","NA","shopped in store","no")
# d2$ACTIVITY4 <- as.factor(d2$ACTIVITY4)
# levels(d2$ACTIVITY4) <- c("NA","NA","eat at restaurant indoors","no")

d2$CURFOODSUF <- as.factor(d2$CURFOODSUF)
levels(d2$CURFOODSUF) <- c("NA","NA","had enough food","had enough but not what wanted","sometimes not enough food","often not enough food")

d2$CHILDFOOD <- as.factor(d2$CHILDFOOD)
levels(d2$CHILDFOOD) <- c("NA","NA","often kids not eating enough because couldnt afford","sometimes kids not eating enough","kids got enough food")

d2$ANXIOUS <- as.factor(d2$ANXIOUS)
levels(d2$ANXIOUS) <- c("NA","NA","no anxiety over past 2 wks","several days anxiety over past 2 wks","more than half the days anxiety over past 2 wks","nearly every day anxiety")

d2$WORRY <- as.factor(d2$WORRY)
levels(d2$WORRY) <- c("NA","NA","no worry over past 2 wks","several days worried over past 2 wks","more than half the days worried over past 2 wks","nearly every day worry")

d2$TENURE <- as.factor(d2$TENURE)
levels(d2$TENURE) <- c("NA","NA","housing owned free and clear","housing owned with mortgage","housing rented","housing occupied without rent")

d2$LIVQTRRV <- as.factor(d2$LIVQTRRV)
levels(d2$LIVQTRRV) <- c("NA","NA","live in mobile home","live in detached 1 family","live in 1 family attached to others","live in bldg w 2 apartments","live in building with 3-4 apts","live in bldg w 5+ apts","live in boat, RV, etc")

d2$RENTCUR <- as.factor(d2$RENTCUR)
levels(d2$RENTCUR) <- c("NA","NA","current on rent","behind on rent")

d2$MORTCUR <- as.factor(d2$MORTCUR)
levels(d2$MORTCUR) <- c("NA","NA","current on mortgage","behind on mortgage")

d2$EVICT <- as.factor(d2$EVICT)
levels(d2$EVICT) <- c("NA","NA","very likely evicted in next 2 months","somewhat likely evicted in next 2 months","not very likely evicted in next 2 months","not at all likely evicted in next 2 months")

d2$FORCLOSE <- as.factor(d2$FORCLOSE)
levels(d2$FORCLOSE) <- c("NA","NA","very likely forclosed in next 2 months","somewhat likely forclosed in next 2 months","not very likely forclosed in next 2 months","not at all forclosed in next 2 months")

d2$PRIVHLTH <- as.factor(d2$PRIVHLTH)
levels(d2$PRIVHLTH) <- c("has private health ins","no private health ins","NA")

d2$PUBHLTH <- as.factor(d2$PUBHLTH)
levels(d2$PUBHLTH) <- c("has public health ins","no public health ins","NA")

d2$REGION <- as.factor(d2$REGION)
levels(d2$REGION) <- c("Northeast","South","Midwest","West")

d2$INCOME <- as.factor(d2$INCOME)
levels(d2$INCOME) <- c("NA","NA","HH income less than $25k","HH income $25k - $34.9k","HH income $35k - 49.9","HH income $50k - 74.9","HH income $75 - 99.9","HH income $100k - 149","HH income $150 - 199","HH income $200k +")

d2$EST_ST <- as.factor(d2$EST_ST)
levels_n <- read.csv("state_levels.csv") # where varb names are levels_orig	New_Level
levels_orig <- levels(d2$EST_ST)
levels_new <- join(data.frame(levels_orig),data.frame(levels_n))
levels(d2$EST_ST)  <- levels_new$New_Level


d2$NUMDOSES <- as.factor(d2$NUMDOSES)
levels(d2$NUMDOSES) <- c("NA","NA","one dose of 2shot seq", "fully vaxxed")

d2$BOOSTERRV <- as.factor(d2$BOOSTERRV)
levels(d2$BOOSTERRV) <- c("NA","NA","Yes got Covid booster","No did not get booster")

d2$KIDDOSESRV <- as.factor(d2$KIDDOSESRV)
levels(d2$KIDDOSESRV) <- c("NA","NA","Yes any kid(s) got vaxx", "none got vaxx", "do not know")

d2$KIDGETVAC_LT5Y <- as.factor(d2$KIDGETVAC_LT5Y)
levels(d2$KIDGETVAC_LT5Y) <- c("NA","NA","kids under 5yo definitely get vaxx","kids under 5yo probably get vaxx","unsure kids under 5yo get vaxx","kids under 5yo probably NOT get vaxx","kids under 5yo definitely NOT get vaxx","do not know plans for vaxx for kids under 5")

d2$KIDGETVAC_5_11Y <- as.factor(d2$KIDGETVAC_5_11Y)
levels(d2$KIDGETVAC_5_11Y) <- c("NA","NA","kids 5-11yo definitely get vaxx","kids 5-11yo probably get vaxx","unsure kids 5-11 get vaxx","kids 5-11yo probably NOT get vaxx","kids 5-11yo definitely NOT get vaxx","do not know plans for vaxx for kids 5-11yo")

d2$KIDGETVAC_12_17Y <- as.factor(d2$KIDGETVAC_12_17Y)
levels(d2$KIDGETVAC_12_17Y) <- c("NA","NA","kids 12-17yo definitely get vaxx","kids 12-17yo probably get vaxx","unsure kids 12-17yo get vaxx","kids 12-17yo probably NOT get vaxx","kids 12-17yo definitely NOT get vaxx","do not know plans for vaxx for kids 12-17yo")

d2$HADCOVIDRV <- as.factor(d2$HADCOVIDRV)
levels(d2$HADCOVIDRV) <- c("NA","NA","yes tested + or doc told had Covid","no")

d2$LONGCOVID <- as.factor(d2$LONGCOVID)
levels(d2$LONGCOVID) <- c("NA","NA","had symptoms 3mo or more Long Covid","no")
# "Did you have any symptoms lasting 3 months or longer that you did not have prior to having coronavirus or COVID-19? Long term symptoms may include: tiredness or fatigue, difficulty thinking, concentrating, forgetfulness, or memory problems (sometimes referred to as "brain fog", difficulty breathing or shortness of breath, joint or muscle pain, fast-beating or pounding heart (also known as heart palpitations), chest pain, dizziness on standing, menstrual changes, changes to taste/smell, or inability to exercise."

d2$SYMPTOMS <- as.factor(d2$SYMPTOMS)
levels(d2$SYMPTOMS) <- c("NA","NA","had no covid symptoms although tested +","had mild Covid symptoms","had moderate Covid symptoms","had severe Covid symptoms")

d2$TWDAYS <- as.factor(d2$TWDAYS)
levels(d2$TWDAYS) <- c("NA","NA","had 1-2 telework days in past week","had 3-4 telework days in past week", "had 5+ telework days in past week","had no telework days in past week")

is.na(d2$TSPNDFOOD) <- which(d2$TSPNDFOOD < 0 )




summary(d2)

Household_Pulse_data <- d2

# clean up some crappy variable names
# 
Household_Pulse_data$Num_kids_Pub_School <- Household_Pulse_data$TENROLLPUB
Household_Pulse_data$Num_kids_Priv_School <- Household_Pulse_data$TENROLLPRV
Household_Pulse_data$Num_kids_homeschool <- Household_Pulse_data$TENROLLHMSCH
Household_Pulse_data$Amout_spent_on_food <- Household_Pulse_data$TSPNDFOOD

# Household_Pulse_data$Works_onsite <- Household_Pulse_data$ACTIVITY1
# Household_Pulse_data$works_remote <- Household_Pulse_data$ACTIVITY2
# Household_Pulse_data$Shop_in_store <- Household_Pulse_data$ACTIVITY3
# Household_Pulse_data$eat_in_restaurant <- Household_Pulse_data$ACTIVITY4

Household_Pulse_data <- Household_Pulse_data[ , !names(Household_Pulse_data) %in% c("TENROLLPUB","TENROLLPRV","TENROLLHMSCH","TSPNDFOOD")]

save(Household_Pulse_data, file = "Household_Pulse_data_w48.RData")

# save(Household_Pulse_data, file = "Household_Pulse_data_v2.RData",version = 2)
# some people had old version and needed this


# ======================
# later just need to run this:
# load("Household_Pulse_data_w48.RData")
