#------------------------------------------------------------------------------
# @author: SIANA Systems
# @date: 04/2018 (original)
#
# Docker used for training models for ST Cube.AI using TF/Keras.
#
# IMPORTANT: a copy of the Cube.AI must be present under: ./cubeai
#
# Based on Keras dockerfile (for CPU-only):
# ref: https://github.com/keras-team/keras/issues/8667
#------------------------------------------------------------------------------

FROM debian:bullseye

# create 'siana' user...
ENV NB_USER siana
ENV NB_UID 1000
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

# Copy Cube.AI
COPY --chown=siana:root cubeai /opt/cubeai
ENV X_CUBE_AI_DIR /opt/cubeai
ENV PATH $X_CUBE_AI_DIR:$PATH

# Install system packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
      bzip2 \
      g++ \
      git \
      graphviz \
      libgl1-mesa-glx \
      libhdf5-dev \
      openmpi-bin \
      nano \
      wget && \
    rm -rf /var/lib/apt/lists/*

# download & install conda (python 3.8)
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
RUN wget --quiet --no-check-certificate https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-py38_4.12.0-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-py38_4.12.0-Linux-x86_64.sh && \
    echo export PATH=$CONDA_DIR/bin:"$PATH" > /etc/profile.d/conda.sh

RUN chown $NB_USER $CONDA_DIR -R && \
    mkdir -p /src && \
    chown $NB_USER /src

USER $NB_USER

# install PIP dependencies
RUN pip install --upgrade pip && \
    pip install --ignore-installed \
      six \
      invoke         \
      tensorflow-cpu \
      tensorflow-estimator \
      sklearn_pandas \
      keras-tuner

# install python modules...
RUN conda install \
      bcolz \
      matplotlib \
      mkl \
      nose \
      notebook \
      Pillow \
      pandas \
      pydot \
      pyyaml \
      scikit-learn

# install audio processing lib
RUN conda install -c conda-forge librosa

RUN conda clean -yt

ENV PYTHONPATH="/src/:$PYTHONPATH"

WORKDIR /src

EXPOSE 8888

CMD jupyter notebook --port=8888 --ip=0.0.0.0

