#' Convert human gene synonyms to NCBI gene names
#'
#' This function converts a column containing human gene synonyms within a data frame
#' to NCBI gene names. If the column contains a mix of gene names and gene synonyms,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing gene synonyms to be converted to gene names
#' @return dataframe object
#' @export

gnameConverter<-function(genelist,colname){

  names(gene_synonyms2)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(gene_synonyms2$Gene_synonyms))
  bg5<-gene_synonyms2[gene_synonyms2$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% gene_synonyms2$Gene_name))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }

  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% gene_synonyms2$Gene_name_temp) && length(gene_synonyms2$Gene_name_temp[which(gene_synonyms2$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-gene_synonyms2$Gene_name_temp[which(gene_synonyms2$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }
  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}
