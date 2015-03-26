function [dataL,dataR]=loadSections(filePath,varname,NumDown,NumUp)
   %function [dataL,dataR,timeStamp,deltaT]=loadSections(filePath,index,varname)
LibVer = LcmsMatlabDataReader('GetLibVersion');
disp(['Library version : ' LibVer]);
% LcmsMatlabDataReader('help');
%[FileName,FilePath] = uigetfile('*.fis','Select the LCMS FIS file');
 % filePath= 'D:\xyc\St_Louis_Metro_LCMS_1mm\LCMS';
dataL=[];
dataR=[];
timeStamp=[];
deltaT=[];
timeStamp={};
% 读取的五个fis文件，使用中间三个，最后一个贡献一个补齐的部分，高度为 185行
for I=NumDown:NumUp %% NumDown是文件读取的时候的编号的起始点
    %for I=1:length(index) 
   FileName = [filePath,'F_',num2str(int32(I),'%06d'),'.fis']; %  圣路易斯data
    %FileName = [filePath,'LcmsData_',num2str(int32(I),'%06d'),'.fis'];%  暑假data       
    %06d格式：（  %d 整数转成十进位%开始符 0是 "填空字元" 表示,如果长度不足时就用0来填满。6是 格式化后总长度。 ）   %[指定参数][标识符][宽度][.精度]指示符
    %06d的意思就是6个0加上这个index以及后缀名。不懂的话搜索 sprintf
    % Open fis file------------------------------------------------------------
    RdSectionId = LcmsMatlabDataReader('OpenRoadSection', FileName);
    % Get info-----------------------------------------------------------------
    RdSectionInfo = LcmsMatlabDataReader('GetRoadSectionInfo');
    SurveyInfo    = LcmsMatlabDataReader('GetSurveyInfo');
    RdSecList     = LcmsMatlabDataReader('GetSurveyRoadSectionList');
    [sLcmsSystemParam sLcmsSystemStatus sLcmsSystemInfo sLcmsSensorParam sLcmsSensorAcquiStatus] = LcmsMatlabDataReader('GetSystemData');
    
    if strcmp(upper(varname), 'INTDATA')
        % Get intensity data-------------------------------------------------------
        [L R] = LcmsMatlabDataReader('GetIntData');
    elseif strcmp(upper(varname), 'RNGDATA')
        
        % figure('Name','Intensity Data/Images');
        % subplot(1,2,1);
        % imshow(IntensityL, [0 255]); axis normal;
        % subplot(1,2,2);
        % imshow(IntensityR, [0 255]); axis normal;
        % Get Range data-----------------------------------------------------------
        [L R] = LcmsMatlabDataReader('GetRngIm');
    elseif strcmp(upper(varname), upper('RectifiedRngIm') )
        [L R] = LcmsMatlabDataReader('GetRectifiedRngIm');
    end
    % figure;
    % subplot(1,2,1);
    % imshow(RangeXL, []); axis normal;
    % subplot(1,2,2);
    % imshow(RangeXR, []); axis normal;
    % figure('Name','Range Data');
    % subplot(1,2,1);
    % imshow(RangeZL, []); axis normal;
    % subplot(1,2,2);
    % imshow(RangeZR, []); axis normal;
    
    %  Acces one profile in Range Data ----------------------------------------
    % figure('Name','Plot profile number 1000 in Left Range Data ');
    % plot(-RangeZL(1000,:));
    
    % Get time stamps----------------------------------------------------------
    %[TimeStampsL TimeStampsR] = LcmsMatlabDataReader('GetTimeStamps');
    % Need to close roadsection at the end
    LcmsMatlabDataReader('CloseRoadSection');
    
    
    dataL=[dataL;L]; 
    dataR=[dataR;R];
    %dt=( RdSectionInfo.dTimeBE_s(2)-RdSectionInfo.dTimeBE_s(1) )/ (length(TimeStampsL)-1);    
    %deltaT=[deltaT,dt];
    %ct=TimeStampsL-TimeStampsL(1);
    %t=[t;t(end)+dt+ct];  
   % timeStamp{I}=sLcmsSystemStatus.acSystemTimeAndDate;
   
end
%dt= 4.9769e-04;