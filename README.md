# A workflow to identify cardiovascular diseases
*A Bioinformatics minor project.*

Introduction ...

# Workflow
The workflow consists of 3 parts: Galaxy, Variant Effect Predictor and the R-script (see photo workflow…..). 
In the galaxy pipeline, the quality of the Illumina sequencing data is assessed and processed. The processing consists of trimming and mapping of the reads. The reads are mapped against the human reference genome (*Homo sapiens GRCh38.p13*).  The resulting BAM file then needs to go through Freebayes for the detection of SNPs which results in a vcf file. Then the low-quality score and duplicated SNPs are filtered away.

The Variant Effect Predictor (VEP) program uses the filtered vcf file to predict the effect of each gene and outputs a tab-delimited text file containing information of every detected SNP by Freebayes. 

Rstudio runs the VEP output through an R-script, filtering any unwanted information. The filtering is based on the PolyPhen and Sift scores and the missense mutation. The script runs 3 filters on the text file, The first filter filters everything that doesn’t contain a missense mutation, a high PolyPhen score and a low Sift score. The second filter filters everything that doesn’t contain a missense mutation and a high PolyPhen score. And the last filter filters everything that doesn’t contain a missense mutation and a low Sift score.
All 3 filters also output an extra file, a list of all possibly disease-causing SNPs.
