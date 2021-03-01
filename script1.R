#Tuto Lien : https://www.youtube.com/playlist?list=PL9ooVrP1hQOFZ1W2m8zYMxUiQhHywHxYm.
library(tm)
library(wordcloud)
library(wordcloud2)
library("tidytext")
library("proustr")
library("tidyverse")
library(textclean)
#devtools::install_github("ThinkRstat/stopwords")
library("stopwords")
#cration du corpus
docs <- Corpus(DirSource('/Users/kamel/Documents/Doctorat-Thesis/Text_mining'))
inspect(docs)
#docs <- Corpus(VectorSource(docs)) transformer un vercteur en corpus
#remove ; or . or -
toSpace <- content_transformer(function(x, pattern){return(gsub(pattern,  " ",x))})
docs <- tm_map(docs, toSpace, ".")
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, removePunctuation)
docs = gsub('Ã', 'é', docs) #remove punctuation
#transform all in lower case
docs <- tm_map(docs, content_transformer(tolower))
#remove numbers
docs <- tm_map(docs, removeNumbers)
#remove stop words "fr for french" & "en for english"
docs <- tm_map(docs, removeWords, stopwords("fr"))
#strip whitespace
docs <- tm_map(docs, stripWhitespace)
#inspect output but transform on char
writeLines(as.character(docs))
#transform the text on matrix where the lines are the documents and the colomns are the words used
dtm <- DocumentTermMatrix(docs)
#freaquency of words
freq <- colSums(as.matrix(dtm))
#length should be a total number of terms
length(freq)
#create sort of order (asc)
ord <- order(freq, decreasing = TRUE)
#inspect most frequently occuring terms
freq[head(ord)]
wf=data.frame(term=names(freq), occurrences=freq)
#draw an histogram
library(ggplot2)
p <- ggplot(subset(wf, freq>200), aes(term, occurrences))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p
#dessiner un nuage de môts
colorlist = c("red","blue","green","Orange","violet" )
wordcloud(docs, min.freq = 10, colors = colorlist, max.words=150)
wordcloud(docs, min.freq = 10, colors = RColorBrewer::brewer.pal(6,"Spectral"),max.words=150)

#
#docs_no <- docs
#docs_no <- gsub("\\s*'\\B|\\B'\\s*", "", docs_no)
#docs_no <- gsub(" ' ", "", docs_no)
#strip(docs)
#strip(docs, apostrophe.remove=TRUE)
