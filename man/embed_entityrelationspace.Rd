% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r-all-the-things.R
\name{embed_entityrelationspace}
\alias{embed_entityrelationspace}
\title{Build a Starspace model for entity relationship completion}
\usage{
embed_entityrelationspace(x, model = "graphspace.bin",
  early_stopping = 0.75, ...)
}
\arguments{
\item{x}{a data.frame with columns entity_head, entity_tail and relation indicating the relation between the head and tail entity}

\item{model}{name of the model which will be saved, passed on to \code{\link{starspace}}}

\item{early_stopping}{the percentage of the data that will be used as training data. If set to a value smaller than 1, 1-\code{early_stopping} percentage of the data which will be used as the validation set and early stopping will be executed. Defaults to 0.75.}

\item{...}{further arguments passed on to \code{\link{starspace}} except file, trainMode and fileFormat}
}
\value{
an object of class \code{textspace} as returned by \code{\link{starspace}}.
}
\description{
Build a Starspace model for entity relationship completion (graphspace).
}
\examples{
## Example on Freebase
filename <- paste(
  "https://raw.githubusercontent.com/bnosac-dev/GraphEmbeddings/master/",
  "diffbot_data/FB15k/freebase_mtr100_mte100-train.txt", 
  sep = "")
x <- read.delim(filename, header = FALSE, nrows = 1000,  
                col.names = c("entity_head", "relation", "entity_tail"),
                stringsAsFactors = FALSE)
head(x)

set.seed(123456789)
model <- embed_entityrelationspace(x, dim = 50)
plot(model)

predict(model, "/m/027rn /location/country/form_of_government")

## Also add reverse relation
x_reverse <- x
colnames(x_reverse) <- c("entity_tail", "relation", "entity_head")
x_reverse$relation <- sprintf("REVERSE_\%s", x_reverse$relation)

relations <- rbind(x, x_reverse)
set.seed(123456789)
model <- embed_entityrelationspace(relations, dim = 50)
predict(model, "/m/027rn /location/country/form_of_government")
predict(model, "/m/06cx9 REVERSE_/location/country/form_of_government")
}
