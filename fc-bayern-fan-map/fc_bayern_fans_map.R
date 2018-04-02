    library(dplyr)
    library(ggplot2)
    library(ggmap)
    library(grid)
    library(png)
    
    fc <- read.csv('fc_bayern.csv')
    
    fc_blue <- "#2E6ABD"
    fc_red <- "#ED1248"
    fc_white <- "#FFFFFF"
    
    fc_logo <- readPNG('Logo_FC_Bayern.svg.png')
    
    fc_bayern_theme <- function() {
      theme(
        legend.position = "none", #"bottom", legend.title = element_text(family = "Arial", colour = "#ED1248", size = 10),
        legend.background = element_rect(fill = "#E2E2E3"),
        legend.key = element_rect(fill = "#E2E2E3", colour = "#E2E2E3"),
        legend.text = element_text(family = "Arial", colour = "#E7A922", size = 10),
        
        plot.background = element_rect(fill = fc_white, colour = fc_white),
        plot.title = element_text(colour = fc_red, face = "bold", size = 18, vjust = 1, family = "Impact"),
        
        panel.background = element_rect(fill = fc_blue, colour = fc_red),
    
        panel.grid.major.y = element_blank(), #element_line(colour = "#E7A922"),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        strip.text = element_text(family = "Arial", colour = "white"),
        strip.background = element_rect(fill = "#E7A922"),
        
        axis.title = element_blank(), #element_text(colour = "grey", face = "bold", size = 13, family = "Arial"),
        axis.text = element_blank(), #element_text(colour = "grey", family = "Arial"),
        axis.ticks = element_blank() #element_line(colour = "grey")
      )
    }
    
    world <- map_data("world")
    world <- world[world$region != 'Antarctica',]

    g <- ggplot() + #ggtitle('A Global Community') +
      geom_polygon(data = world, aes(x=long, y = lat, group = group), fill = fc_white, color = fc_white) +
      geom_point(data=fc, aes(x=lng, y=lat, size = 1), pch = 21, fill = fc_red, color = fc_blue, alpha = 1) +
      fc_bayern_theme()
    
    vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
    
    png("fc_bayern_fans_map.png", width = 20, height = 10, units = "in", res = 500)
    grid.newpage() 
    pushViewport(viewport(layout = grid.layout(16, 16)))
    grid.rect(gp = gpar(fill = fc_red, col = fc_blue))

    print(g, vp = vplayout(1:16, 1:16))
    grid.raster(fc_logo, vp = vplayout(8:16, 1:4), hjust = 0.4)
    
    dev.off()
