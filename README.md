# A workflow to identify cardiovascular diseases
*A Bioinformatics minor project.*

Introduction

At this time, one out of every three people will die of cardiovascular diseases. Which makes it the number one killer of humanity. In 2016, ischaemic heart disease and stroke were the main cause deaths worldwide. Which was a total of 15.2 million deaths in 2016. In the United States, heart diseases are the number one cause of deaths with a total of 23.1% of deaths in 2017. There are various types of heart diseases including conditions that affect the structure/function of the heart and blood vessel. Most are largely preventable and death rates are decreasing due to advances in prevention.

Goal of the project

Identifying the people at risk is the first step towards developing strategies for preventing cardiovascular diseases. By identifying genetic variants in RNA sequencing data with bioinformatics we can predict which cardiovascular diseases may occur. The goal of this project is to create a workflow in the Galaxy platform that identifies these variants, that may underly cardiovascular diseases. Various tools will be used to check the quality, prepare the RNA sequences, and alignment to a reference genome. The resulting alignment will be used to determine if there are any variations present. The data comes from real patients and thus must be handled with privacy in mind. The RNA sequence data for the project is provided by Utrecht UMC. The resulting workflow should be used in a private galaxy server. 

Approach of the project

In this project, we have created a workflow to identify genetic variants that may underly cardiovascular diseases. This workflow starts with a quality control on the RNA sequence data. An publicly available dataset was used to create the workflow. Where needed, quality was improved by trimming the dataset. The good quality output was used to map and align to the human reference genome (Homo sapiens GRCh38.p13). After that, single nucleotide polymorphisms (SNPs) are determined and checked on quality. The SNPs with a good quality score are used for the hazard determination in the Ensemble Variant Effect Predictor (VEP) tool. This output is edited in R Studio to a clear spreadsheet. 

# Workflow
![alt text](https://raw.githubusercontent.com/CjanH/Bioinformatics-project/master/Flowchart.png?token=APRFBSZXCWIU5RXM3JBBCKS6YUF4W)
The workflow consists of 3 parts: Galaxy, Variant Effect Predictor and the R-script (see image above). 
In the galaxy pipeline, the quality of the Illumina sequencing data is assessed and processed. The processing consists of trimming and mapping of the reads. The reads are mapped against the human reference genome (*Homo sapiens GRCh38.p13*).  The resulting BAM file then needs to go through Freebayes for the detection of SNPs which results in a vcf file. Then the low-quality score SNPs are filtered away.

The Variant Effect Predictor (VEP) program uses the filtered vcf file to predict the effect of each gene and outputs a tab-delimited text file containing information of every detected SNP by Freebayes. 

Rstudio runs the VEP output through an R-script, filtering any unwanted information. The filtering is based on the PolyPhen and Sift scores and the missense mutation. The script runs 3 filters on the text file, The first filter filters everything that doesn’t contain a missense mutation, a high PolyPhen score and a low Sift score. The second filter filters everything that doesn’t contain a missense mutation and a high PolyPhen score. And the last filter filters everything that doesn’t contain a missense mutation and a low Sift score.
All 3 filters also output an extra file, a list of all possibly disease-causing SNPs.
