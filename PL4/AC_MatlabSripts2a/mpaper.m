% Aprendizagem Computacional, Computa��o Neuronal e Sistems Difusos, DEI,
% dois mil e dezanove.
% Digitaliza��o de um car�ter desenhado manualmente .
% Usa-se para construir as matrizes de dados P, que se guarda em formato .mat 
% Tamb�m pode servir  para estabelecer os vectores alvo ("target") num problema de
% classifica��o: desenham-se cuidadosamente na grelha produzida pela fun��o, guardando-se
% a� como a matriz T.No entanto � prefer�vel usar para este efeito o
% ficheiro PerfectArial.mat que cont�m os 10 carateres arial perfeitos,

function mpaper(varargin)

warning off MATLAB:divideByZero

% Neste trabalho pr�tico esta fun��o � usada simplesmente 
% para gerar entradas a partir de uma grelha onde o utilizador desenha, com
% o rato, um algarismo (0 a 9). A c�lula do algarismo � dividida numa
% grelha 16x16 e cada quadr�cula � transformada num 1 ou num 0, conforme
% esteja ou n�o preenchida pela linha desenhada nessa c�lula.
%
% Pode-se chamar de um script, com um n�mero vari�vel de argumentos (varargin, variable arguments input) ou correr  
% directamente da linha de comando, escrevendo simplesmente mpaper. Aparece
% uma quadr�cula 5x10.Este texto corresponde a 2019  Desenha-se um algarismo em cada c�lula.
% O resultado da "digitaliza��o" da quadr�cula � armazenado na estrutura
% data.X. Cada coluna de 256 linhas corresponde a um quadrado.
%
% Este ficheiro foi adaptado por J. Henriques para a cadeira de Computa��o
% Adaptativa. Ver abaixo autoria original.

%Resumindo:
% 1� Corre-se mpaper (sem fazer classifica��o, comentando a linha feval n� 209 neste ficheiro)

% 2� Desenham-se caracteres em n�mero suficiente, um em cada quadr�cula
% apresentada, para construir os dados de treino. Para um classificador
% razo�vel s�o neces�rios pelo menos 500 carateres para treino.

% 2� Usa-se a matriz das entradas P assim criada para o nosso problema,
% activando as linhas 178 e 189 e desactivando a linha 217 e 218.
% 
% 3� Para se graficar cada entrada numa grelha, usa-se a fun��o grafica
% (X,Y, Z), que permite visualizar uma, duas, ou tr�s entradas.
% o bot�o central do rato, quando n�o existe, pode ser substitu�do pela
% combina��o Shift+bot�o esquerdo  (Shift para mai�sculas).

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
%
% MPAPER Allows to enter handwritten characters by mouse.
%
% Synopsis:
%  mpaper
%  mpaper( options )
%  mpaper({'param1',val1,...})
%
% Description:
%  This script allows a user to draw images by mouse to 
%  figure with a grid. The drown images are normalized to
%  exactly fit the subwindows given by the grid.
%  Control:
%    Left mouse button ... draw line.
%    Right mouse button ... erase the focused subwindow.
%    Middle mouse button ... call function which proccess the
%      drawn data. (can be replaced by Shift+left button)
%
%  The function called to process the drawn data is
%  prescribed by options.fun. The implicite setting is 'ocr_fun'
%  which calls OCR trained for handwritten numerals and displays 
%  the result of recognition.
%
% Input:
%  options.width [int] Width of a single image.
%  options.height [int] Height of a single image.
%  options.fun [string] If the middle mouse button is 
%    pressed then feval(fun,data) is called where
%    the structure data contains:
%    data.X [dim x num_images] images stored as columns
%       of size dim = width*height.
%    data.img_size = [height,width].
%  
%  Example:
%   open ocr_demo.fig
%
% (c) Statistical Pattern Recognition Toolbox, (C) 1999-2003,
% Written by Vojtech Franc and Vaclav Hlavac,
% <a href="http://www.cvut.cz">Czech Technical University Prague</a>,
% <a href="http://www.feld.cvut.cz">Faculty of Electrical engineering</a>,
% Modifications:
%  9-sep-03, VF, 
%  8-sep-03, MM, Martin Matousek programmed the GUI enviroment.
%  usado em dois mil e dezanove
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
if nargin >= 1 && ischar(varargin{1}),
  switch varargin{1},
    case 'Dn', Dn;
    case 'Up', Up;
    case 'Plot', Plot;
  end
