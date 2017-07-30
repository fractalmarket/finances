function spf_update(symbol,startDate, endDate)
%   Update some parameter from Google or Fred.   

    % Checking for optional endDate.
    if ~exist('Order', 'var')
        endDate = today('datetime');
    end
    
    %Define root of db;
    root = strcat('database/',symbol,'.csv');
    
    %If will a Google parameter; 
    try
       data = GetHistoricFred(symbol,startDate,endDate);
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
       %If will a Google parameter; 
       try
           if(strcmp(MExc.identifier,'MATLAB:urlread:ConnectionFailed'))
               data = GetHistoricGoogle(symbol,startDate,endDate);
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

