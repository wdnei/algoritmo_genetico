%==========================================================================
% @desc Fazer o cruzamento com ponte de corte 
%
% @param pai1           - Pai em formato decimal
% @param pai2           - Pai em formato decimal
% @param nFilhos        - Numeros de filhos a serem gerados [1 ou 2]
% @param tamCromossomo  - Numero de bits maximo de um cromossomo
% @param taxaCross      - Taxa de crossover
%==========================================================================
function result=crossover(pai1,pai2, nFilhos, tamCromossomo, taxaCross)

    
    
    % Aplicar o crossover?
    
   
    crossover = roleta([taxaCross 100-taxaCross], 1);
    
    if crossover(1,1) == 1        

        % Cortar o cromossomo em algum lugar
        corte = floor(tamCromossomo * rand(1,1))+1;
        
        filhosC(1,:) = pai1(1,:);
        filhosC(2,:) = pai2(1,:);
        
        
        % Primeiro Filho
        filhosC(1, 1:corte) = pai1(1, 1:corte);
        filhosC(1, corte+1:tamCromossomo) = pai2(1, corte+1:tamCromossomo);

        if nFilhos == 2
            % Segundo Filho
            filhosC(2, 1:corte) = pai2(1, 1:corte);
            filhosC(2, corte+1:tamCromossomo) = pai1(1, corte+1:tamCromossomo);
        end
        
    % Nao aconteceu o crossover, entao os filhos serao iguais aos pais
    else
        filhosC(1,:) = pai1(1,:);
        filhosC(2,:) = pai2(1,:);
    end
    
    % Transformar de binario para decimal
    %filhos = bin2dec(filhos);
    
    % Retorno da funcao
    result =filhosC;

end