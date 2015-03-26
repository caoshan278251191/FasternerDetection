function FailResult=Judge(ndata) %�������ʵ��Ѱ�ҵ�һ����˨��λ�ã�������ж���˨�Ĵ��ڴ��»����������ж�����˨�Ĵ��ڣ��ĸ�һ��Ϊһ�飬һ��һ����ж�

 newtemp=ndata(:,1:50);%��һ�е���˨�����ĵ�X����Ϊ50
[L, n]=bwlabel(newtemp, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
Cen = cat(1, stats.Centroid); % regionprops Centroid Ϊ��ǳ����region��property�� centroidΪ���ĵ�property        cat(2, A, B)�൱��[A, B];  cat(1, A, B)�൱��[A; B].�൱�ڰ�������޺�
row1=round(min(Cen(:,2)));  %ȡ����һ��object�����ģ���������꿪ʼ���㡣  �ڶ��е���С��һ��������cen���󣬾ͻ��˽�

%%
 newtemp=ndata(:,1900:2000);%��һ�е���˨�����ĵ�X����Ϊ50
[L, n]=bwlabel(newtemp, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
stats = regionprops(L);
%    CAT(2,A,B) is the same as [A,B].
%    CAT(1,A,B) is the same as [A;B].
Cen = cat(1, stats.Centroid); % regionprops Centroid Ϊ��ǳ����region��property�� centroidΪ���ĵ�property        cat(2, A, B)�൱��[A, B];  cat(1, A, B)�൱��[A; B].�൱�ڰ�������޺�
row2=round(min(Cen(:,2)));  %ȡ����һ��object�����ģ���������꿪ʼ���㡣  �ڶ��е���С��һ��������cen���󣬾ͻ��˽�
row=abs(row1-row2);
[m,n] = size(ndata);
ndata1=[ndata((2001):(8000),1:1020),ndata(2001+row:8000+row,1021:n)];%Ϊ��ȡ������������ͼƬ����ȡ��5��ͼƬ����λrow1�У��������Բ�����߱��ұ߸߳�����Щ�С�

%%
ndata2=ndata1(:,1:50)+ndata1(:,1951:2000); %������ڽ�����׼���ж����򣬳����������ߵ���˨ͬʱ���䣬�Ż�Ӱ���׼�������Ժ�С
w=[15,15];
ndata2 = maxfilt2(ndata2,w);
[L1, n1]=bwlabel(ndata2, 4); 
stats = regionprops(L1);
Cen1 = cat(1, stats.Centroid);
Cen1=sort(Cen1(:,2))
ndata=ndata1;
i=length(Cen1);
%%
%��ʼ�жϵ�һ��
n=0;  %���n
template1=ndata(round(Cen1(1)):round(Cen1(1))+300,:);
w=[10,10];
template1= minfilt2(template1,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���
[L, n]=bwlabel(template1, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
n=int8(n);
%%
%д��������ֹȫ������2��ʱ�򣬾�������Ի�ת��Ϊ1  [2 2 2 2]��� [1 1 1 1]
FailResult(1)=3; %ѡ��3����Ϊ3������ �����ױ�Լ��
%%
if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(2)=1;
else
    FailResult(2)=2;
end


%row=row+764;
%%
%�жϵڶ���
n=0;  %���n
template2=ndata(round(Cen1(2))-300:round(Cen1(2)+300),:);
w=[20,20];
template2= minfilt2(template2,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���
[L, n]=bwlabel(template2, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(3)=1;
else
    FailResult(3)=2;
end

%%
%�жϵ�����
n=0;  %���n
template3=ndata(round(Cen1(3))-300:round(Cen1(3)+300),:);
w=[20,20];
template3= minfilt2(template3,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���
[L, n]=bwlabel(template3, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(4)=1;
else
    FailResult(4)=2;
end
n=0;  %���n
%%
%�жϵ�����
n=0;  %���n
template4=ndata(round(Cen1(4))-300:round(Cen1(4)+300),:);
w=[20,20];
template4= minfilt2(template4,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���
[L, n]=bwlabel(template4, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(5)=1;
else
    FailResult(5)=2;
end
n=0;  %���n
%%
%�жϵ�����
n=0;  %���n
template5=ndata(round(Cen1(5))-300:round(Cen1(5)+300),:);
w=[20,20];
template5= minfilt2(template5,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
[L, n]=bwlabel(template5, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
    if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(6)=1;
else
    FailResult(6)=2;
end
%%
%�жϵ�����
n=0;  %���n
template6=ndata(round(Cen1(6))-300:round(Cen1(6)+300),:);
w=[20,20];
template6= minfilt2(template6,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
[L, n]=bwlabel(template6, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(7)=1;
else
    FailResult(7)=2;
end


%%
%�жϵ�����
n=0;  %���n
template7=ndata(round(Cen1(7))-300:round(Cen1(7)+300),:);
w=[20,20];
template7= minfilt2(template7,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
[L, n]=bwlabel(template7, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�
if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(8)=1;
else
    FailResult(8)=2;
end



%%
%�жϵڰ���
n=0;  %���n
if Cen1(8)>5300% ��������˨�����Ĵ���5500 ��ô��������500�����治�����ݵ�����һ����˨
FailResult(10)=3;    % ���ֻ�а�����˨�Ļ����ǵðѵھ��б���������д��3
template8=ndata(round(Cen1(8))-300:6000,:);
w=[20,20];
template8= minfilt2(template8,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
[L, n]=bwlabel(template8, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�


if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
    FailResult(9)=1;
else
    FailResult(9)=2;
end

else % ���˵���п����еھ�����˨�Ĵ���
    if i==9 %˫����
        
    template8=ndata(round(Cen1(8))-300:round(Cen1(8))+300,:);
     n=0;  %���n
     w=[20,20];
     template8= minfilt2(template8,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
     [L, n]=bwlabel(template8, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�


        if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
          FailResult(9)=1;
        else
         FailResult(9)=2;
        end
        %�ھ����ж�
          template9=ndata(round(Cen1(8))+300:6000,:);
     n=0;  %���n
     w=[20,20];
     template9= minfilt2(template9,w); %����һ�θ�ʴ  ȥ���п��ܴ��ڵ�С�ĸ��ŵ㣨�ٶȲ�����ʱ�򣬿���ȥ����������������ʹ��Ŀ���С�����ٳ����趨��Χ�ľ���if n~=4 %�ж���һ���ǲ������ĸ���˨����Ϊ1������Ϊ0
     [L, n]=bwlabel(template9, 4); %���㻭������˨�ĸ��� n     bwlabel return the connected components in BW in n  ���е�4��ʾ����ͨ ���а���ͨ��16��ͨ�Ĵ��ڡ�


        if n~=4%�ж���һ���ǲ������ĸ���˨����Ϊ2������˨ȱʧ��Ϊ1
          FailResult(10)=1;
        else
         FailResult(10)=2;
        end
    end

end

FailResult(11)=3;
