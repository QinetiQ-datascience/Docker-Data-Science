library(devtools)
devtools::install_github("hadley/devtools",  branch = "dev")
devtools::install_github("igraph/igraph")
install.packages("stringi", ,type="linux.binary")
install.packages("concaveman");
devtools::install_github("r-spatial/sf")
devtools::install_github("gaborcsardi/pkgconfig")
devtools::install_github("igraph/rigraph")
devtools::install_github("hadley/readr")
devtools::install_github("jkrijthe/Rtsne")
devtools::install_github("jennybc/gapminder")
devtools::install_github("slowkow/ggrepel")
devtools::install_github("hadley/ggplot2")    # ggthemes is built against the latest ggplot2
devtools::install_github("jrnold/ggthemes")
devtools::install_github("thomasp85/ggforce")
devtools::install_github("thomasp85/ggraph")
devtools::install_github("dgrtwo/gganimate")
devtools::install_github("BillPetti/baseballr")
devtools::install_github("dahtah/imager")
devtools::install_github("elbamos/largevis", ref="develop")  # Using development branch for now, see https://github.com/elbamos/largeVis/issues/40
devtools::install_github("dgrtwo/widyr")
devtools::install_github("ellisp/forecastxgb-r-package/pkg")
devtools::install_github("rstudio/leaflet")
devtools::install_github("Laurae2/lgbdl")
# devtools::install_github("Microsoft/LightGBM", subdir = "R-package")
devtools::install_github("hrbrmstr/hrbrthemes")

install.packages("genderdata", repos = "http://packages.ropensci.org")

install.packages("openNLPmodels.en",
                 repos = "http://datacube.wu.ac.at/",
                 type = "source")

devtools::install_github("davpinto/fastknn")
devtools::install_github("mukul13/rword2vec")

#Packages for Neurohacking in R coursera course
install.packages("oro.nifti")
install.packages("oro.dicom")
devtools::install_github("muschellij2/fslr")
devtools::install_github("stnava/ITKR")
devtools::install_github("stnava/ANTsRCore")
devtools::install_github("stnava/ANTsR")
devtools::install_github("muschellij2/extrantsr")
devtools::install_github('apache/spark@v1.4.0', subdir='R/pkg')

install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R"))) # install the latest stable version of h2o
install.packages("rmarkdown")
