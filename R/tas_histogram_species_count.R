# plot summary histogram of survey info
dn_combo <- c("day","night")
ss_combo <- c("summer","fall")
output <- list()

for (i in 1:2) {
  for (j in 1:2) {
    ant.data.sub <- subset(ant.data, SPECIES != 'DEAD' &
                             SEASON == ss_combo[i] &
                             DAY_NIGHT == dn_combo[j] &
                             REGION != 0);
    output[[2*(i-1)+j]] <- ggplot(data = ant.data.sub, aes(
      x = SPECIES, colour = SPECIES, fill = SPECIES
    )) +
      geom_bar() +
      scale_colour_manual(values = ant.colours) +
      scale_fill_manual(values = ant.colours) +
      labs(
        title = paste(
          "TAS", "2016", ss_combo[i],
          dn_combo[j], "region all"
        )
      ) +
      theme_light()
  }
}
multiplot(plotlist = output, cols = 2)