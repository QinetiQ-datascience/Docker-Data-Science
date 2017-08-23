# Julia
conda install --yes -c conda-forge julia

echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /opt/conda/etc/julia/juliarc.jl

julia -e 'Pkg.init()' && \
julia -e 'Pkg.update()' && \
julia -e 'Pkg.add("HDF5")' && \
julia -e 'Pkg.add("Gadfly")' && \
julia -e 'Pkg.add("RDatasets")' && \
julia -e 'Pkg.add("Plots")' &&  \
julia -e 'Pkg.add("PyPlot")' &&  \
julia -e 'Pkg.add("IJulia")' && \
julia -e 'using HDF5' && \
julia -e 'using Gadfly' && \
julia -e 'using RDatasets' && \
julia -e 'using Plots' && \
julia -e 'using PyPlot' && \
julia -e 'using IJulia'

mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/