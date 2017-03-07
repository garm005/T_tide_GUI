% ++++++++++++++++++++++++++++++++++++++++++++++++
% +            S u b f u n c i o n               +
% ++++++++++++++++++++++++++++++++++++++++++++++++
% Subfuncion que realiza la correccion del nivel de referencia de la marea
function [niv] = niveles(elec,cargah,regis0,prono)
% ______________________________________________________
% Esta subrutina 
%
% ______________________________________________________

% Asignando el valor del nivel de refencia a una variable
if elec == 1
          %niv = mean(cargah(1:1:regis0));
          niv = mean(cargah(1:1:regis0),0);
   elseif elec == 2
          niv = editp3_1;
   elseif elec == 3
          niv = 0;
   else
          NMMreg = cargah(1:1:regis0);
          NMMfore = prono(1:1:regis0);
          
          maxtide = ceil(max(NMMreg));
          
          % Nivel de referencia con el cual se realizara la comparacion de
          % errores.
          nivel = (0.01:0.01:maxtide)';
          
          % Vectorizando variables
          errorela = zeros(regis0,1);

          barratiempo = waitbar(0,'Calculando error absoluto...' , 'Name' , 'Espera un momento' );
               for ii=1:100
                   % Calculando el error absoluto
                   for kon1 = 1:length(nivel)
                        errorabs(:,kon1) = abs( NMMreg - ( NMMfore + nivel(kon1,1) ) );
                   end
                   waitbar(ii/100)
                end
          close(barratiempo);

          % Conociendo las dimensiones de la matriz de error absoluto
          dimerror = size(errorabs);
          
          barratiempo = waitbar(0,'Calculando error relativo...' , 'Name' , 'Espera un momento' );
              for ii=1:100
                  %Calculando el error relativo
                  for j = 1:dimerror(1,2)
                      for i = 1:dimerror(1,1)
                         errorela(i,j) = (errorabs(i,j)/cargah(i,1))*100;
                      end
                  end 
                  waitbar(ii/100)
               end
          close(barratiempo);
          
          % Obteniendo la sumatoria de los errores relativos
          toterror = sum(errorela);
          
          % Identificando cual es el error minimo y que no. de linea tiene
          [minniv,linmin] = min(toterror); %#ok<ASGLU>
          niv = nivel(linmin,1);
end

fprintf('\n');