## ------------------------------------------------------------------------
library(httr)
library(magrittr)
library(rvest)
library(stringi)

html_text <- function(x, trim){
   x%>% rvest::html_text(trim) %>% stri_conv("utf8")
}


## ------------------------------------------------------------------------
res = httr::GET("http://api.ser.ideas.iii.org.tw:80/api/lbs_restaurant/restaurant_city_search?sort=score&token=api_doc_token&limit=5")

# 用content取出回傳的內容
str(content(res))

## ------------------------------------------------------------------------

res %>% content %>% str

## ------------------------------------------------------------------------
res = httr::POST(
  url = "http://api.ser.ideas.iii.org.tw:80/api/fb_checkin_search",
  body = list(
    coordinates="25.041399,121.554233",
    radius="0.1",
    token = "api_doc_token"), 
  encode = "form")

res %>% content %>% str

## ------------------------------------------------------------------------
res %>% content %>% .$result %>% lapply(unlist) %>% do.call(rbind, .) -> x
x


read_html("https://www.ptt.cc/bbs/Gossiping/index.html") %>% html_text(trim = T)

## ------------------------------------------------------------------------
session = rvest::html_session(url = "https://www.ptt.cc/bbs/Gossiping/index.html")

form = session %>%
  html_node("form") %>%
  html_form()

session_redirected = rvest::submit_form(session = session, form = form )

## ------------------------------------------------------------------------
session_redirected %>%
  html_node("body") %>%
  html_nodes(".title") %>%
  html_text(trim=T) 


session_redirected %>% cookies