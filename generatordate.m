% ++++++++++++++++++++++++++++++++++++++++++++++++
% +            S u b f u n c i o n               +
% ++++++++++++++++++++++++++++++++++++++++++++++++
% Subfuncion que genera el archivo que se utiliza para el pronostico
function [timereg,regis,regis0,fechas,cargah,yearpres,a1] = generatordate(fechas,cargah,rbp2_2,editp2_1)
% _______________________________________________________________________
% Esta subfuncion genera la base de datos tanto en fechas como en cargas
% que se requiere para realizar el pronostico.
% _______________________________________________________________________

% Obteniendo el intervalo de tiempo que existe entre un registro y otro. Este dato servirá 
% para obtener la fechas de la predicción, acorde con el intervalo de los registros
dt = fechas(2,1) - fechas(1,1);

% Obteniendo el intervalo de tiempo que existe entre un registro y otro. Este dato es input 
% necesario para el T_TIDE. Ver documentación del T_TIDE para el timereg.
a1 = datevec(fechas(2,1)-fechas(1,1));
timereg = a1(1,5)/60;

% Obteniendo el no. de lineas de fechas y cargah esta variable se utiliza para agregar 
% el no. de lineas necesario para el pronostico anual
regis = length(fechas);

% Esta variable se utiliza para las graficas ya que se utiliza como abscisa, solamente 
% de las fechas del registro
regis0 = length(fechas);

% Obteniendo el año en el cual se corre el script (2010=yearpres)
qwe = clock;
%yearpres = 2010;
yearpres = qwe(1,1);

if rbp2_2 == 1
    elec1 = 5;
else
    elec1 = 6;
end

% Obteniendo la fecha del inicio del registro
startreg = datevec(datestr(fechas(1)));

if elec1 == 5
    % Obteniendo el periodo anual (365 dias)
    % Obteniendo año siguiente de acuerdo al año del primer registro
    ynext = startreg(1,1) + 1;
    % Fecha del año sigueinte de acuerdo a la primer fecha del registro
    yearc = datenum(ynext,startreg(2),startreg(3)-2,0,0,0);
    % Calculo de no. de dias transcurridos del año presente
    dtra = fechas(regis);
else
    yearc = editp2_1;
    % Calculo de no. de dias transcurridos del año del registro
    dtra = fechas(regis,1)-datenum(startreg(1,1),1,1,0,0,0);
end
fprintf('\n');
fprintf('********************************************************** \n');
clc;

% Determinando el no. de línea a partir del cual se iniciará las fechas del pronóstico
nreg = regis + 1;

% Iniciando temporizador
tic;

if yearc ~= 0
   % Incrementando el registro con las fechas en las cuales se realizará el pronóstico
   while dtra <= yearc
   % while fechas(regis,1) <= datenum(2010,12,31,23,59,59)  % <--- Para lerma
                 % Agregando una nueva fecha al registro, según los días que han transcurrido en el año
                 fechas(nreg,1) = fechas(regis,1) + dt;
                 % Redondeando a 5 cifras significativas, los decimales de la fecha
                 asdr = datevec(round(fechas(nreg,1).*1e5)./1e5);
                 % Corrigiendo el defase de los segundos y por consecuencia el defase de la fecha
                 if asdr(1,6) >= 30
                      asdr(1,5) = asdr(1,5)+1;
                      asdr(1,6) = 0;
                 else 
                      asdr(1,6) = 0; 
                 end
                 fechas(nreg,1) = datenum(asdr);

                 cargah(nreg,1) = NaN;
                 % Linea que me permiten visualizar en pantalla la fechas que se están agregando 
                 pant = datevec(fechas(nreg,1));          
                 % Imprime en pantalla la fecha que se va generando
                 fprintf('Fecha: %2.0f/%2.0f/%4.0f Hora: %2.0f:%2.0f:%2.0f \n',...
                         pant(1,3),pant(1,2),pant(1,1),pant(1,4),pant(1,5),pant(1,6));
                 % Recalculando el no. de lineas y los días transcurridos (!VECTORIZAR en un futuro, para optimizar!!)
                 regis = length(fechas);
                 % Calculando el numero de dias transcurridos
                 if elec1 == 5                        % Apagar para lerma
                     dtra = fechas(regis);            % Apagar para lerma
                 else                                 % Apagar para lerma
                     dtra = fechas(regis,1)-datenum(startreg(1,1),1,1,0,0,0);
                 end
                 nreg = regis + 1;                    % Apagar para lerma
   end
end
% Parando temporizador
tiem = toc;
fprintf('Tiempo de generación del archivo anual: %6f minutos \n',tiem/60);
fprintf('\n');
fprintf('********************************************************** \n');