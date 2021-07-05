# Word Cloud

# Install Packages

#install.packages("tm") # for text mining
#install.packages("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")

# Load Text File
dir<-getwd()
data<- file("DataAnalyst.txt")
text<- readLines(data)
docs <- Corpus(VectorSource(text))
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "analyst")
docs <- tm_map(docs, toSpace, "analyzing")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# Convert text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove common English stopwords – multiple languages are supported!
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove punctuation
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white space
docs <- tm_map(docs, stripWhitespace)

# Build Term-Document Matrix, is a frequency table with words as columns and row names as documents
dtm <- TermDocumentMatrix(docs)
matriX <- as.matrix(dtm)
sorted <- sort(rowSums(matriX),decreasing=TRUE)
wordFreq <- data.frame(word = names(sorted),freq=sorted)
head(wordFreq, 20)

# Build Word Cloud
set.seed(20)
wordcloud(words= wordFreq$word, freq = wordFreq$freq, min.freq = 1, max.words=100, random.order = FALSE, rot.per=0.25, colors=brewer.pal(3, "Dark2"))

