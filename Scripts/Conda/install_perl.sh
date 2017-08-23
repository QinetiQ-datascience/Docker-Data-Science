#!/bin/bash
set -e

conda install --yes -c conda-forge perl

conda install --yes -c bioconda perl-app-cpanminus
cpanm --notest IO::Async::Loop Devel::IPerl PDL Moose MooseX::AbstractFactory MooseX::AbstractMethod MooseX::Storage Test::More
iperl kernel
