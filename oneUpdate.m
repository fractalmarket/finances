function oneUpdate(symbol,startDate, endDate)
%   Update some parameter from Google or Fred.   

    % Checking for optional endDate.
    if ~exist('Order', 'var')
        endDate = today('datetime');
    end
    
    %Define root of db;
    root = strcat('database/',symbol,'.csv');
    
    %Define how much Extern Databases will be used.
    %List: 1-Fred , 2-Google, 3-Brasil
    nExternDatabase = 2;      
   
    global data;
    try
         %Find the Extern Database that match;    
        for i = 1:nExternDatabase
            try
                switch i
                    case 1
                        data = GetHistoricFred(symbol,startDate,endDate);
                    case 2
                        data = GetHistoricGoogle(symbol,startDate,endDate);
                    case 3
                        data = GetHistoricBrasil(symbol,startDate,endDate);
                end
            catch
            end
       end
       
       if (exist(root, 'file') == 2)
           n_row =  size(data);
           n_row_csv =  size(csvread(root));
           if(n_row_csv(1,1) < n_row(1,1))
               cell2csv(root,data);
               disp(strcat(symbol,' - Updated.'));
           elseif (n_row_csv(1,1) == n_row(1,1))
               disp(strcat(symbol,' - It''s already updated'));
           else
               disp(strcat(symbol,' - Not updated.'));
           end
       else
           cell2csv(root,data);
           disp(strcat(symbol,' - Created.'));
       end
       
    catch MExc
        disp(MExc)
    end
end

