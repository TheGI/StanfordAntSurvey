dn_combo <- c("day","night")
ss_combo <- c("summer","fall")
ant_combo <- names(ant.species)

ant.data.sum <- NULL
for (i in 1:length(ss_combo)) {
  for (j in 1:length(dn_combo)) {
    for (k in 1:length(ant_combo)) {
    ant.data.sub <- subset(ant.data, SPECIES == ant_combo[k] &
                           REGION != 0);
    
    plot(jitter(ant.data.sub$TREE,0.3) ~ jitter(ant.data.sub$TEMP, 1))
    
    ant.data.sum = rbind(ant.data.sum, data.frame(sum(ant.data.sub$TREE)+
                              sum(ant.data.sub$BASE),
                            ss_combo[i], dn_combo[j],
                            ant_combo[k],
                            ant.data.sub$TEMP[1],
                            ant.data.sub$HUMID[1]))
    } 
  }
}
colnames(ant.data.sum) <- c('ACTIVITY','SEASON','DAY_NIGHT','SPECIES','TEMP','HUMID')
