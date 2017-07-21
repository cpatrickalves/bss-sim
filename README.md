# Brazilian Social Security Forecast Simulation Scripts (bssf-sim)

This project implements the long-term Social Security forecast model used by Brazilian Federal Government to estimates the revenues and expenses of National Pensions. 

The purpose of this implementation is to reproduce the forecasts of revenue and expenses presented in Table 5.2 of the **Budget Guidelines Law (LDO) of 2012**.

The mathematical models used in the forecasts of Social Security expenditures and revenues are described in Annex III, Fiscal Targets of 2012 LDO.

The Annex III of 2012 LDO is available [here](http://www.orcamentofederal.gov.br/orcamentos-anuais/orcamento-2012-1/pldo-2012/3.5_ANEXOIII.5RGPS.pdf).

The forecast model equations were implemented using the MATLAB software.

# Instructions

1. Download/clone the files 
2. In MATLAB software, run the main file called **ExecutarProjecao.m**
3. In MATLAB *Command Window* you will see the results:
    * Revenue estimates
    * Expenditure estimates
    * Variations (in %) between the obtained results and 2012 LDO results.
4. You can change some parameters described in the main file to evaluate their impact os results
