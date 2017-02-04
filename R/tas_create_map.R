# color code for species
dn_combo <- c("day","night")
ss_combo <- c("summer","fall")
output <- list()

for (i in 1:2) {
  for (j in 1:2) {
    # conditions for subset data to plot
    ant.data.sub <- subset(ant.data, SPECIES != 'DEAD' &
                             SEASON == ss_combo[i] &
                             DAY_NIGHT == dn_combo[j] &
                             REGION != 0);
    
    # plot tree locations with ant species, activity & trail presence info
    output[[2 * (i - 1) + j]] <- ggplot(data = ant.data.sub,
                                        mapping = aes(x = LON, y = LAT)) +
      geom_point(aes(
        shape =
          factor(ifelse(
            T_TRAIL == 1,
            ifelse(B_TRAIL == 1,
                   'Both Trails', 'Only Tree'),
            ifelse(B_TRAIL == 1,
                   'Only Base', 'No Trail')
          )),
        size = TREE + BASE + 1,
        colour = SPECIES
      )) +
      scale_colour_manual(values = ant.colours) +
      scale_size_continuous(range = c(1,4)) +
      scale_shape_manual(values = c(11, 1, 6, 2)) +
      scale_x_continuous(limits = c(min(ant.data$LON) - 0.0002, max(ant.data$LON) +
                                      0.0002)) +
      scale_y_continuous(limits = c(min(ant.data$LAT) - 0.0002, max(ant.data$LAT) +
                                      0.0002)) +
      guides(
        colour = guide_legend(
          title = "Ant Species",
          override.aes = list(size = 5),
          order = 1
        ),
        size = guide_legend(title = "Activity Levels",
                            order = 3),
        shape = guide_legend(
          title = "Trail Types",
          override.aes = list(size = 5),
          order = 2
        )
      ) +
      labs(title =
             paste("TAS", "2016", ss_combo[i],
                   dn_combo[j], "region all")) +
      theme_light()
  }
}
output