else
   
  if nargin >=1, options = c2s(varargin{1}); else options=[]; end
  
  % function called when middle button is pressed
  if ~isfield( options, 'fun'), options.fun = 'ocr_fun'; end
  
  % resulting resolution of each character
  if ~isfield( options, 'width'), options.width = 16; end
  if ~isfield( options, 'height'), options.height = 16; end
  
  % brush stroke within del_dist is deleted
  if ~isfield( options, 'del_dist'), options.del_dist = 0.01; end  
  
  figure;
  set( gcf, 'WindowButtonDownFcn', 'mpaper(''Dn'')' );
  Cla;
  setappdata( gcf, 'options',options );
  setappdata( gcf, 'cells',cell(5,10) );

end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Up(varargin)
    set( gcf, 'WindowButtonMotionFcn', '' );
    set( gcf, 'WindowButtonUpFcn', '' );
    
    last = getappdata( gcf, 'last' );
    x = get( last, 'xdata' );
    y = get( last, 'ydata' );
    
    if ~isempty(x)
     [r c]= index( [ x(1) y(1) ] );
    
     cells = getappdata( gcf, 'cells' );
     cells{r,c} = [cells{r,c} last];
     setappdata( gcf, 'cells', cells );
    end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Dn(varargin)
      switch get(gcf, 'SelectionType')   % clicked mouse button
          
       case 'normal'  % left     se carregar no bot�o esquerdo do rato
          setappdata(gcf, 'last', [] );
          set( gcf, 'WindowButtonMotionFcn', 'mpaper(''Plot'')' );
          set( gcf, 'WindowButtonUpFcn', 'mpaper(''Up'')' );
          Plot
          
        case 'extend'  % middle  se carregar no bot�o do meio do rato ou ent�o na combina��o Shift+bot�o esquerdo
            disp('----------- Classify -----------')
         
          cells = getappdata( gcf, 'cells' );
          for r =  1:5
            for c = 1:10
              if( ~isempty(cells{r,c}) )
                normalize( ([r c]-1)/10+0.001 , [0.098 0.098], cells{r,c} );
              end
            end
          end
          if(1)
          options=getappdata( gcf, 'options');
          handles=findobj(gca, 'tag', 'brush_stoke');            
          bmp = plot2bmp( handles);
          if ~isempty(options.fun),
             data.img_size = [options.height,options.width];
             dim = prod(data.img_size);
             data.X = zeros(dim,10*5);
             for j=1:5,
               for i=1:10,
                   xrange=(i-1)*options.width+1 : i*options.width;
                   yrange=(j-1)*options.height+1 : j*options.height;
                   x = reshape(bmp(yrange,xrange),dim,1);
                   data.X(:,i+(j-1)*10)= x;
                end
             end
             
 %________________________codigo a alterar_______________________________
 %{
             P=data.X;
             ind=find( sum(data.X) ~= 0);
             
 
              if ~isfile('P.mat')
                  P=data.X;
              else
                  load 'P.mat' P
                  P=[P data.X];
              end
              save P.mat P
          
             save ind.mat ind
 %}          
             feval(options.fun,data);
           
%________________________codigo a alterar_______________________________

           else             
             figure; 
             imshow(bmp,[]);
           end
