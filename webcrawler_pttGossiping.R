rm(list = ls()) #�M���k������ܼ� rm=remove
cat("\014")     #�M��console�������e
# # ctrl+shift+C ����
install.packages("httr")
install.packages("RCurl")
install.packages("xml2")
install.packages("rvest")

#���T�Ӻ����W��������M��Ф@�_���J
library(httr)
library(RCurl)
library(xml2)
library(rvest)

#�ڻ������]�p����k�l�Ĩ�GET() VS. POST()
#��ؤ��P����Ǿɸ�ơAGET��k�p�P�H���H����
#��²��A�N��ƪ����g�b���H�����M��H�X�A��
#POST��k�O�ݩ�������覡�A�|���Τ@�i�ȱi
#�ƥ��g�n���e�A�M���i�H�ʳU���ʦs�H�X�C
#���z�o�{�����O�ĥ�GET��k�غc���A�h"�����W"
#��ĳ�ϥ�rvest�M�󪦸�ơA�p�G�����O�ĥ�POST
#��k�غc���A��ĳ�ϥ�httr�M�󪦸�ơC
#�����O�A�����O���諸~~!


#****************************************
#�H���W���s����PTT���K������Ƭ��һ���
#****************************************

#PTT�����~�{�A���}�p�U(Try it!)
#https://www.ptt.cc/bbs/index.html


#�иյۥ��Ƿ|��^���o�K����(Gossiping)���@�ǶK��
#https://www.ptt.cc/bbs/Gossiping/index39525.html
#2020/03/07 �ثe�K�����̷s���������X39525

#�bPTT���A�@���K��"�̦h"�|��20�����D�C(�мƤ@�U?)
#��ĳ:��Ǫ̡A�]���h���]���Ҷq(What?)�A�Фųg�ߧ�Ӧh���
#���@�U�u����⭶���D�C���(�q39523��39525)�A�j��60��!

#��������}�x�s�bdata�ܼƤ�
data = NULL
for( i in 39044:39046 ) {
  url  = paste0("https://www.ptt.cc/bbs/Gossiping/index", i, ".html")
  tmp1 = content(GET(url, set_cookies(over18 = 1)))
  tmp2 = xml_find_all(tmp1, "//div[@class='title']/a")  
  tmp3 = xml_attr(tmp2, "href") #attract	
  data = c(data, tmp3) #combine
}

#�ݬ�data�ܼƬO���@�^�ơA���Y�æ����Ǹ�T?
data

#data���O�ݩ���@���ܼƫ��A�O?ANS:�O�Ӥ�r�V�q(vector)
class(data)

#�`�@���h�֪F���æbdata�ܼƤ�?
length(data)

#head()��ƥi�H�d�ݫe6�����
head(data)
tail(data)
#�]�i�H�����ݫe�Q�����
data[1:10]


# ��@�ǪŭȧR���A�ȧ�U�Ӫ��峹���e���p���n
data = Filter(function(x) x != "www.ptt.cc", data)
length(data)



myget_doc = function(url)  {
  outDir = "C:/Scu/1ptt_crawler/"      # �]�w�峹�s�ɸ��|
  url2 = paste0("https://www.ptt.cc", url)
  tmp1 = content(GET(url2, set_cookies(over18 = 1)))	
  tmp2 = xml_find_all(tmp1, "//div[@id='main-content']")  
  webtext = xml_text(tmp2)             # �C�g�峹�����e	
  name = strsplit(url, '/')[[1]][4]    # �s�ɪ��ɦW
  write(webtext, paste0(outDir, gsub('html', 'txt', name)))
  #                                   ���Nhtml�令txt 
}


#�̫�@�ӨB�J
#�ϥ�sapply��ƱN�u��K���Ƨ��outDir
#�ҫ��w�����|��C:/scu/1ptt_crawler/
sapply(data, myget_doc)   
#s�O²�ƪ����N��A�ҥHsapply��ƴN�O²�ƪ���apply���

#***********************
#����!�o�˴N����ƤF~~ *
#***********************

#���֥h�d�ݤ@�U�����|"c:/data/1ptt_crawler/"


#**************************************
#�p�m�{�G
#myget_doc()�O�@�ӨϥΪ̦ۭq���
#�\���Ѧp�U����
#**************************************

data

