# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    r-base \
    r-base-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libfontconfig1-dev \
    libxml2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
 && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Install any needed Python packages specified in requirements.txt
RUN pip install pandas snakemake "pulp==2.6"

# Install any needed R packages
RUN Rscript -e "install.packages(c('tidyverse', 'dplyr', 'testit', 'stringr', 'BiocParallel', 'MPRAnalyze'), dependencies=TRUE)"

# Copy the current directory contents into the container at /app
COPY script.R /app/script.R
COPY . /app

# Define environment variable
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Run Snakemake when the container launches
CMD ["snakemake", "-s", "Snakefile"]
