dn_combo <- c("day","night")
ss_combo <- c("summer","fall")
ant_combo <- names(ant.species[ant.species > 5])
tree_combo <- names(tree.species[tree.species > 50])

resultList <- list()

for (i in 1:length(ss_combo)) {
  for (j in 1:length(dn_combo)) {
    ant.data.sub <- subset(ant.data, SPECIES != 'DEAD' &
                             SEASON == ss_combo[i] &
                             DAY_NIGHT == dn_combo[j] &
                             REGION != 0);
    resultTable <- data.frame(dummy = rnorm(length(ant_combo),0,1))
    resultTable[,tree_combo] <- NA
    rownames(resultTable) <- ant_combo
    resultTable <- resultTable[,-1]
    
    for (k in 1:length(tree_combo)) {
      num.uniq.tree <- length(unique(ant.data.sub$UNIQUEID))
      num.uniq.tree.X <- length(unique(ant.data.sub$UNIQUEID[ant.data.sub$SPECIESCOD == tree_combo[k]]))
      num.uniq.tree.notX <- num.uniq.tree - num.uniq.tree.X
      
      for (l in 1:length(ant_combo)) {
        ant.data.sub[ant.data.sub$SPECIESCOD == tree_combo[k],
                     "TREETYPE"] <- paste('O', tree_combo[k])
        ant.data.sub[ant.data.sub$SPECIESCOD != tree_combo[k],
                     "TREETYPE"] <- paste('X', tree_combo[k])
        ant.data.sub[ant.data.sub$SPECIES == ant_combo[l],
                     "ANTTYPE"] <- paste('O', ant_combo[l])
        ant.data.sub[ant.data.sub$SPECIES != ant_combo[l],
                     "ANTTYPE"] <- paste('X',ant_combo[l])
        
        mytable <-
          table(ant.data.sub$ANTTYPE, ant.data.sub$TREETYPE)
        
        if (dim(mytable)[1] == 2) {
          mytable[2,1] <- num.uniq.tree.X - mytable[1,1]
          mytable[2,2] <- num.uniq.tree.notX - mytable[1,2]
          Xsq <- chisq.test(mytable)
          
          name <- paste(ss_combo[i],
                        dn_combo[j],
                        tree_combo[k],
                        ant_combo[l],
                        sep = ",")
          resultList[[name]] <- Xsq
          resultTable[l,k] <- Xsq$p.value
        }
      }
    }
    
    # write resulting p values to csv file
    write(
      c(ss_combo[i],
        dn_combo[j]),'chisq_results.csv',ncolumns = 2,append = TRUE,sep = ","
    )
    write.table(resultTable,'chisq_results.csv', sep = ',',append = TRUE)
  }
}