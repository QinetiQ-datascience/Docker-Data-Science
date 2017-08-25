#!/bin/bash
set -e

bash /tmp/Install/Conda/install_conda_base.sh
bash /tmp/Install/Libraries/install_libs_from_src.sh
bash /tmp/Install/Conda/install_sagemath.sh
bash /tmp/Install/Conda/install_julia.sh
bash /tmp/Install/Conda/install_nodejs.sh

# ADD Scripts/Conda/install_octave.sh /tmp/
# RUN bash /tmp/install_octave.sh

# ADD Scripts/Conda/install_r.sh /tmp/
# RUN bash /tmp/install_r.sh

# ADD Scripts/Conda/install_ruby.sh /tmp/
# RUN bash /tmp/install_ruby.sh

# ADD Scripts/Conda/install_perl.sh /tmp/
# RUN bash /tmp/install_perl.sh

# ADD Scripts/Conda/install_scala.sh /tmp/
# RUN bash /tmp/install_scala.sh

# ADD Scripts/Conda/install_stack.sh /tmp/
# RUN bash /tmp/install_stack.sh

# ADD Scripts/Conda/install_golang.sh /tmp/
# RUN bash /tmp/install_golang.sh



# ADD Scripts/Conda/install_spark.sh /tmp/
# RUN bash /tmp/install_spark.sh

# ADD Scripts/Jupyter/install_jupyter_widgets.sh /tmp/
# RUN bash /tmp/install_jupyter_widgets.sh