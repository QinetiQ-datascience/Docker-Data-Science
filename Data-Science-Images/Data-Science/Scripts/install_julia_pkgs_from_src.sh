    julia -e "Base.compilecache(\"BinDeps\")" && \
    julia -e "Base.compilecache(\"Cairo\")" && \
    julia -e "Base.compilecache(\"Calculus\")" && \
    julia -e "Base.compilecache(\"Clustering\")" && \
    julia -e "Base.compilecache(\"Compose\")" && \
    julia -e "Base.compilecache(\"DataArrays\")" && \
    julia -e "Base.compilecache(\"DataFrames\")" && \
    julia -e "Base.compilecache(\"DataFramesMeta\")" && \
    julia -e "Base.compilecache(\"Dates\")" && \
    julia -e "Base.compilecache(\"DecisionTree\")" && \
    julia -e "Base.compilecache(\"Distributions\")" && \
    julia -e "Base.compilecache(\"Distances\")" && \
    julia -e "Base.compilecache(\"GLM\")" && \
    julia -e "Base.compilecache(\"HDF5\")" && \
    julia -e "Base.compilecache(\"HypothesisTests\")" && \
    julia -e "Base.compilecache(\"JSON\")" && \
    julia -e "Base.compilecache(\"KernelDensity\")" && \
    julia -e "Base.compilecache(\"Loess\")" && \
    #julia -e "Base.compilecache(\"Lora\")" && \
    julia -e "Base.compilecache(\"MLBase\")" && \
    julia -e "Base.compilecache(\"MultivariateStats\")" && \
    julia -e "Base.compilecache(\"NMF\")" && \
    julia -e "Base.compilecache(\"Optim\")" && \
    julia -e "Base.compilecache(\"PDMats\")" && \
    julia -e "Base.compilecache(\"RDatasets\")" && \
    julia -e "Base.compilecache(\"SQLite\")" && \
    julia -e "Base.compilecache(\"StatsBase\")" && \
    julia -e "Base.compilecache(\"TextAnalysis\")" && \
    julia -e "Base.compilecache(\"TimeSeries\")" && \
    julia -e "Base.compilecache(\"ZipFile\")" && \
    julia -e "Base.compilecache(\"Gadfly\")" 

    julia -e "Base.compilecache(\"MLBase\")" && \
    julia -e "Base.compilecache(\"Clustering\")"