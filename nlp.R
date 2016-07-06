#Has the data scientist done basic summaries of the three files? Word counts, line counts and basic data tables?
#Has the data scientist made basic plots, such as histograms to illustrate features of the data?
#Was the report written in a brief, concise style, in a way that a non-data scientist manager could appreciate?

library(knitr)
library(NLP)
library(tm)
library(stringi)
library(stringr)
library(RWeka)
library(wordcloud)

#file path
twitter.path<-"~/Desktop/Capstone/final/en_US/en_US.twitter.txt"
blogs.path<-"~/Desktop/Capstone/final/en_US/en_US.blogs.txt"
news.path<-"~/Desktop/Capstone/final/en_US/en_US.news.txt"

#load file
twitter <- readLines(twitter.path, encoding="UTF-8")
blogs <- readLines(blogs.path, encoding="UTF-8")
news  <- readLines(news.path, encoding="UTF-8")

#size count in MB
sc<-file.info(c(twitter.path,blogs.path,news.path))$size/1024/1024 
sc
#word count
wc<-rbind(
  summary(stri_count_words(twitter)),
  summary(stri_count_words(blogs)),
  summary(stri_count_words(news))
)
row.names(wc)<-c("twitter","blogs","news")

wcs<-c(
  sum(stri_count_words(twitter)),
  sum(stri_count_words(blogs)),
  sum(stri_count_words(news))
)
wc
wcs
#line count
lc<-cbind(
  stri_stats_general(twitter),
  stri_stats_general(blogs),
  stri_stats_general(news)
)
colnames(lc)<-c("twitter","blogs","news")
lc
#basic data table
bdt<-cbind(lc[1,],sc,wcs)
colnames(bdt)<-c("line count","size in MB","word count")
bdt

#20% and first 2500 line sample of corpus
##
#the all corpus is too large
#corpus.a<- Corpus(DirSource("~/Desktop/Capstone/final/en_US/"))
#corpus.a <- tm_map(corpus.a, stripWhitespace)
#corpus.a <- tm_map(corpus.a, removeNumbers)
#corpus.a <- tm_map(corpus.a, removePunctuation)
#corpus.a <- tm_map(corpus.a, removeWords, stopwords())
##

set.seed(24)
blogs.st <- blogs[sample(length(blogs), 0.2*length(blogs))]
news.st <- news[sample(length(news), 0.2*length(news))]
twitter.st <- twitter[sample(length(twitter), 0.2*length(twitter))]

corpus.s <- VCorpus(VectorSource(
  paste(
    blogs.st[1:2500], news.st[1:2500], twitter.st[1:2500]
    )
  ))

corpus.s <- tm_map(corpus.s, content_transformer(tolower)) 
corpus.s <- tm_map(corpus.s, stripWhitespace)
corpus.s <- tm_map(corpus.s, removeNumbers)
corpus.s <- tm_map(corpus.s, removePunctuation)
corpus.s <- tm_map(corpus.s, removeWords, stopwords("english"))

#word cloud plot
cor.mat <- as.matrix(DocumentTermMatrix(corpus.s))
frequency <- sort(colSums(cor.mat),decreasing = T)
wordcloud(names(frequency)[1:25], frequency[1:25])

#bar plot
barplot(frequency[1:25],
        ylab='token frequency',
        main='top 20 most frequent words in all files',
        names.arg=names(frequency)[1:25],        
        col="blue", las=2, cex.names=.7)
#n gram
corpus.d <-data.frame(text=unlist(sapply(corpus.s, 
                                         `[`, "content")), stringsAsFactors=F)

find.n.gram <- function(x, n) {
  n.gram <- NGramTokenizer(x, Weka_control(min = n, max = n))
  n.gram <- data.frame(table(n.gram))
  n.gram <- ngram[order(n.gram$Freq,decreasing = TRUE),][1:100,]
  colnames(n.gram) <- c("String","Count")
  n.gram
}

grams2 <- find.n.gram(corpus.d, 2)
grams3 <- find.n.gram(corpus.d, 3)
grams4 <- find.n.gram(corpus.d, 4)


