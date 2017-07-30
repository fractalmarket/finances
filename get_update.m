function get_update()
%   Just run to obtain the whole statical variables updated.

    %M1 Money Stock
    specific_update('M1','01/06/1975');
    
    %M1 Money Multiplier
    specific_update('MULT','02/15/1984');
    
    %S&P 500
    specific_update('SP500','06/29/2007');
    
    %Effective Federal Funds Rate
    specific_update('FEDFUNDS','07/01/1954');

    %Real Personal Consumption Expenditures
    specific_update('PCEC96','01/01/1999');
    
    %SPY
    specific_update('SPY','12/01/2005');

    
end

function specific_update(symbol,startDate)
    
    root = strcat('database/',symbol,'.csv');
    try
       data = GetHistoricFred(symbol,startDate,today('datetime'));
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
       try
           if(strcmp(MExc.identifier,'MATLAB:urlread:ConnectionFailed'))
               data = GetHistoricGoogle(symbol,startDate,today('datetime'));
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
           end
       catch MExc1      
           disp(MExc1);
       end
    end
end

