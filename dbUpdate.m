function dbUpdate()
%	Update all parameters in database from Google or Fred and Brasil.

    %M1 Money Stock - EUA
    oneUpdate('M1','01/06/1975');
    
    %M1 Money Multiplier
    oneUpdate('MULT','02/15/1984');
    
    %S&P 500
    oneUpdate('SP500','06/29/2007');
    
    %Effective Federal Funds Rate
    oneUpdate('FEDFUNDS','07/01/1954');

    %Real Personal Consumption Expenditures
    oneUpdate('PCEC96','01/01/1999');
    
    %SPY
    oneUpdate('SPY','12/01/2005');  
    
    %Banco do Brasil
    oneUpdate('BBAS3','06/13/2003');
    
    %Petrobras
    oneUpdate('PETR4','06/13/2003'); 
    
    %Ibovespa
    oneUpdate('IBOV','06/13/2003'); 
    
    %Itau
    oneUpdate('ITUB4','06/13/2003'); 
    
    
    %Informative.
    disp('DONE!');
end