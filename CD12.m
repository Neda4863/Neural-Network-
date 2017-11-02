


function [w_2,b_3,b_4,a_41] = CD12(w_2,a_20,a_21,b_3,b_4)
alpha = 0.001;
itr=50;
for i=1:itr
    
    % FIRST-RPM-FW:
    a_3   = logsig(w_2 * a_21 + b_3*ones(1,2));
    a_30  = sum(a_3,2);
    out_1 = a_3*a_21';
    
    % FIRST-RPM-BCK:
    a_4   = logsig(w_2'* a_3 + b_4*ones(1,2));
    a_41  = logsig(w_2*a_4 + b_3*ones(1,2));
    a_42=sum(a_41,2);
    a_43=sum(a_4,2);
    out_2 = a_41*a_4' ;
    
    %UPDATE WIGHT AND BIASES
    
    w_2  = w_2 + (alpha)*(out_1-out_2);
    b_3 = b_3 + (alpha)*(a_30 - a_42);
    b_4 = b_4 + (alpha)*(a_20-a_43);
    
end
