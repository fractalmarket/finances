function [ data ] = GetHistoricGoogle( symbol,startDate,endDate )
%   Produced by Chris Reeves (A2X Capital LLC)
%   Forked by Julio Lima (Universidade Federal do Ceará)
%   Query date ranges from Google finance.
%   Sample usage GetHistoricGoogle('AAPL','04/27/2010','04/27/2017')
%   Order: 1-Date, 2-Open, 3-High, 4-Low, 5-Close, 6-Volume

    % Checking for optional Variables
    if ~exist('Order', 'var')
        order = 2;
    end

    %Define a format of query.
    %formatIn = 'dd-mmm-yyyy' or 'mm/dd/yyyy' or 'mm-dd-yyyy'
    formatUrl = 'yyyy-mm-dd';

    
    %First transform to the number format, it's a generic one.
    startDateNum = datenum(startDate);
    endDateNum = datenum(endDate);

    %First transform to the number format, it's a generic one.
    startDateStr = datestr(startDateNum,formatUrl);
    endDateStr = datestr(endDateNum,formatUrl);

    url = strcat('http://www.google.com/finance/historical?q=',symbol,'&startdate=',startDateStr,'&enddate=',endDateStr,'&output=csv');
    url = strrep(url,' ','%20');
    
    %Display address URL.
    %disp(url)
    
    %Receive the file and fix.
    response = urlread(url);
    data_in = textscan(response,'%s %s %s %s %s %s','delimiter',',','HeaderLines',1);
    
    %Filter data out by order.
    n_row = size(data_in{1,1});
    n_row = n_row(1,1);
    data = cell(n_row(1,1),2);
    data(:,1) = data_in{1,1};
    data(:,2) = data_in{1,order};
    
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