#' Convert human gene synonyms to HGNC approved gene names
#'
#' This function converts a column containing human gene synonyms within a data frame
#' to HGNC appreved gene names. If the column contains a mix of gene names and gene synonyms,
#' only gene synonyms will be converted to gene names and gene names will remain the same.
#'
#' @param genelist A dataframe object
#' @param colname Name of the column containing gene synonyms to be converted to gene names
#' @return dataframe object
#' @export

hgncConverter<-function(genelist,colname){

  names(hgnc)[1]<-"Gene_name_temp"
  n_occur <- data.frame(table(hgnc$Gene_synonyms))
  bg5<-hgnc[hgnc$Gene_synonyms %fin% n_occur$Var1[n_occur$Freq > 1],]

  bg5<-bg5[which(bg5$Gene_synonyms %fin% genelist[[colname]][which(!(genelist[[colname]] %fin% hgnc$Gene_name))]),]
  colnames(bg5)[2]<-colname

  genelist<-merge(genelist, bg5, by = colname, all = TRUE, allow.cartesian = TRUE)
  for (i in 1:length(genelist[[colname]])){

    if (!is.na(genelist$Gene_name_temp[i])){
      genelist[[colname]][i]<-genelist$Gene_name_temp[i]
    }
  }

  pb = txtProgressBar(min = 0, max =length(genelist[[colname]]) , initial = 0)
  for (i in 1:length(genelist[[colname]])){
    if (!(genelist[[colname]][i] %fin% hgnc$Gene_name_temp) && length(hgnc$Gene_name_temp[which(hgnc$Gene_synonyms %fin% genelist[[colname]][i])]) == 1){
      genelist[[colname]][i]<-hgnc$Gene_name_temp[which(hgnc$Gene_synonyms %fin% genelist[[colname]][i])]
    }
    setTxtProgressBar(pb,i)
  }
  return(genelist[,1:(length(genelist)-1), drop = FALSE])
}


hgncConverter2<-function(genelist,colname){
  colname2<-"Gene_name"
  tempcolname<-"Gene_synonyms"
  approved<-semi_join(genelist, hgnc, by = setNames(colname2, colname))
  someWOapproved<-anti_join(genelist, approved, by = colname)
  notApproved<-semi_join(someWOapproved, hgnc, by = setNames(colname2, colname))
  some<-rbind(approved, notApproved)
  non<-anti_join(genelist, some, by = colname)

  if ("Gene_name" %in% colnames(genelist) & !("Genename" %in% colnames(genelist))){
    hgnc_temp<-hgnc
    colnames(hgnc_temp)[1]<-"Genename"
    temp_notApproved<-left_join(notApproved, hgnc_temp, by = setNames(tempcolname, colname))
    temp_notApproved[[colname]]<-temp_notApproved$Genename
    temp_notApproved<-temp_notApproved %>% select(!Gene_name)
  }
  else if (!("Gene_name" %in% colnames(genelist))){
    temp_notApproved<-left_join(notApproved, hgnc, by = setNames(tempcolname, colname))
    temp_notApproved[[colname]]<-temp_notApproved$Genename
    temp_notApproved<-temp_notApproved %>% select(!Gene_name)
  }
  else {
    stop("Change the name of that damn column!")
  }

  all<-rbind(approved, temp_notApproved, non)
  return(all)

}

