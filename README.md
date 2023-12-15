# Read Me: climate-aid-diff-in-diff project

## Overview

**What this project does and why is useful?**

This project originated within a "Big Data for Public Policy" master's coursework, where the goal was to apply novel data collection and analysis methods to a chosen social research question. This work utilized topic modeling for classification, but due to limitations in accuracy, a dictionary-based approach was implemented. This strategy allowed me to answer the research question: To what extent did the Escazú Agreement influence the allocation of Multilateral Development Bank (MDB) climate finance in Latin America?

Likewise, this study was limited by time constraints. A more granular dataset and/or the application of a Dynamic Difference-in-Differences strategy could perhaps provide further insights. Nevertheless, while the positive findings of this study are not statistically significant, they suggest that the Escazú Agreement has had a positive impact on World Bank climate finance allocation. This suggests that countries not yet party to the agreement may find it a valuable strategic investment for enhancing climate finance access.

## **Data** Availability

This project used administrative data from the [World Bank - Projects & Operations](https://projects.worldbank.org/en/projects-operations/projects-list?os=0) website stored in the `/raw_data` folder. The data is processed and cleaned using the dplyr and tidyr packages. The cleaned data for this project for Latin American countries is saved in the `/1_processed_data` folder.

## Computational requirements

Regarding software requirements, this package was build using the 4.3.0 R version with Microsoft Windows 10.

## Description of code

The code used for the analysis for this project is located in the `2_code_models` directory. The code is organized into a series of .R and .Rmd scripts, each of which performs a specific task. Moreover, note that a brief README section in the beginning of each script has been included. This will give an idea on inputs and outputs expected from the code.

Regarding the structure to reproduce the final outputs displayed in the `1_DiD_modeling.html` . To replicate the code fork and clone this repository and follow the numbered folder and file sequence.

## Reference

Lars Vilhuber, Connolly, M., Koren, M., Llull, J., & Morrow, P. (2022). A template README for social science replication packages (v1.1). Zenodo. <https://doi.org/10.5281/zenodo.7293838>

------------------------------------------------------------------------

## Acknowledgements

This README was built following the [Social Science Data Editors](https://social-science-data-editors.github.io/template_README/ "https://github.com/social-science-data-editors/template_README/blob/release-candidate/templates/README.md") template.
