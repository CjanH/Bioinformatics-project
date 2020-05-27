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
#FILTER BEIDEN:
df1 <- df[grep("missense_variant", df$Consequence),]
df2 <- df1[grep("damaging", df1$PolyPhen),]
df3 <- df2[grep("deleterious", df2$SIFT),]
#write.table(df3, file="dummy_uit_r.csv", sep=",", row.names=FALSE)

#GENEN LIJST INLADEN
genlist <- read.csv("gene_list.csv")
col1 <- genlist[[1]] #genen moeten wel allemaal in column 1 zitten!#################################################

#FILTER ONBEKENDE GENEN
genfilter <- df3[grep(paste0(col1, collapse = "|"), df3$SYMBOL),]
write.table(genfilter, file="dummy_uit_r_genfilter_beiden.csv", sep=",", row.names=FALSE)
#DUPES WEG
distinct_list <- genfilter[!duplicated(genfilter$SYMBOL), ]
write.table(distinct_list, file="dummy_uit_r_genfilter_beiden_zonder_dupes.csv", sep=",", row.names=FALSE)


################
#FILTER POLYPHEN:
genfilter2 <- df2[grep(paste0(col1, collapse = "|"), df2$SYMBOL),]
write.table(genfilter2, file="dummy_uit_r_genfilter_polyphen.csv", sep=",", row.names=FALSE)
#DUPES WEG
distinct_list2 <- genfilter2[!duplicated(genfilter2$SYMBOL), ]
write.table(distinct_list2, file="dummy_uit_r_genfilter_polyphen_zonder_dupes.csv", sep=",", row.names=FALSE)


################
#FILTER SIFT:
df4 <- df1[grep("deleterious", df1$SIFT),]
genfilter3 <- df4[grep(paste0(col1, collapse = "|"), df4$SYMBOL),]
write.table(genfilter3, file="dummy_uit_r_genfilter_sift.csv", sep=",", row.names=FALSE)
#DUPES WEG
distinct_list3 <- genfilter3[!duplicated(genfilter3$SYMBOL), ]
write.table(distinct_list3, file="dummy_uit_r_genfilter_sift_zonder_dupes.csv", sep=",", row.names=FALSE)


