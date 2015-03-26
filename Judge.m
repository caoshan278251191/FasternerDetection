function FailResult=Judge(ndata) %这个函数实现寻找第一个螺栓的位置，规则的判断螺栓的存在打下基础。并且判断了螺栓的存在，四个一排为一组，一组一组的判断

 newtemp=ndata(:,1:50);%第一列的螺栓的形心的X坐标为50
[L, n]=bwlabel(newtemp, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
Cen = cat(1, stats.Centroid); % regionprops Centroid 为标记出这个region的property， centroid为型心的property        cat(2, A, B)相当于[A, B];  cat(1, A, B)相当于[A; B].相当于把坐标叠罗汉
row1=round(min(Cen(:,2)));  %取到第一个object的形心，以这个坐标开始运算。  第二行的最小的一个数，打开cen矩阵，就会了解

%%
 newtemp=ndata(:,1900:2000);%第一列的螺栓的形心的X坐标为50
[L, n]=bwlabel(newtemp, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
Cen = cat(1, stats.Centroid); % regionprops Centroid 为标记出这个region的property， centroid为型心的property        cat(2, A, B)相当于[A, B];  cat(1, A, B)相当于[A; B].相当于把坐标叠罗汉
row2=round(min(Cen(:,2)));  %取到第一个object的形心，以这个坐标开始运算。  第二行的最小的一个数，打开cen矩阵，就会了解
row=abs(row1-row2);
[m,n] = size(ndata);
ndata1=[ndata((2001):(8000),1:1020),ndata(2001+row:8000+row,1021:n)];%为了取得完整的三幅图片，先取出5幅图片，错位row1行，这样可以补回左边比右边高出的那些行。

%%
ndata2=ndata1(:,1:50)+ndata1(:,1951:2000); %这个用于建立标准的判断区域，除非左右两边的螺栓同时掉落，才会影响标准，可能性很小
w=[15,15];
ndata2 = maxfilt2(ndata2,w);
[L1, n1]=bwlabel(ndata2, 4); 
stats = regionprops(L1);
Cen1 = cat(1, stats.Centroid);
Cen1=sort(Cen1(:,2))
ndata=ndata1;
i=length(Cen1);
%%
%开始判断第一行
n=0;  %清空n
template1=ndata(round(Cen1(1)):round(Cen1(1))+300,:);
w=[10,10];
template1= minfilt2(template1,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离
[L, n]=bwlabel(template1, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
n=int8(n);
%%
%写保护，防止全部传出2的时候，矩阵的特性会转换为1  [2 2 2 2]变成 [1 1 1 1]
FailResult(1)=3; %选择3是因为3是质数 不容易被约掉
%%
if n~=4 %判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(2)=1;
else
    FailResult(2)=2;
end


%row=row+764;
%%
%判断第二行
n=0;  %清空n
template2=ndata(round(Cen1(2))-300:round(Cen1(2)+300),:);
w=[20,20];
template2= minfilt2(template2,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离
[L, n]=bwlabel(template2, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
if n~=4 %判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(3)=1;
else
    FailResult(3)=2;
end

%%
%判断第三行
n=0;  %清空n
template3=ndata(round(Cen1(3))-300:round(Cen1(3)+300),:);
w=[20,20];
template3= minfilt2(template3,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离
[L, n]=bwlabel(template3, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(4)=1;
else
    FailResult(4)=2;
end
n=0;  %清空n
%%
%判断第四行
n=0;  %清空n
template4=ndata(round(Cen1(4))-300:round(Cen1(4)+300),:);
w=[20,20];
template4= minfilt2(template4,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离
[L, n]=bwlabel(template4, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
if n~=4 %判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(5)=1;
else
    FailResult(5)=2;
end
n=0;  %清空n
%%
%判断第五行
n=0;  %清空n
template5=ndata(round(Cen1(5))-300:round(Cen1(5)+300),:);
w=[20,20];
template5= minfilt2(template5,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
[L, n]=bwlabel(template5, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
    if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(6)=1;
else
    FailResult(6)=2;
end
%%
%判断第六行
n=0;  %清空n
template6=ndata(round(Cen1(6))-300:round(Cen1(6)+300),:);
w=[20,20];
template6= minfilt2(template6,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
[L, n]=bwlabel(template6, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(7)=1;
else
    FailResult(7)=2;
end


%%
%判断第七行
n=0;  %清空n
template7=ndata(round(Cen1(7))-300:round(Cen1(7)+300),:);
w=[20,20];
template7= minfilt2(template7,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
[L, n]=bwlabel(template7, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。
if n~=4 %判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(8)=1;
else
    FailResult(8)=2;
end



%%
%判断第八行
n=0;  %清空n
if Cen1(8)>5300% 如果这个螺栓的中心大于5500 那么接下来的500行里面不可能容得下下一组螺栓
FailResult(10)=3;    % 如果只有八行螺栓的话，记得把第九行保护起来，写成3
template8=ndata(round(Cen1(8))-300:6000,:);
w=[20,20];
template8= minfilt2(template8,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
[L, n]=bwlabel(template8, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。


if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
    FailResult(9)=1;
else
    FailResult(9)=2;
end

else % 这个说明有可能有第九组螺栓的存在
    if i==9 %双保险
        
    template8=ndata(round(Cen1(8))-300:round(Cen1(8))+300,:);
     n=0;  %清空n
     w=[20,20];
     template8= minfilt2(template8,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
     [L, n]=bwlabel(template8, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。


        if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
          FailResult(9)=1;
        else
         FailResult(9)=2;
        end
        %第九行判断
          template9=ndata(round(Cen1(8))+300:6000,:);
     n=0;  %清空n
     w=[20,20];
     template9= minfilt2(template9,w); %进行一次腐蚀  去除有可能存在的小的干扰点（速度不够的时候，可以去除）而且这样可以使得目标变小，减少超出设定范围的距离if n~=4 %判断这一行是不是有四个螺栓。是为1，不是为0
     [L, n]=bwlabel(template9, 4); %计算画面内螺栓的个数 n     bwlabel return the connected components in BW in n  其中的4表示四联通 还有八联通和16联通的存在。


        if n~=4%判断这一行是不是有四个螺栓。是为2，有螺栓缺失则为1
          FailResult(10)=1;
        else
         FailResult(10)=2;
        end
    end

end

FailResult(11)=3;
