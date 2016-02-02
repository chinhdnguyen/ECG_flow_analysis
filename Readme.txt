ECG_flow_analysis package:

Installation:
1. Extract the .zip 
2. Set Path and add with subfolder (select the main folder: ECG_flow_analysis).
3. In matlab command window, type: install. (to install recurrence plot toolbox).
 Done

Run the analysis:
The main program folder contains run_analysis.m.

run_analysis.m has 2 inputs: window length (in minutes) and overlap window length (in minutes).

You can run as following:
[result,HRV_result,IBI_result,CRS_result] = run_analysis(1,0.5);

Please select the .mat file of each patient, which is converted from EDF previously.

This script will generate an CSV file.

