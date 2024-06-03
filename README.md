<span style="color:blue"> This repository is deprecated/unmaintained </span>.

# icon_case_study
Prepare case studies for running the ICON model following the MeteoSwiss setup.

## usage
``/path/to/prepare_case_study.sh YYMMDDHH HH``

-> the last argument refers to the leadtime, default = 2h


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
* ICON requires the boundaries to include the geopotential (FI). As this is missing in the archive, osm provides a hack-file (with FI which is however called FIS to match fieldextra's requirements): `/store/s83/tsm/ICON_INPUT/ifs-hres/ifs-hres-bc_fi_ml1_137x091_01.grb2` from which FIS is retrieved. This does however only match files since 2020. For older cases, it is recommended to retrieve FIS from the eas-file.
* If OMEGA is missing in the provided boundaries, removal of the corresponding lines in the fieldextra namelist will trigger ICON to calculate OMEGA during runtime. Tests (conducted by Guy at the time) did not show significant differences.

## requirements
* fieldextra
* spack -> icontools

## file overview
* ``prepare_case_study.sh`` : default script
* ``fx_template_2017_case.sh``: Example how to adapt the fieldextra namelists for a case from 2017, such as the cold-air pool case of Fabian Schoeni's thesis. Ice, snow, and lake variables are completely missing, also SMI and land fraction are added. FIS field is taken from ECMWF eas-file. Omega is ignored. (ICON will produce its own estimate.)
* ``fx_template_2019_case.sh``: Example how to adapt the fieldextra namelists for a case from 2019, such as the valley-wind case of Tobia Lezuo's thesis. Unlike in 2017, lake variables are available.
* Jenkinsfile: For testing repo with jenkins.
* test.sh: Test which is executed with jenkins. Creates files for March 01, 2023. Test fails if no files were produced.



