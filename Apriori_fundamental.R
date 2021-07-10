#�p�G�O�ϥ�RStudio�n��ϥΪ̥i�H����
#�U�C�����O�ֳt�F�������M�Ū��u�@
rm(list = ls()) #�M��RStudio�n��k�����ҵ����ܼƤ��e
cat("\014")     #�M��RStudio�n��U��Console Window�������e

#�d�Ҥ@
# table 14.1, Transactional data, �ӷ~���z�P�j�ƾڤ��R(�ɮ��ѧ�) Page.457
# Items�ӫ~���� : ���{�B���ߡB�����B��s�B�����B���(�����ؤ��P�ӫ~����)
# dataset��ƶ��X: total data = 5(������������)
# �̤p�����(minimun support, minsup) = 60%
# �̤p�H���(minimun confidence, minconf) = 60%
#|------------------|------------------------|
#| Transaction ID   |     Items              |
#|------------------|------------------------|
#|       T1         | {���{,����,����}       |
#|       T2         | {���{,����,��s,����}  |
#|       T3         | {����,����,��s,���}  |
#|       T4         | {���{,����,����,��s}  |
#|       T5         | {���{,����,����,���}  |
#|------------------|------------------------|


#*****************
#�B�J�@(Step 1.) *
#*****************
#�w��(install)�P���J(load)"arules" �M��
#install.packages("arules") #�p�G�z�q���w�g�w�˹L������O�i�H���ΦA����
library(arules)            #���Jarules�M��



#*****************
#�B�J�G(Step 2.) *
#*****************
#�ǳƸ��prepare data

#�z�Llist()��ƬO�NT1,T2,...,T5��������e�걵�إߦ�
#��list��ƫ��A���ܼƨåHxlist�R�W���ܼ�

#c()��ƴN�Ocombine���N��A�i�H�N�e���Ʀ걵�_�Ӧ�
#���V�qvector��ƫ��A

#�ҥH�̫�xlist�������Ӥ�r�V�q�A�y�k�p�U�G

xlist = list(
  c("���{","����","����"),
  c("���{","����","��s","����"),
  c("����","����","��s","���"),
  c("���{","����","����","��s"),
  c("���{","����","����","���")
)
#���W�����O�]�i�H�g���@��A�i�H���Φh�漶�g�覡
#�A���O�@����O�Ӫ��|������e���\Ū
#xlist_test = list(c("���{","����","����"),c("���{","����","��s","����"),c("����","����","��s","���"),c("���{","����","����","��s"),c("���{","����","����","���"))



#�i�H�d�ݤ@�U�ثexlist�ܼƸ�ƫ��A
class(xlist)
#�i�H�d�ݤ@�U�ثexlist�ܼƸ�Ƥ��e�Alist���A�bR���ϥΨ�h���A��
xlist
xlist[[1]]     #"���{","����","����"
xlist[[2]]     #"���{","����","��s","����"
xlist[[3]]     #"����","����","��s","���"
xlist[[4]]     #"���{","����","����","��s"
xlist[[5]]     #"���{","����","����","���"
xlist[[1]][1]  #"���{"
xlist[[1]][2]  #"����"
xlist[[1]][3]  #"����"
xlist[[1]][4]  #NA���ܨS��ơA�W�X�d��ҥH�S���


#���O�S������s���A�ҥH��names��Ƴ]�w�Aset transaction names
#paste()�i�H�s�e��Ʀr�Τ�r�r��
#c(1:5)�N�O�إߤ@�ӼƦr�V�q���e��1,2,3,4,5
#sep�ѼƴN�O�]�w�e("T")��(c(1:5))��Ƥ����߶K�ɭԬO�Τ���j�����覡
names(xlist) = paste("T",c(1:5), sep = "") 
xlist

#force data into transactions
#�]���bR�����p�W�h�ϥΪ�apriori()��ƪ���Ʈ榡��"transactions"�A
#�]���ĥ�as()��Ʊj���Nlist��ƫ��A��xlist�ܼ��ର"transactions"
#��Ʈ榡#�x�s�b�t�@�ܼ�table14_1��

table14_1 = as(xlist, "transactions") #transactions�����޸��@�w�n�[ 


#�d�ݥثetable14_1�����e
table14_1   #�u�|�ݨ�K�n��T�A�Ҧp�X����ơA�X�����

#�ϥ�inspect()��ƥi�H�ݨ�u���ԲӸ��
inspect(table14_1)
#"transactions"��Ʈ榡���Aitem���X�{�AtransactionID��X�{�A����A���\


#�ϥ�str()��ƶ��K�d��table14_1�ܼƥثe�ܼƵ��c
str(table14_1)



#*****************
#�B�J�T(Step 3.) *
#*****************
# �}�l�i���Ƥ��R(analyze data)
# ���ϥΤ@�ǵ�ı�Ƥu��ݸ�ƽ���generate level plots to visually inspect binary incidence matrices

image(table14_1)    
#�z�L��ƱK�׹Ϭd�ݸ�ƱK�סA�ݤ@�U�ۤv�o�Ϧ��ܵ}���O?�٬O�ܺ�K�O?

summary(table14_1)  
#�@��έp��ơA�O�o��density value�O�h��?
#ANS:0.6333333  �P�Ϥ@�P��?(�i�H������@�U)



#*****************
#�B�J�|(Step 4.) *
#*****************
# �i�M���apriori�z�פ�k���Ҵ��쪺1-itemset(C1)
itemFrequency(table14_1, type = "relative") #�H�����(support)�e�{
itemFrequency(table14_1, type = "absolute") #�H����ƶq(support count)�e�{


