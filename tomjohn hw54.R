install.packages('quanteda')
install.packages('quanteda.textmodels')
install.packages('quanteda.textstats')
install.packages('quanteda.textplots')

library(quanteda)
library(quanteda.textmodels)
library(quanteda.textstats)
library(quanteda.textplots)

text <- read.csv('gastext.csv',stringsAsFactors = F)
MyCorpus <- corpus(text$Comment)
summary(MyCorpus)

MyTokens <- tokens(MyCorpus)

bigram <- tokens_ngrams(MyTokens,n=1:2)
mydfm <- dfm(bigram)
topfeatures(mydfm)
head(mydfm)

Edfm <- dfm(tokens(MyCorpus,
                   remove_punct = T))
topfeatures(Edfm)
Edfm@Dimnames

install.packages('stopwords')
library(stopwords)

Edfm <- dfm_remove(Edfm,stopwords('english'))

Edfm@Dimnames

dim(Edfm)
Edfmtfidf <-dfm_tfidf(Edfm)


head(Edfmtfidf)

Edfm

MySvd <- textmodel_lsa(Edfmtfidf)


MySvd$docs[]

install.packages('topicmodels')
install.packages('tidytext')

library(topicmodels)
library(tidytext)

myLDA <- LDA(Edfm, k=4,control=list(seed=101))

myLDA

myLDATD <- tidy(myLDA)

myLDATD

library(ggplot2)
library(dplyr)

topterms <- myLDATD %>%
  group_by(topic) %>%
  top_n(8,beta) %>%
  ungroup() %>%
  arrange(topic,beta)
topterms %>%
  mutate(term=reorder(term,beta)) %>%
  ggplot(aes(term,beta,fill = factor(topic)))+
  geom_bar(stat= 'identity', show.legend = FALSE)+
  facet_wrap(~topic,scales='free')+
  coord_flip()

opdocs <- tidy(myLDA,matrix='gamma')

textsim <- textstat_simil(Edfm,
                          selection = 'text1',
                          margin ='documents',
                          method= 'correlation')
head(as.matrix(textsim),6)

docdist <- textstat_dist(Edfm)

clust <- hclust(as.dist(docdist))
plot(clust,xlab='Distance',ylab = NULL)


textsim

termsim <- textstat_simil(Edfm,
                          selection ='price',
                          margin='feature',
                          method= 'correlation')
head(as.matrix(termsim),10)

teamsim <- textstat_simil(Edfm,
                          selection ='service',
                          margin='feature',
                          method= 'correlation')

head(as.matrix(teamsim),10)

tstatFreq <- textstat_frequency(Edfm)

head(tstatFreq,20)
textplot_wordcloud(Edfm,max_words = 500)

Edfm <- dfm_remove(Edfm,stopwords('english'))

Edfm <- dfm_wordstem(Edfm)

dim(Edfm)
topfeatures(Edfm,30)

stopwords1 <- c('shower','point','productx','service','use','price')

Edfm <- dfm_remove(Edfm,stopwords1)

dim(Edfm)

Edfm <- dfm_trim(Edfm,min_termfreq = 4, min_docfreq = 2)
dim(Edfm)

textplot_wordcloud(Edfm,max_words = 500)
topfeatures(Edfm,10)

stopword2 <-c('servic','get','park','card','clean','�','t','don','food','drink')

Edfm <-dfm_remove(Edfm,stopword2)
dim(Edfm)


topterms <- Edfm %>%
  group_by(topic) %>%
  top_n(8,beta) %>%
  ungroup() %>%
  arrange(topic,beta)
topterms %>%
  mutate(term=reorder(term,beta)) %>%
  ggplot(aes(term,beta,fill = factor(topic)))+
  geom_bar(stat= 'identity', show.legend = FALSE)+
  facet_wrap(~topic,scales='free')+
  coord_flip()

library(rpart)
library(rpart.plot)

data1 <- text
data1$Comment <- NULL

data1$Score <- factor(data1$Score)
tree1 <- rpart(Score ~ ., data=train1, method="class")t
set.seed(123)
idx <- sample(1:nrow(data1), 0.7*nrow(data1))
train1 <- data1[idx,]
valid1 <- data1[-idx,]

tree1 <- rpart(Rating ~ ., data=train1, method="class")

rpart.plot(tree1)

