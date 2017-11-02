
function [w_1,b_1,b_2,a_20,a_21] = CD11(w_1,p_1,b_1,b_2)
alpha = 0.001;
itr=50;
for i=1:itr
    
    
        % FIRST-RPM-FW:
        a_0   = logsig(w_1 * p_1 + b_1*ones(1,2));
        a_00  = sum(a_0,2);
        a_1   = a_0>rand(200,2);
        out_1 = a_1*p_1';
        p_11  = sum(p_1,2);
        
        % FIRST-RPM-BCK:
        a_2   = logsig(w_1'* a_1 + b_2*ones(1,2));
        a_21  = logsig(w_1*  a_2 + b_1*ones(1,2));
        a_20  = sum(a_21,2);
        out_2 = a_21*a_2' ;
        a_22  = sum(a_2,2);
        
        %UPDATE WIGHT AND BIASES
        
        w_1  = w_1 + (alpha)*(out_1 - out_2);
        b_1  = b_1 + (alpha)*(a_00  - a_20);
        b_2  = b_2 + (alpha)*(p_11  - a_22);
        
  
end



