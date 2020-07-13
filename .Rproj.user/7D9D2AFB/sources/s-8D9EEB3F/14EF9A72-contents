#' Convert mouse gene names to human NCBI gene names
#'
#' This function converts a column containing mouse gene names within a data frame
#' to human NCBI gene names. If the column contains a mix of mouse gene names and human gene names,
#' only mouse gene names will be converted to human gene names and mouse gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing mouse gene names to be converted to human gene names
#' @return dataframe object
#' @export

mousegnameConverter<-function(genelist,colname){

  names(mouse_homology)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(mouse_homology$Gene_synonyms))
  bg5<-mouse_homology[mouse_homology$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% mouse_homology$Gene_name))]),]
  colnames(bg5)[2]<-"Gene_name_A"

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }

  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% mouse_homology$Gene_name_temp) && length(mouse_homology$Gene_name_temp[which(mouse_homology$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-mouse_homology$Gene_name_temp[which(mouse_homology$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }
  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}
