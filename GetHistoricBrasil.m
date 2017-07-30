function [ data ] = GetHistoricBrasil(symbol)
%   Produced by Chris Reeves (A2X Capital LLC)
%   Forked by Julio Lima (Universidade Federal do Ceará)
%   Query date ranges from Fred finance.
%   Sample usage: GetHistoricBrasil('11','04/27/2010','04/27/2017')
%   Código SGS to use:
%   |-> Selic Percetual Monthly: 4390
%   |-> Selic Percetual Daily: 1178

    %Define a format of query.
    %formatIn = 'dd-mmm-yyyy' or 'mm/dd/yyyy' or 'mm-dd-yyyy'
    
    %Split symbol.
    symbol = strsplit(symbol,'SGS');
    symbol = symbol(1,2);
    
    %Define root of query.
    %Root the url address to download in csv format.
    root = strcat('http://api.bcb.gov.br/dados/serie/bcdata.sgs.',symbol,'/dados?formato=csv');

    url = char(root);

    %Display address URL.
    disp(url)
    
    %Receive the file.
    response = urlread(url);
    response = strrep(response,'"','''');
    response = strrep(response,',','.');
    response = strrep(response,';',',');
    
    
    %Scan and convert the file to cells and return.
    data_in = textscan(response,'%s %s','delimiter',',','HeaderLines',1);    
    
    %Filter data out by order.
    size_max = size(data_in{1,1});
    n_row = size_max(1,1);
    data = cell(n_row,2);
    data(:,1) = data_in{1,1};
    data(:,2) = data_in{1,2};
    
    %Change datetime format to numbers and override the unreadble parameters.
    try
        i = 1;
        while i<=n_row
            %Change.
            data{i,1} = datenum(data{i,1});
            %Override.
            if(strcmp(data(i,2),'.') || strcmp(data(i,2),'-'))
                data(i,:) = [];
                i = i - 1;
            end
            i = i + 1;
        end
    catch       
    end
    
end