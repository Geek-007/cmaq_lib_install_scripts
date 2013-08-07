#!/bin/csh

#> Installation script for IOAPI 3.1 on Killdevil w/PGI compilers
#> Scott Boone 6/10/2013 - initial script
#> Scott Boone 7/11/2013 - modified for Stampede with intel compilers

#> Set directories & system
 setenv BASE $cwd
 setenv BIN Linux2_x86_64ifort

#> Grab installation files
 wget http://www.baronams.com/products/ioapi/ioapi-3.1.tar.gz
 tar -zxf ioapi-3.1.tar.gz


#> Modify top-level makefile to use nocpl
sed -i 's#\${HOME}\/web31#'"$BASE"'#' Makefile
sed -i 's;CPLMODE    = cpl;\#CPLMODE    = cpl;' Makefile
sed -i 's;IOAPIDEFS  = -DIOAPICPL;\#IOAPIDEFS  = -DIOAPICPL;' Makefile
sed -i 's;PVMINCL    = \$;\#PVMINCL    = \$;' Makefile
sed -i 's/\# CPLMODE  = nocpl/  CPLMODE  = nocpl/' Makefile
sed -i 's/\# IOAPIDEFS=                    \#  for/  IOAPIDEFS=                    \#  for/' Makefile
sed -i 's/\# PVMINCL  = \/dev\/null          \#  for /  PVMINCL  = \/dev\/null          \#  for /' Makefile

#> Link Netcdf files
 cd $BASE/ioapi/
 ln -s /home1/02554/stboone/apps/netcdf/lib/libnet* $BASE/ioapi/

#> Modify makefile
 cp Makefile.nocpl Makefile
 sed -i 's#\${HOME}\/apps#'"$BASE"'#' Makefile

#> Increase MXVARS3
 sed -i 's#MXVARS3 = 2048#MXVARS3 = 65536#' PARMS3.EXT
 sed -i 's#MXVARS3 = 2048#MXVARS3 = 65536#' fixed_src/PARMS3.EXT

#> Correct Makeinclude
 sed -i 's#MFLAGS    = -mtune core2 -traceback#MFLAGS    = -mtune=core2 -traceback#' Makeinclude.Linux2_x86_64ifort
 sed -i 's/OMPFLAGS  = -openmp/#OMPFLAGS  = -openmp/' Makeinclude.Linux2_x86_64ifort
 sed -i 's/OMPLIBS   = -openmp/#OMPLIBS   = -openmp/' Makeinclude.Linux2_x86_64ifort

#> Install library
 make all

cd $BASE
