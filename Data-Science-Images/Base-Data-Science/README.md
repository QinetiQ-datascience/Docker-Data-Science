Base Data Science Docker Image!
===================

How to run:
In the top leve directory "Docker-Data-Science" run:

 - ./base-data-science

 or run the following command:
 docker run --rm \
    -i -t \
    -v $HOME/Documents:/home/datasci/Documents \
    -v $HOME/Downloads:/home/datasci/Downloads \
    -w /home/datasci/ \
    -p 8888-9000:8888-9000 \
    qinetiq/base-data-science:latest

 Assumes Documents and Download Directory


How to run jupyter:

 - jupyter notebook --no-browser --ip'*' (will be update with config file so that you can just run jupyter notebook)
 -
Languages:

 - Python (2.7, 3.6)
 - R
 - Julia
 - Octave
 - Haskell (In progress)

Jupyter Kernels:

 - Python
 - SageMath
 - R
 - Octave
 - Julia
 - Scala
 - Java (jdk8)
 - Haskell (In Progress)
 - javascript

Jupyter Widgets

 - Rise (Notebook Presentations)
 - IpyWidgests
 - Dashboard
 - Ipyleaflet (Maps)
 - Jupyter contrib nbextensions

Documentation:

 - Pandoc
 - TexLive

Dev environment:

 - Jupyter Notebook
 - JupyterLab