# [1] "/bbs/Gossiping/M.1583566240.A.C6A.html"
# [2] "/bbs/Gossiping/M.1583566265.A.F82.html"
# [3] "/bbs/Gossiping/M.1583566393.A.48B.html"
# [4] "/bbs/Gossiping/M.1583566399.A.0AB.html"
# [5] "/bbs/Gossiping/M.1583566461.A.9C4.html"
# ...


tmp1 = NULL
tmp2 = NULL
tmp3 = NULL


#�ڭ̥H�Ĥ@�Ӻ������d�ҡA�����o�Өϥγo�ۭq���
#myget_doc()���C�@�ӨB�J�O��ѩO?
#�����A���ӫ��O���{��
#sapply(data, myget_doc)
#�O��sapply()�I�smyget_doc()��ơA���O�P�ɭn��
#��data���e�@�Ӥ@�Ӻ��}�e�L�hmyget_doc()���
#��data�ܼƤ��x�s�����e����쪺���}�A�]���e�@��
#data�ܼƤ������}��myget_doc()��ơA

url = "/bbs/Gossiping/M.1583566240.A.C6A.html"
url
# [1] "/bbs/Gossiping/M.1583566240.A.C6A.html"

#�W�z������O�]�i�H�o��g��K����P��ݵ��G
(url = "/bbs/Gossiping/M.1583566240.A.C6A.html")
# [1] "/bbs/Gossiping/M.1583566240.A.C6A.html"

# �H�K��������}
(url2 = paste0("https://www.ptt.cc", url))
# [1] "https://www.ptt.cc/bbs/Gossiping/M.1583566240.A.C6A.html"



#GET()���
(tmp1 = content(GET(url2, set_cookies(over18 = 1))))
#tmp1��쪺���e�A�o�S�O����?�Q�Q��?

# {html_document}
# <html>
# [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charse ...
# [2] <body>\n\t\t\n<div id="topbar-container">\n\t<div id="topbar" clas ...

#ANS:�򥻤W�O�N�������ҵ��c�P�����W��r���"�@�Ѹ���"
#    ����^�ӡA�i�H�z�L�˵�������l�X��Ӭݤ@�U!


#xml_find_all()��ơG�i�H���ŦX�u�W�h�v���Ҧ�html��l�X�C
#���B�һ����u�W�h�v�O��Xpath�ҩw�q�����e(��Ǫ̤����PŪ~~)
(tmp2 = xml_find_all(tmp1, "//div[@id='main-content']"))

# {xml_nodeset (1)}
# [1] <div id="main-content" class="bbs-screen bbs-content">\n<div class="articl ...


#xml_text()�G�i�H�qhtml��l�X���A�Ѩ��u���e�v����T�C
(webtext = xml_text(tmp2))
# [1] "�@��hsiao15165 (notdragon)�ݪOGossiping���D[�ݨ�] �p�y�۬O���O�]�Q���e�������F...

#�����ǲߺ����p�U
#https://rpubs.com/skydome20/R-Note13-Web-Crawler-on-CIA-CREST-by-xml2



url
# [1] "/bbs/Gossiping/M.1583566240.A.C6A.html"


#strsplit()��ƪ����G�A�@�w�|�x�s�b
#List��ƫ��A�ܼƤ��A�B�|�ھ�"/"�o�@
#�ӰѼƲŸ��A�}�l�i��r����ΡA�Ա��p�U
strsplit(url, '/')
# [[1]]
# [1] ""                       
# [2] "bbs"                    
# [3] "Gossiping"              
# [4] "M.1583566240.A.C6A.html"

strsplit(url, '/')[[1]]
# [1] ""                       
# [2] "bbs"                    
# [3] "Gossiping"              
# [4] "M.1583566240.A.C6A.html"

strsplit(url, '/')[[1]][1]
# [1] ""

strsplit(url, '/')[[1]][2]
# [1] "bbs"

strsplit(url, '/')[[1]][3]
# [1] "Gossiping"

strsplit(url, '/')[[1]][4]
# [1] "M.1583566240.A.C6A.html"

name = strsplit(url, '/')[[1]][4]
name
# [1] "M.1583566240.A.C6A.html"

#gsub()�O�@�ӫܱ`�Ϊ���ơA�\�ର"���N"
gsub('html', 'txt', name)
# [1] "M.1583566240.A.C6A.txt"

#�X�ְ���H�W�ɦW���λP���N���ʧ@
outDir = "c:/data/1ptt_crawler/"
outDir
# [1] "c:/data/1ptt_crawler/"

