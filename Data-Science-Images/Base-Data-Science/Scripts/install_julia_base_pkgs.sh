# IJulia
# Make sure Jupyter won't try to migrate old settings
julia -e "Pkg.add(\"IJulia\")" && \
julia -e "Pkg.build(\"IJulia\")" && \

julia -e "Base.compilecache(\"IJulia\")" && \
julia -e "Base.compilecache(\"ZMQ\")" && \
julia -e "Base.compilecache(\"Nettle\")" && \
julia -e "using IJulia"
mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
chmod -R go+rx $CONDA_DIR/share/jupyter && \
rm -rf $HOME/.local