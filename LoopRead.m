function [LoopData]= LoopRead(filePath,varname,NumDown,NumUp)
LibVer = LcmsMatlabDataReader('GetLibVersion');
disp(['Library version : ' LibVer]);
LoopData=[];% ��ȡ�����fis�ļ���ʹ���м����������һ������һ������Ĳ��֣��߶�Ϊ 185��
for I=NumDown:NumUp %% NumDown���ļ���ȡ��ʱ��ı�ŵ���ʼ��
    %for I=1:length(index) 
  % FileName = [filePath,'F_',num2str(index(I),'%06d'),'.fis']; %  ʥ·��˹data
    FileName = [filePath,'LcmsData_',num2str(int32(I),'%06d'),'.fis'];%  ���data       
    %06d��ʽ����  %d ����ת��ʮ��λ%��ʼ�� 0�� "�����Ԫ" ��ʾ,������Ȳ���ʱ����0��������6�� ��ʽ�����ܳ��ȡ� ��   %[ָ������][��ʶ��][���][.����]ָʾ��
    %06d����˼����6��0�������index�Լ���׺���������Ļ����� sprintf
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
    LcmsMatlabDataReader('CloseRoadSection');
    
    
    dataL=[dataL;L]; 
    dataR=[dataR;R];
    %dt=( RdSectionInfo.dTimeBE_s(2)-RdSectionInfo.dTimeBE_s(1) )/ (length(TimeStampsL)-1);    
    %deltaT=[deltaT,dt];
    %ct=TimeStampsL-TimeStampsL(1);
    %t=[t;t(end)+dt+ct];  
   % timeStamp{I}=sLcmsSystemStatus.acSystemTimeAndDate;
   
end