paste0(outDir, gsub('html', 'txt', name))
# [1] "c:/data/1ptt_crawler/M.1582817452.A.2E9.txt"

#�ݤ@�U����U�Ӫ��䤤�@�g�峹���eM.1583566240.A.C6A.html
webtext
# [1] "�@��EVGA (��P)�ݪOGossiping���D[�s�D] �饻�s�����X�{...

#�Q��write()��ƱN���webtext�峹���e�g��w�����|���ç����ɦW��.txt
write(webtext, paste0(outDir, gsub('html', 'txt', name)))
#�w�g�Nptt��M.1583566240.A.C6A.html���e�g�i�h��
#c:/data/1ptt_crawler/�ؿ��U��M.1583566240.A.C6A.txt
#�ɮפ��F�A�d�d��!


#�r����Ψ��strsplit()
#�ѦҺ���
#https://www.cnblogs.com/awishfullyway/p/6601539.html


# �j�H��...�H�@�ध�A�v�ʤ��F�H�Q�ध�A�v�d���I...
# �@�~�m��
# 1.��Gossiping�K�����K��100��
# 2.��ptt����L���K��100��



#*********************************
#Xpath���I����
#XPath�A����XML Path Language�A
#�YXML ���|�y���A���O�@���bXML
#���ɤ��d��H�����y���CXPath ��
#��]�p�O�Ψӷj�MXML���ɪ��A��
#�O���P�˾A�Ω�HTML ���ɪ��j���C
#�ҥH�b�����ήɡA�ڭ̧����i�H��
#��XPath �Ӱ���������T����C
#*********************************

# �аO          �N�q
#========================================
#  //    ���ޭ��@�h���n��
#  []    �i�H�ﲳ�hdiv���y�z
#  @     �N�Oattribute�V�f�y��"��"���N��
#  /     ���h�ؼЪ����U�@�h

# �ϥΪ��M��Oxml2�A�D�n�|�Ψ�U���o�Ǩ禡�G
# read_html()�G�N���}�ҹ�����html�����A�x�s���@�Ӫ���C
# xml_find_all()�G���ŦX�u�W�h�v���Ҧ�html��l�X�C
# xml_text()�G�qhtml��l�X���A�Ѩ��u���e�v����T�C
# xml_attr()�G�qhtml��l�X���A�Ѩ��u�ݩʡv����T�C


url  = paste0("https://www.ptt.cc/bbs/Gossiping/index", 39523, ".html")
url
# [1] "https://www.ptt.cc/bbs/Gossiping/index39523.html"

GET(url)  #�������I�᪺���c���

# Response [https://www.ptt.cc/ask/over18?from=%2Fbbs%2FGossiping%2Findex39523.html]
# Date: 2020-03-07 16:55
# Status: 200
# Content-Type: text/html; charset=utf-8
# Size: 2.42 kB
# <!DOCTYPE html>
#   <html>
#   <head>
#   <meta charset="utf-8">
#   
#   
#   <meta name="viewport" content="width=device-width, initial-scale=1">
#   
#   <title>�����~�{</title>
#   
#   ...

#�ЦP�ɬݤ@�UPTT����"�˵�������l�X"�A��Ӭݤ@�U�A�N�O"��"�F!


#���U�Өϥ�content()��ơA�åB�I�靈�W��������tmp1���e
#�N���Dcontent()����x�s�bList�������e
content(GET(url))
# {html_document}
# <html>
# [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF ...
# [2] <body>\n\t\t\n<div class="bbs-screen bbs-content">\n    <div class="ove ...

#�x�s�btmp1��
tmp1 = content(GET(url, set_cookies(over18 = 1)))


#½Ķ�@�U
#�Цbtmp1����
#//�N�O�C�@�h���n��L��
#//div�N�Odiv���ަb���@�h���n��L��
#//div[@class='title']�b�ݩ�class���ȵ���title��
#//div[@class='title']/a�b�ݩ�class���ȵ���title�B�U�@�h���ݩʬOa��


