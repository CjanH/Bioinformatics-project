################
#READING + CLEANING FILE
my_data <- read.delim("r_script_input.txt") 
df <- subset(my_data, select = -c(X.Uploaded_variation,
                                 IMPACT,
                                 Feature,
                                 BIOTYPE,
                                 HGVSc,
                                 HGVSp,
                                 Codons,
                                 Existing_variation,
                                 DISTANCE,
                                 STRAND,
                                 FLAGS,
                                 SYMBOL_SOURCE,
                                 MANE,
                                 TSL,
                                 APPRIS,
                                 AF,
                                 CLIN_SIG,
                                 SOMATIC,
                                 PHENO,
                                 MOTIF_NAME,
                                 MOTIF_POS,
                                 HIGH_INF_POS,
                                 MOTIF_SCORE_CHANGE
))
################
#FILTERS everything that doesn't contain missense mutation, high PolyPhen score and low Sift score:
df1 <- df[grep("missense_variant", df$Consequence),]
df2 <- df1[grep("damaging", df1$PolyPhen),]
df3 <- df2[grep("deleterious", df2$SIFT),]

#LOADING GENE LIST
genlist <- read.csv("gene_list.csv")
col1 <- genlist[[1]] #Genes must all be in column 1!#################################################

#Removing genes except for the ones from list
genfilter <- df3[grep(paste0(col1, collapse = "|"), df3$SYMBOL),]
write.table(genfilter, file="output_Filtered_on_PolyPhen_Sift.csv", sep=",", row.names=FALSE)
#Deleting Dupes
distinct_list <- genfilter[!duplicated(genfilter$SYMBOL), ]
write.table(distinct_list, file="output_Filtered_on_PolyPhen_Sift_GENELIST.csv", sep=",", row.names=FALSE)


################
#FILTERS everything that doesn't contain missense mutation and high PolyPhen score:
genfilter2 <- df2[grep(paste0(col1, collapse = "|"), df2$SYMBOL),]
write.table(genfilter2, file="output_Filtered_on_PolyPhen.csv", sep=",", row.names=FALSE)
#Deleting Dupes
distinct_list2 <- genfilter2[!duplicated(genfilter2$SYMBOL), ]
write.table(distinct_list2, file="output_Filtered_on_PolyPhen_GENELIST.csv", sep=",", row.names=FALSE)


################
#FILTERS everything that doesn't contain missense mutation and low Sift score:
df4 <- df1[grep("deleterious", df1$SIFT),]
genfilter3 <- df4[grep(paste0(col1, collapse = "|"), df4$SYMBOL),]
write.table(genfilter3, file="output_Filtered_on_Sift.csv", sep=",", row.names=FALSE)
#Deleting Dupes
distinct_list3 <- genfilter3[!duplicated(genfilter3$SYMBOL), ]
write.table(distinct_list3, file="output_Filtered_on_Sift_GENELIST.csv", sep=",", row.names=FALSE)


