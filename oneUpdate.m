function oneUpdate(symbol,startDate, endDate,show)
%   Update some parameter from Google or Fred.   

    % Checking for optional variables.
    % Display the urls.
    if ~exist('show', 'var')
        show = false;
    end

    % Checking for optional endDate.
    if ~exist('Order', 'var')
        endDate = today('datetime');
    end
    
    %Define root of db;
    root = strcat('database/',symbol,'.csv');
      
    %define to global the data variable;
    global data;
    
    %Find the Extern Database that match;
    try
        try
            data = GetHistoricFred(symbol,startDate,endDate, show);
        catch Exp1
            try
                if(strcmp(Exp1.identifier,'MATLAB:urlread:ConnectionFailed'))
                    data = GetHistoricGoogle(symbol,startDate,endDate, show);
                end
            catch Exp2
                try
                    if(strcmp(Exp2.identifier,'MATLAB:urlread:ConnectionFailed'))
                        data = GetHistoricBrasil(symbol,startDate,endDate, show);
                    end
                catch 
                end
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

