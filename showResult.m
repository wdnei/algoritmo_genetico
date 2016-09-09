function [] = showResult( funcaoProblema,intervalo,pontos )
%SHOWRESULT Summary of this function goes here
%   Detailed explanation goes here


ezplot(funcaoProblema,intervalo);
hold on;
[tam,j]=size(pontos);
for i=1:tam
    x=pontos(i);
    y=funcaoProblema(pontos(i));
    text(x,y,int2str(i),'HorizontalAlignment','left');
    %plot(x,y,'*');

end
hold off;

