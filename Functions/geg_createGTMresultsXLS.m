function geg_createGTMresultsXLS()
% This function joints all the PVC*_labels.txt files of all subjects into a
% xls table. Useful for posterior analyses.
%_______________________________________________________________________
%
% Gabriel Gonzalez-Escamilla

ResFiles  = spm_select([1,Inf],'^pvc.*\.txt','Select subjects results files');
oname = 'GTMresults_allsubjs.xls';
[pth,~,~] = spm_fileparts(ResFiles(1,:));
outname = fullfile([pth,filesep,oname]);
T = importdata(ResFiles(1,:));
colhdrs = T.colheaders;
rdata = zeros(size(ResFiles,1),size(colhdrs,2));
snms = cell(size(ResFiles,1),1);
for i=1:size(ResFiles,1)
    act_txt = ResFiles(i,:);
    T = importdata(act_txt);    
    rdata(i,:) = T.data; 
    [~,nam,~] = spm_fileparts(act_txt);
    snms(i,1) = {nam(4:end-7)};
end
xlswrite(outname,{'subjID'},'GTMres','A1')
xlswrite(outname,snms,'GTMres','A2')
xlswrite(outname,colhdrs,'GTMres','B1')
xlswrite(outname,rdata,'GTMres','B2')

disp('Done')