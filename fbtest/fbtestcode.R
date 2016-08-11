#install.packages("devtools")
#install_github("Rfacebook", "pablobarbera", subdir="Rfacebook")
#install.packages("devtools")
#devtools::install_github("hadley/httr")
library(rjson)
library(httpuv)
library(devtools)
library(httr)
library(Rfacebook)

#fb.oauth <- fbOAuth(app_id="", app_secret="")
#save(fb.oauth, file="fb_oauth")
#load("fb_oauth")

fb.oauth = "你的token"
me = getUsers("me", fb.oauth)

my_friends<-getFriends(fb.oauth, simplify = TRUE)
head(my_friends ,n=100)

my_likes<- getLikes(user = "me", n = 10, token=fb.oauth)
print(my_likes)

#朋友圈找尋NETWORK但我用不了
mat <- getNetwork(fb.oauth, format="adj.matrix")
library(igraph)
network <- graph.adjacency(mat, mode="undirected")
pdf("network_plot.pdf")
plot(network)
dev.off()


load("fb.oauth")
fb <- getUsers("me", token=fb.oauth ,private_info = TRUE)
fb$username

#PO文找尋找不到
posts <- searchFacebook( string="facebook", token=fb.oauth, n=100 )
posts <- searchFacebook( string="facebook", token=fb.oauth, n=100,
                         since = "yesterday 00:00", until = "yesterday 23:59" )
#公開社團內容
load("fb.oauth")
ids <- searchGroup(name="NCUE彰師大", token=fb.oauth)
ids[1,] # id = 194448144020298
group <- getGroup(group_id=101190690086697, token=fb.oauth)
group <- getGroup(group_id=101190690086697, token=fb.oauth,
                  since='2014/09/10', until='2016/06/30')
#關鍵字找尋
load("fb.oauth")
pages <- searchPages( string="movie", token=fb.oauth, n=100 )
pagesoscar<-searchPages( string="oscar", token=fb.oauth, n=50 )
pagesAcademyAwards<-searchPages( string="Academy Awards", token=fb.oauth, n=50 )


#幫自己的fb發文
load("fb.oauth")
updateStatus("你好~", token=fb.oauth)
