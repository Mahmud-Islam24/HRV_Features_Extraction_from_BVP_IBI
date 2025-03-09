# HRV_Features_Extraction_from_BVP_IBI
Overview
This repository contains MATLAB scripts for extracting Heart Rate Variability (HRV) features from Blood Volume Pulse (BVP) signals, obtained from wearable photoplethysmography (PPG) sensors. The extracted HRV features can be used for noninvasive interstitial glucose level estimation based on machine learning models.

The code was developed as part of a research study that evaluates the feasibility of sequence-based HRV feature extraction for continuous glucose monitoring using Continuous Glucose Monitoring (CGM) reference data. The repository provides implementations for adaptive thresholding-based R-peak detection, HRV feature computation, and feature engineering methods (e.g., polynomial augmentation and recursive feature elimination).

Features
Preprocessing of BVP signals: Denoising and peak detection using adaptive thresholding.
HRV Feature Extraction: Time-domain, frequency-domain, and nonlinear HRV metrics.
Polynomial Feature Augmentation: Creating higher-order HRV features to enhance machine learning model performance.
Support for Large-Scale HRV Analysis: The code processes long-term HRV sequences for glucose prediction.
Machine Learning Readiness: Outputs formatted for direct use in regression-based glucose estimation models.

Repository Structure: 

HRV_Features_Extraction_from_BVP_IBI/
│── HRV_Duke_Final_2_12_2025.m                  # Main HRV feature extraction script
│── HRV_Feature_Extraction_code_IEEE_2_14_2025.m # IEEE-formatted HRV extraction script
│── adaptive_thresholding_method_2_12_2025.m    # Adaptive thresholding for R-peak detection
│── README.md                                   # Documentation for repository usage

1. Installation: 
git clone https://github.com/Mahmud-Islam24/HRV_Features_Extraction_from_BVP_IBI.git
cd HRV_Features_Extraction_from_BVP_IBI
Required Software:

2. Required Softwares: 
MATLAB (R2021a or later recommended)
Signal Processing Toolbox
HRV Analysis Toolbox (if using additional HRV computation functions)

3. Usage
Preprocess BVP signals:

Run adaptive_thresholding_method_2_12_2025.m to detect R-peaks in BVP signals.
Extract HRV features:

Run HRV_Feature_Extraction_code_IEEE_2_14_2025.m to compute HRV metrics.
Apply polynomial feature augmentation (optional):

Modify HRV_Duke_Final_2_12_2025.m to enable polynomial feature generation.
Export features for machine learning:

Save extracted features in CSV or MATLAB .mat format for downstream analysis.

Citation
If you use this repository for research, please cite:
@article{Islam2025HRV,
  author = {Shekh M. M. Islam, Bill Chen, Karnika Singh, Leeor Hershkovich, Anastasia-Stefania Alexopoulos, Jessilyn Dunn},
  title = {Estimation of Interstitial Glucose Levels from Heart Rate Variability (HRV) Features Using Photoplethysmography (PPG) Signals},
  journal = {IEEE Transactions on Biomedical Engineering},
  year = {2025},
}






