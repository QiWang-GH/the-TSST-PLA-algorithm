clear
clc
load('..\train\nist\channel_feature_data.mat');
loc=1;
t=1;
% request verification
% ...
sfilename2='..\train\nist\BT_1v1_Models';
LOC_B=zeros(1,120);
% data is channel feature data
test_frame=data(t,3:6);
for i=1:120
    if i==loc
        LOC_B(i)=loc;
        continue
    end
sfilename4=strcat('\BT_Model', num2str(loc), '-', num2str(i), '.mat');
load(strcat(sfilename2,sfilename4));
LOC_B(i)=predict(B_tree,test_frame)-12;
end

% voting
labels=tabulate(LOC_B);
[m,idx]=max(labels(:,3));
id_v=idx;
% model bias tolrating coding
d1min=7.5;
loc_B=LOC_B;
    code1=loc_B-loc;
    code=zeros(1,120);
    for j=1:120
        if code1(j)==0
            code(j)=0;
        elseif  code1(j)==1
            code(j)=1;
        elseif  code1(j)==-1
            code(j)=-1;
        else
            code(j)=2;
        end
    end
        d1=norm(code,1);
    if d1<d1min
        id_c=loc;
    else
        id_c=-120;
    end        
