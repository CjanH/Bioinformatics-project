my_data <- read.delim("jb6QMuiHMWvNpWWp.txt") 
#head(my_data)

df <- subset(my_data, select = -c(X.Uploaded_variation,
                                 IMPACT,
                                 Gene,
                                 Feature_type,
                                 Feature,
                                 BIOTYPE,
                                 HGVSc,
                                 HGVSp,
                                 cDNA_position,
                                 CDS_position,
                                 Protein_position,
                                 Amino_acids,
                                 Codons,
                                 Existing_variation,
                                 DISTANCE,
                                 STRAND,
                                 FLAGS,
                                 SYMBOL_SOURCE,
                                 HGNC_ID,
                                 MANE,
                                 TSL,
                                 APPRIS,
                                 AF,
                                 CLIN_SIG,
                                 SOMATIC,
                                 PHENO,
                                 PUBMED,
                                 MOTIF_NAME,
                                 MOTIF_POS,
                                 HIGH_INF_POS,
                                 MOTIF_SCORE_CHANGE
))

#head(df1)
df1 <- df[grep("missense_variant", df$Consequence),]
#head(df1)
df2 <- df1[grep("damaging", df1$PolyPhen),]
#head(df2)
df3 <- df2[grep("deleterious", df2$SIFT),]
#head(df3)

write.table(df3, file="dummy_uit_r.csv", sep=",", row.names=FALSE)


#filter weg onbekende genen die hart ziektes veroorzaken
gen <- c("MTHFD1L","PSRC1","MIA3","SMAD3","CDKN2A","CDKN2B","CXCL12","KIF6"," MYH15","PALLD","SNX19","VAMP8","LDLR","APOB","ABCG5","ABCG8","ARH","PCSK9","MYH7","TNNT2","TPM1","TNNI3","MYL2","MYBPC3","ACTC","MYL3","FBN1","NKX2-5","TBX5","GATA-4","NOTCH1")
genfilter <- df3[grep(paste0(gen, collapse = "|"), df3$SYMBOL),]
#head(genfilter)

write.table(genfilter, file="dummy_uit_r_genfilter.csv", sep=",", row.names=FALSE)