#�o�@�q�i�H�x�s�o��1-itemset������שΪ̤���ƶq���
#itemFreq = itemFrequency(table14_1)
#�C�Ӷ���transaction�]�titem���Ӽ�
#Size = size(table14_1)
#�C��item�X�{������
#itemCount = (itemFreq/sum(itemFreq)*sum(Size))



#*****************
#�B�J��(Step 5.) *
#*****************
# �H������(bar plot)ø�sitemFrequency���
itemFrequencyPlot(table14_1, col = "lightgreen")         #���C��
itemFrequencyPlot(table14_1, support = 0.4, col = "red") #�[support����
itemFrequencyPlot(table14_1, topN = 4, col = "lightblue")#�[topN����



#*****************
#�B�J��(Step 6.) *
#*****************
# �}�l�i���X���p�W�h
# Mining Association Rules�A
#�Hmin_supp = 0.6, min_conf = 0.6������p���X�W�h(target = "rules")
#�W�h�����e���P�ᶵ���ܤֳ��@�ӫ~��(������O�Ŷ��X{})�A
#�Y�W�h���׬�2(minlen=2)�H�W���~�d�U
rules_1 = apriori(table14_1, parameter = list(support = 0.6, 
                                              confidence = 0.6,
                                              minlen=2, 
                                              target = "rules"))
#ANS:writing ... [11 rule(s)] done [0.00s].  ���11���W�h
#�ϥ�inspect()��Ƭd�ݤ@�U���������p�W�h����
inspect(rules_1)

#�p�G���W�z���Ҧ��ѼƳ��S�g�AR�N�ĥΤ��w���w�]�ȡA
#�դ@�U!���ݦ����ǻ{�Ѫ��w�]��~~
rules_2 = apriori(table14_1)  
#ANS:writing ... [36 rule(s)] done [0.00s].  ���36���W�h
#�ϥ�inspect()��Ƭd�ݤ@�U���������p�W�h����
inspect(rules_2)



#****************
#�B�J�C(Step7.) *
#****************
# ��ܩҲ��ͪ����p�W�h���ҫ����G�A�ݳW�h�ԲӤ��e�ϥ�inspect()���

inspect(table14_1) # display transactions  again

inspect(rules_1)   # display association rules in rules_1
#�U��i�H�վ�Ѽƭ��s����rules_1�A
#lift�Ȭ����ɫסAcount�Ȭ�����ƶq
#�@���վ�ץ���j�ƾڤ��R�v�P�M����BOSS��X���쪺�j�W�h����


inspect(rules_2)   # display association rules in rules_2
#�q�`��ȤW����ĳ�]�S����ѼƱ���apriori��k


#Ending �������p�W�hapriori�t��kR��@


#Practice
#�m���D1
# �̤p�����(minimun support, minsup)=50%
# �̤p�H���(minimun confidence, minconf)=50%
#|------------------|-------------|
#| Transaction ID   |     Items   |
#|------------------|-------------|
#|       T100       | {1,3,4}     |
#|       T200       | {2,3,5}     |
#|       T300       | {1,2,3,5}   |
#|       T400       | {2,5}       |
#|------------------|-------------|


#�m���D2
# �̤p�����(minimun support, minsup)=30%
# �̤p�H���(minimun confidence, minconf)=70%
#|------------------|-------------|
#| Transaction ID   |     Items   |
#|------------------|-------------|
#|       1          | {2,5,7}     |
#|       2          | {1,3,4,6}   |
#|       3          | {2,6,7}     |
#|       4          | {2,4,5}     |
#|       5          | {3,6}       |
#|       6          | {2,4,6}     |
#|       7          | {1,4,5}     |
#|       8          | {1,3,5}     |
#|       9          | {2,3,5}     |
#|      10          | {1,3,5}     |
#|------------------|-------------|


#�m���D3
# �̤p����ƶq(minimun support count, minsup_count)=2
# �̤p�H���(minimun confidence, minconf)=70%
#|------------------|---------------|
#| Transaction ID   |     Items     |
#|------------------|---------------|
#|       T100       | {I1,I2,I5}    |
#|       T200       | {I2,I4}       |
#|       T300       | {I2,I3}       |
#|       T400       | {I1,I2,I4}    |
#|       T500       | {I1,I3}       |
#|       T600       | {I2,I3}       |
#|       T700       | {I1,I3}       |
#|       T800       | {I1,I2,I3,I5} |
#|       T900       | {I1,I2,I3}    |
#|------------------|---------------|


#�m���D4
# �̤p����ƶq(minimun support count, minsup_count)=3
# �̤p�H���(minimun confidence, minconf)=50%
#|------------------|-------------------------------|
#| Transaction ID   |         Items                 |
#|------------------|-------------------------------|
#|       1          | {Bread, Milk}                 |
#|       2          | {Bread, Diaper, Beer,   Eggs} |
#|       3          | {Milk,  Diaper, Beer,   Coke} |
#|       4          | {Bread, Mile,   Diaper, Beer} |
#|       5          | {Bread, Mile,   Diaper, Coke} |
#|------------------|-------------------------------|



#�m���D5
# �̤p����ƶq(minimun support count, minsup_count)=3
# �̤p�H���(minimun confidence, minconf)=50%
#|------------------|-------------------|
#| Transaction ID   |       Items       |
#|------------------|-------------------|
#|       1          | {f,a,c,d,g,i,m,p} |
#|       2          | {a,b,c,f,l,m,o}   |
#|       3          | {b,f,h,j,o}       |
#|       4          | {b,c,k,s,p}       |
#|       5          | {a,f,c,e,l,p,m,n} |
#|------------------|-------------------|




