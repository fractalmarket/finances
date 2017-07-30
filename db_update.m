function db_update()
%	Update all parameters from Google or Fred in database.

    %M1 Money Stock
    spf_update('M1','01/06/1975');
    
    %M1 Money Multiplier
    spf_update('MULT','02/15/1984');
    
    %S&P 500
    spf_update('SP500','06/29/2007');
    
    %Effective Federal Funds Rate
    spf_update('FEDFUNDS','07/01/1954');

    %Real Personal Consumption Expenditures
    spf_update('PCEC96','01/01/1999');
    
    %SPY
    spf_update('SPY','12/01/2005');  
    
    %Banco do Brasil
    spf_update('BBAS3','06/13/2003');
    
    %Petrobras
    spf_update('PETR4','06/13/2003'); 
    
    %Ibovespa
    spf_update('IBOV','06/13/2003'); 
    
    %Itau
    spf_update('ITUB4','06/13/2003'); 
    
    
    %Informative.
    disp('DONE!');
end