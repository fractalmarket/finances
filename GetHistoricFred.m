function [ data ] = GetHistoricFred(symbol,startDate,endDate)
%   Forked by Julio Lima (Universidade Federal do CearÃ¡)
%   Query date ranges from Fre finance.
%   Sample usage: GetHistoricFred('M1','04/27/2010','04/27/2017')
%   Symbols to use: 
%   |-> M1 Money Stock: M1
%   |-> M1 Money Multiplier: MULT
%   |-> S&P 500: SP500
%   |-> Effective Federal Funds Rate: FEDFUNDS
%   |-> Real Personal Consumption Expenditures: PCEC96

    %Define a format of query.
    format = 'yyyy-mm-dd';

    %First transform to the number format, it's a generic one.
    startDateNum = datenum(startDate);
    endDateNum = datenum(endDate);

    %First transform to the number format, it's a generic one.
    startDateStr = datestr(startDateNum, format);
    endDateStr = datestr(endDateNum, format);

    %Define how much attributes will be used.
    n_attb = 3;
    
    attributes(1) = cellstr(strcat('&id=',symbol));
    attributes(2) = cellstr(strcat('&cosd=',startDateStr));
    attributes(3) = cellstr(strcat('&coed=',endDateStr));

    %Define root of query.
    root = strcat('https://fred.stlouisfed.org/graph/fredgraph.csv?chart_type='); %root the url address to download in csv format
    
    %Interact root with attributes.
    for i_cat = 1:n_attb
        root = strcat(root,attributes(i_cat));
    end
    
    url = char(root);
    
    %%Display address URL.
    disp(url)
    
    %Receive the file;
    response = urlread(url);
    
    %Scan and convert the file to cells and return.
    data = textscan(response,'%s %f','delimiter',',','HeaderLines',1);  
    
end
