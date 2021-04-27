#' Convert C. elegans gene names to human gene names
#'
#' This function converts a column containing C. elegans gene names within a data frame
#' to human gene names. If the column contains a mix of C. elegans and Human gene names,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing gene synonyms to be converted to gene names
#' @return dataframe object
#' @export

celegansConverter<-function(genelist,colname){

  names(celegans_homologs)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(celegans_homologs$Gene_synonyms))
  bg5<-celegans_homologs[celegans_homologs$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% celegans_homologs$Gene_name))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }

  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% celegans_homologs$Gene_name_temp) && length(celegans_homologs$Gene_name_temp[which(celegans_homologs$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-celegans_homologs$Gene_name_temp[which(celegans_homologs$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }
  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}
