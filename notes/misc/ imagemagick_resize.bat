for %%f in (*.png) do convert.exe %%f -resize 384x384 -background black -gravity center -extent 384x384 %%f
