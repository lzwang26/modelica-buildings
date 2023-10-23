#!/bin/bash
set -e
idf_file='ZoneVSWSHP_wDOAS_FullLoad.idf'
energyplus \
  --readvars \
  --output-directory EnergyPlus \
  -w USA_CO_Denver-Stapleton.724690_TMY.epw \
  "$idf_file"
python csv_to_mos.py "$idf_file"
#rm -rf EnergyPlus
