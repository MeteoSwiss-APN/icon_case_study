# prepare_icon_case_study
Prepare case studies for running the ICON model following the MeteoSwiss setup.

## Description
This script creates the analysis and boundary files for ICON simulations for a specified ICON grid. More specifically, it writes fieldextra- and iconsub-namelists which are executed at the end. Boundaries stem from IFS-HRES and the initial conditions are based on COSMO analyses. Note the following:
* Output gets written to `SCRATCH/input_icon/YYMMDDHH`.
* Script produces hourly boundary files without time shift.
* If the user does not specify the frame-grid this is generated using the icontools remap functionality.
* Namelist for iconsub (creation of LBC-frame-grid) follows an example from DWD.
* Recent analyses are taken from `/store/s83/osm/KENDA-1/ANA${yy}/det/laf20${date}`, for older case studies, user has to specify the folder in the fieldextra namelist.
* The temperature of ice is fixed to 273.15K.
* The ice fraction (FR_ICE) is added as a new field and set to 0.
* Fieldextra calculates the SMI.
* ICON requires the boundaries to include the geopotential (FIS). As this is missing in the archive, osm provides a hack-file: `/store/s83/tsm/ICON_INPUT/ifs-hres/ifs-hres-bc_fi_ml1_137x091_01.grb2` from which FIS is retrieved.
* If OMEGA is missing in the provided boundaries, removal of the corresponding lines in the fieldextra namelist will trigger ICON to calculate OMEGA during runtime. Tests did not show significant differences.


## requirements
* fieldextra
* spack (icontools)

## usage
``/path/to/prepare_case_study.sh YYMMDDHH HH``

-> the last argument refers to the leadtime, default = 2h

## file overview
* ``prepare_case_study.sh`` : default script
* ``prepare_17101512.sh``: Cold-air pool case of Fabian Schoeni's thesis. Analysis from COSMO-1 from 2017. Ice, snow, and lake variables are completely missing, also SMI and land fraction are added. FIS field is taken from ECMWF eas-file. Omega is ignored. (ICON will produce its own estimate.)
* ``prepare_19091212.sh``: Valley-wind case of Tobia Lezuo's thesis. Analysis from COSMO-1 from 2019. Unlike in 2017, lake variables are available.



