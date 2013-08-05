#!/bin/csh

setenv BASE $cwd

#> fetch installation files
 wget http://www.unidata.ucar.edu/downloads/netcdf/ftp/netcdf-3.6.3.tar.gz
 tar -zxf netcdf-3.6.3.tar.gz

 cd  ${BASE}/netcdf-3.6.3
 ./configure --prefix=${BASE} 
 make
 make check install