#���U�Өϥ�xml_find_all()��ơA�åB�I�靈�W��������tmp2���e
#�N���Dxml_find_all()����x�s�bList�������e
xml_find_all(tmp1, "//div[@class='title']/a")
# {xml_nodeset (19)}
# [1] <a href="/bbs/Gossiping/M.1583566240.A.C6A.html">[�s�D] �饻�s�����X�{����Z�~�ͪ��P�V�� ...
# [2] <a href="/bbs/Gossiping/M.1583566265.A.F82.html">[�ݨ�] ����עղ{�b�@��s�i?</a>
# [3] <a href="/bbs/Gossiping/M.1583566393.A.48B.html">[�ݨ�] �{�b484�ܾA�X�h���[��</a>
# [4] <a href="/bbs/Gossiping/M.1583566399.A.0AB.html">Re: [�ݨ�] �ڬ��H�~��̤����F�ȤH ...


#�x�s�btmp2��
tmp2 = xml_find_all(tmp1, "//div[@class='title']/a")

#�ϥ�xml_attr()��ƥh�Ѩ�tmp2���@�ǡu�ݩʡv����T
#�b���O���ݩʬ�href����
xml_attr(tmp2, "href")
# [1] "/bbs/Gossiping/M.1583566240.A.C6A.html"
# [2] "/bbs/Gossiping/M.1583566265.A.F82.html"
# [3] "/bbs/Gossiping/M.1583566393.A.48B.html"
# [4] "/bbs/Gossiping/M.1583566399.A.0AB.html"
# [5] "/bbs/Gossiping/M.1583566461.A.9C4.html"
# ...

#�x�s�btmp3��
tmp3 = xml_attr(tmp2, "href")

#�յ۷Q�ݬݦp�G�令xml_text(tmp2, "href")�|�ܦ����?
#�q��F!�N�O���ǼЦC�����u�u����r���e
# [1] "[�s�D] �饻�s�����X�{����Z�~�ͪ��P�V��"         
# [2] "[�ݨ�] ����עղ{�b�@��s�i?"                    
# [3] "[�ݨ�] �{�b484�ܾA�X�h���[��"                    
# [4] "Re: [�ݨ�] �ڬ��H�~��̤����F�ȤH��?"          
# [5] "[�ݨ�] �I�E�h��J�檺�O��E�h��]�Y�U�h��?"      
# ...

#�z�q��F��?


#�@�B�@�B�ѻ�Xpath�����C

#�U��q�o�@R�y���g���򥻪��Τ��Ǩ�F����?�����ݡC


#**************************************************************
#²�檦�ήרҤG�G�R�A���������νm��
#����x�W�Ȧ�C�Ѫ��ײv���
#��k�i�H���ѦҤU�C��������
#https://hy-chou.blogspot.com/2018/01/rxpathweb-crawler.html
#
#
#�x�W�Ȧ�P�i�ײv�d�ߺ���(����o���[���[��������c)
#https://rate.bot.com.tw/xrt?Lang=zh-TW
#*************************************************************

rm(list = ls()) #�M���k������ܼ�
cat('\014')     #�M��console�������e

# install.packages("httr")
# install.packages("RCurl")
# install.packages("xml2")
# install.packages("rvest")

#���T�Ӻ����W��������M��Ф@�_���J
library(httr)
library(RCurl)
library(xml2)
library(rvest)

#�u�n�y�L��gPTT���δN�i�H�F

tmp1  = NULL
tmp2  = NULL
tmp21 = tmp22 = tmp23 = tmp24 = tmp25 = NULL
tmp3  = NULL
tmp31 = tmp32 = tmp33 = tmp34 = tmp35 = NULL


#�����A�Q���o�ײv��ƪ����}
url_bktw  = "https://rate.bot.com.tw/xrt?Lang=zh-TW"

#���۳z�Lcontent()�PGET()���X���o��Ӷײv��ƪ��������c
tmp1 = content(GET(url_bktw))

#�M��ݬݭn����ƪ���mF12�\����ΰ�������ˬd�\��
#���z�n��������Ʀ�m�A�M��Copy XPath
#�ݤ@�U"�z�n��������m��XPath"���y�k!

#Ĵ�p�ײv��������������R�J29.6��
#�P���̷s���P�ɶ��G2020/03/09 AM 10:00
#���o29.6�����XPath���y�k�O
#/html/body/div[1]/main/div[4]/table/tbody/tr[2]/td[2]


#�i�H�ϥ�XPath Helper�p�u�㭫�s½Ķ�O�_���z�n�������W���29.6
#�ոլ�~~
#�p��?ANS:...


