# T_tide_GUI
Matlab GUI to run T_tide

Para realizar el análisis armónico de las mareas con el T_Tide, el primer paso que se debe 
realizar es proporcionarle a Matlab la ruta de acceso de los archivos que
integran el T_Tide.

Los archivos que integran la interfase del T_Tide son:
1) TCam_V1C.m  (principal)
2) generatordate.m
3) niveles.m

La carpeta t_tide_v1.3beta contiene los archivos del T_tide de:
Pawlowicz, R., Beardsley, B. y Lentz, S. (2002). Classical tidal harmonic
      analysis including error estimates in Matlab using T_Tide. Computers
      & Geosciences. 28:929-937.

Con la meta de realizar un análisis armónico se debe ejecutar el script
TCam_V1C.m
que a su vez llamará los scripts:
generatordate.m
niveles.m

La GUI como archivo de entrada requiere un archivo del tipo mat que almacene
dos variables (vectores columna), en uno de ellos se guardaran los datos de
las fechas y en la otra variable se guardarán los datos de las elevaciones
de la superficie del agua. Se requiere que las variables tengan los nombres de
"fechas" y "cargah", respectivamente. Tambien es necesario que las fechas
se encuentren en formato de tiempo de Matlab.
