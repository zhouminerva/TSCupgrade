# TSC Upgrade Model

## File Descriptions

- Upgrade3.slx - Simulink model file. 
- upgradeParams.mat - parameter file for model.
- stochastic.m - runs stochastic simulation and prints outcome metric distributions.

- urban_upgrade3.mat - stochastic simulation output for 1000 trials in urban setting.
- nonurban100_upgrade3.mat - stochastic simulation output for 1000 trials in rural setting.

- CSCupgrade3.m - collects individual hospital patient and ART volume data.
- extractData3.m - collects patient-centered outcomes such as % tPA, % EVT, and clinical outcomes.
- Coutcomes.m - collects clinical outcomes for patient population of upgraded center.
- randParam.m - variation of input parameters for stochastic simulation.
- randraw.m - function I did not write to generate random numbers in given distribution.

## How to Run

To run simulation, download all files into same directory. Run stochastic.m to run the stochastic simulation. Edit desired trials, interhospital distance, and service radius as desired. Requires at least MATLAB R2017a and Simulink 8.9. Contact zhouminerva@gmail.com for any issues.
