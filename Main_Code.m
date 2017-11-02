close all
clc
clear

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%termproject%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%Fisrt Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%p=[zeros(20,6),ones(20,8),zeros(20,6)];  %This is arbitarary input

%%%%%%%%%%%%Second Input%%%%%%%%%%%%test%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p=[ zeros(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,9),ones(1,2),zeros(1,9);
%     zeros(1,8),ones(1,4),zeros(1,8);
%     zeros(1,7),ones(1,6),zeros(1,7);
%     zeros(1,6),ones(1,8),zeros(1,6);
%     zeros(1,5),ones(1,10),zeros(1,5);
%     zeros(1,4),ones(1,12),zeros(1,4); 
%     zeros(1,3),ones(1,14),zeros(1,3); 
%     zeros(1,2),ones(1,16),zeros(1,2);
%     zeros(1,1),ones(1,18),zeros(1,1);
%     ones(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,20);
%     zeros(1,20)];
  
%%%%%%%%%%%%%%%%%%%%Third input%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=[ zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    zeros(1,5),ones(1,5),zeros(1,5),ones(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5);
    ones(1,5),zeros(1,5),ones(1,5),zeros(1,5)];
  


p_1=p(:); %make matrix like a vector

w_1 = randn(200,400) * 0.1;
b_1 = rand(200,1) - 0.5;
b_2 = rand(400,1) - 0.5;
alpha = 0.001;
itr=50;
w_2 = randn(100,200) * 0.1;
b_3 = rand(100,1) - 0.5;
b_4 = rand(200,1) - 0.5;

[w_1,b_1,b_2,a_21] = CD11(w_1,p_1,b_1,b_2,itr,alpha);
[w_2,b_3,b_4,a_41] = CD12(w_2,a_21,b_3,b_4,itr,alpha);

iteration=1e7;
beta=0.001;
for i=1:iteration
%FORWARD


[R,Q]=size(p_1);
w_3 = w_2';
w_4 = w_1';
a_10=logsig(w_1*p_1 + b_1);
a_20=(w_2*a_10 + b_3);
a_30=(w_3*a_20 + b_4);
a_40=logsig(w_4*a_30 + b_2);
e = p_1 - a_40;
%SENSITIVITIES

Fdot4=a_40.*(1-a_40);
Fdot1=a_10.*(1-a_10);
s_4=-2.*Fdot4.*(e);
s_3=w_1*s_4;
s_2=w_2*s_3;
s_1=Fdot1.*(w_2'*s_2);

%SUMMES

sum1_1=(s_1*p_1');
sum1_2=sum(s_1,2);

sum2_1=(s_2*a_10');
sum2_2=sum(s_2,2);

sum3_1 = (s_3*a_20');
sum3_2 = sum(s_3,2);

sum4_1 = (s_4*a_30');
sum4_2 = sum(s_4 , 2);


w_1=w_1 - (beta*sum1_1)/R;
b_1=b_1 - (beta*sum1_2)/R;


w_2=w_2 - (beta*sum2_1)/R;
b_3=b_3 - (beta*sum2_2)/R;


w_3 = w_3 - (beta*sum3_1)/R;
b_4 = b_4 - (beta*sum3_2)/R;


w_4 = w_4 - (beta*sum4_1)/R;
b_2 = b_2 - (beta*sum4_2)/R;

sum_e(i)=e'*e;

end

figure;
loglog(sum_e)


% clear 
% clc
% close all
%%%%%%%%%%%%%%%% This is a plotting part in matrix form to show the shape%%%%%%%%%%%%%%%%%%%%%%
% load data
% load data2
% load data3
p =reshape(p_1,20,20);
o =reshape(a_40,20,20);
figure('units','normalized','outerposition',[0 0 1 1])
mat = p;           %# A 5-by-5 matrix of random values from 0 to 1
imagesc(mat);            %# Create a colored plot of the matrix values
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                         %#   black and lower values are white)

textStrings = num2str(mat(:),'%0.4f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:20);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:5,...                         %# Change the axes tick marks
        'XTickLabel',{'A','B','C','D','E'},...  %#   and tick labels
        'YTick',1:5,...
        'YTickLabel',{'A','B','C','D','E'},...
        'TickLength',[0 0]);
    
figure('units','normalized','outerposition',[0 0 1 1])
mat = o;           %# A 5-by-5 matrix of random values from 0 to 1
imagesc(mat);            %# Create a colored plot of the matrix values
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                         %#   black and lower values are white)

textStrings = num2str(mat(:),'%0.4f');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:20);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:5,...                         %# Change the axes tick marks
        'XTickLabel',{'A','B','C','D','E'},...  %#   and tick labels
        'YTick',1:5,...
        'YTickLabel',{'A','B','C','D','E'},...
        'TickLength',[0 0]);
    
    
figure;                 %show the SSE
loglog(sum_e)