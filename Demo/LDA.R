wdbc <- read.csv("Demo//wdbc_csv.csv" )

features <- c("radius", "texture", "perimeter", "area", "smoothness", "compactness", "concavity", "concave_points", "symmetry", "fractal_dimension")
names(wdbc) <- c( "diagnosis", paste0(features,"_mean"), paste0(features,"_se"), paste0(features,"_worst"))

wdbc$id = seq(1,length(wdbc$diagnosis))

wdbc.data <- as.matrix(wdbc[,c(3:32)])

row.names(wdbc.data) <- wdbc$id
wdbc_row = cbind(wdbc.data, as.numeric(wdbc$diagnosis-1))

smp_size_row <- floor(0.75 * nrow(wdbc_row))

iris_lda= lda(formula = Species ~ . , data = iris , priar = c( 1,1,1)/3)

iris_lda