#��Ӿ�z�@�U���ޭ��@�Ӱ�a������R�J��XPath���y�k�O
#/html/body/div/main/div/table/tbody/tr/td[2]/text()
#�@�˹D�z�ϥ�XPath Helper���ҬO�_�������W����R�J���Ҧ����
#�ոլ�~~
#�p��?ANS:...

#���ۭn�ݦp��N���O�B����R�J�B�����X�B����R�J�B�����X
#������쪺19����ƥ�����U�ӡA���x�s�b��Ʈ�(data.frame)��
#�x�}(matrix)��

tmp21 = xml_find_all(tmp1, "/html/body/div[1]/main/div[4]/table/tbody/tr/td[1]/div/div[3]/text()")
#tmp21 = xml_find_all(tmp1, "//div/table/tbody/tr/td/div/div[3]/text()")

tmp22 = xml_find_all(tmp1, "/html/body/div/main/div/table/tbody/tr/td[2]/text()")
tmp23 = xml_find_all(tmp1, "/html/body/div/main/div/table/tbody/tr/td[3]/text()") 
tmp24 = xml_find_all(tmp1, "/html/body/div/main/div/table/tbody/tr/td[4]/text()") 
tmp25 = xml_find_all(tmp1, "/html/body/div/main/div/table/tbody/tr/td[5]/text()") 


tmp31 = xml_text(tmp21)
tmp31 = gsub("\r\n", "", tmp31)
tmp31 = gsub(" ", "", tmp31)

tmp32 = xml_text(tmp22)
tmp33 = xml_text(tmp23)
tmp34 = xml_text(tmp24)
tmp35 = xml_text(tmp25)
#tmp3 = xml_text(tmp2)

#tmp3 = xml_attr(tmp2, "href")	

#�̫ᦨ�G�N�U�����X��
#�i�H����ذ��k�G�x�}(Matrix)�P��Ʈ�(data.frame)
#�����޳N�i�H�ѦҺ��}
#https://joe11051105.gitbooks.io/r_basic/content/variable_and_data/matrix.html
#��
#https://blog.gtwang.org/r/r-lists-and-data-frames/4/


#�X�֦��x�}
bkrate_M1 = cbind(tmp31,tmp32,tmp33,tmp34,tmp35)

bkrate_M2 = cbind(tmp32,tmp33,tmp34,tmp35)
colnames(bkrate_M2) = c("�{��.����R�J","�{��.�����X","�Y��.����R�J","�Y��.�����X")
rownames(bkrate_M2) = tmp31

#�X�֦���Ʈ�
bkrate_df1 = data.frame(
  ���O = tmp31,
  �{��.����R�J = tmp32,
  �{��.�����X = tmp33,
  �Y��.����R�J = tmp34,
  �Y��.�����X = tmp35
)


bkrate_df2 = data.frame(
  �{��.����R�J = tmp32,
  �{��.�����X = tmp33,
  �Y��.����R�J = tmp34,
  �Y��.�����X = tmp35,
  row.names = tmp31
)


#*********************************************************  
#�i���m��
#
#1.�мҥ��PTT�K��覡�m�ߧ�ثe�ꤺ�U�j�q�l���s�D���
#  �]�t�p�X�B���ɡBī�G�B�F�ˡBGoogle�s�D�B�ۥѵ��q�l��
#  ���Y���s�D�εJ�I�s�D�C
#
#2.�Ц��ŧ�@�U�ꤺ���n�H�O����(104 or 1111 or Yes123)
#  ���ھڬY��¾�ʱ���U��¾�ʸ�Ʃһݭn������C
#
#3.�ЧQ�Χ���|�j�q�l�����Y���εJ�I�s�D�A�׻E���@���C��
#  �ֱ��M�����i(pdf or word or html format)�A���i�W���
#  �֦�(I)�ɶ��B(II)���D�B(III)�K�n�H��(IV)�W�s�����|��
#  �A�ڦ��C�Ѵ��ѵ��D�ޥثe�ֱ��ҽͽת��Ʊ����J�I~~
#
#4.(�����D��)�ФW�q�k�|�����h����j�k�x�������ơA�`�@
#  ��789�������A�иյۧ�ݬݡA�N�ӥi�H�i�@�B�@�����R�j
#  �k�x�������I����r�D�D���I�C
#  http://cons.judicial.gov.tw/jcc/modify/wall.html
#  
#  
#  Fighting~
#
#*********************************************************