%                        figure(7); 
%                       imshow(bmp,[]);
           end
            
        case 'alt'     % right  ( se carregar no bot�o direito do rato)
            disp('----------- Erased -----------')
          %          Cla
          cells = getappdata( gcf, 'cells' );
          x = get( gca, 'currentpoint' );
          [r c] = index(x([1 3]));
          if ~isempty(cells{r,c}) 
            %set(cells{r,c}, 'erasemode','normal');
            set(cells{r,c});
            delete(cells{r,c});
            cells{r,c} = [];
          end
          setappdata( gcf, 'cells', cells );
      end

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Cla()
  cla;
  plot( [ 0 0 1 1 0 ], [ 0 .5 .5 0 0 ] );
  hold on;
  for i = 1:9, plot( [i/10 i/10],[0 .5] ); end
  for i = 1:4, plot( [0 1],[i/10 i/10] );  end

  axis equal;
  
  %set( gca, 'drawmode', 'fast' );
  set( gca, 'SortMethod', 'childorder' );
  set( gca, 'interruptible', 'off' );
  set( gca, 'xlimmode', 'manual', 'ylimmode', 'manual', 'zlimmode', 'manual' );
% axis off

  title('DRAW:Left          ERASE:Right         Classify:Middle','FontSize',14,'Color','blue');

%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function Plot(varargin)
   x =get( gca, 'currentpoint' );
   if( x(1) > 0 && x(1) < 1 && x(3) > 0 && x(3) < 1 );
     l = getappdata(gcf, 'last');
     if( isempty( l ) ),
       l = plot( x(1), x(3), '.-' );
       %set( l, 'erasemode', 'none', 'tag', 'brush_stoke', 'color', [0.5 0 0] );
       set( l, 'tag', 'brush_stoke', 'color', [0.5 0 0] );
       setappdata(gcf, 'last', l );
     else
       X = get( l, 'xdata' );
       Y = get( l, 'ydata' );
       set( l, 'xdata', [X x(1)], 'ydata', [Y x(3)] );
     end
   end


%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function bmp = plot2bmp( handles )
   options=getappdata( gcf, 'options');

   Width = options.width*10;
   Height = options.height*5;
   bmp = zeros( Height, Width );
   
   for i = 1:length(handles ),
      
%      X = get( handles(i), 'xdata');
%      Y = get( handles(i), 'ydata');
      points = get( handles(i), 'Userdata');
      X = points.xdata;
      Y = points.ydata;

      x1 = min(fix(X(1)*Width)+1,Width);
      y1 = min(fix(2*Y(1)*Height)+1,Height);
      for j=1:length( X )
        x2 = min(fix(X(j)*Width)+1,Width);
        y2 = min(fix(2*Y(j)*Height)+1,Height);

        n = max( ceil( max( abs(x2-x1), abs(y2-y1) ) * 2 ), 1 );
        a = [0:n]/n;
        
        x = round( x1 * a + x2 * (1-a) );
        y = Height - round( y1 * a + y2 * (1-a) ) + 1;
        bmp( y + (x - 1) * Height ) = 1;
        x1=x2; y1=y2;
      end
   end
  
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function normalize( corner, sz, h )
  
x = get( h, 'xdata' );
y = get( h, 'ydata' );
if( iscell(x) ), x = [x{:}]; end
if( iscell(y) ), y = [y{:}]; end

mx = min( x );
Mx = max( x );
sx = Mx - mx;
my = min( y );
My = max( y );
sy = My - my;

centerx = (mx + Mx) / 2;
centery = (my + My) / 2;
center = corner + sz/2;

if( sy/sx >  sz(1)/sz(2) )
  scale = sz(1) / sy;
else
  scale = sz(2) / sx;
end

for hnd = h
%  set( hnd, 'erasemode', 'normal' );
%  set( hnd, 'xdata', ...
%    ( get( hnd, 'xdata' ) - centerx ) * scale + center(2), ...
%      'ydata', ...
%      ( get( hnd, 'ydata' ) - centery ) * scale + center(1) );

  points.xdata = ( get( hnd, 'xdata' ) - centerx ) * scale + center(2);
  points.ydata = ( get( hnd, 'ydata' ) - centery ) * scale + center(1);
  set( hnd, 'userdata', points );
end


%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
function [r, c] = index( x )
r = min( floor( x(2) * 10 ) + 1, 5 );
c = min( floor( x(1) * 10 ) + 1, 10 );
