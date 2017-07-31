function oneUpdate(symbol,startDate, endDate,show)
%   Update some parameter from Google or Fred.  
    
    % Checking for optional endDate.
    if ~exist('show', 'var')
        show = false;
    end
    
    if ~exist('endDate', 'var')
        endDate = today('datetime');
    else      
        if (endDate == true || endDate == false)
            show = endDate;
            endDate = today('datetime');
        end
    end
    
    %Define root of db;
    root = strcat('database/',symbol,'.csv');
    
    %Find the Extern Database that match;
    try
        try
            data = GetHistoricFred(symbol,startDate,endDate, show);
        catch Exp1
            if(strcmp(Exp1.identifier,'MATLAB:urlread:ConnectionFailed'))
                try
                    data = GetHistoricGoogle(symbol,startDate,endDate, show);
                catch Exp2
                    if(strcmp(Exp2.identifier,'MATLAB:urlread:ConnectionFailed'))
                        try
                            data = GetHistoricBrasil(symbol,startDate,endDate, show);
                        catch Exp3
                            disp(Exp3);
                        end
                    else
                        disp(Exp2);
                    end
                end
            else
                disp(Exp1);
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