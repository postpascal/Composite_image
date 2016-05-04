

%Read Source nature Learning images and calculate feature values
natureDir = './natural_training/';
srcFiles = dir(fullfile(natureDir,'*jpg'));  % the folder in which ur images exists with the filending
Inature=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(natureDir,srcFiles(i).name);
    a = imread(filename);
    Inature{i}=  calfeature(a);
end
%REad Source manmade learning images
manmadeDir = './manmade_training/';
srcFiles = dir(fullfile(manmadeDir,'*jpg'));  % the folder in which ur images exists with the filending
Imanmade=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(manmadeDir,srcFiles(i).name);
    a = imread(filename);
    Imanmade{i}=  calfeature(a);
    
    
end

%READ Target Images 
targetDir = './natural_test/';
srcFiles = dir(fullfile(targetDir,'*jpg'));  % the folder in which ur images exists with the filending
I=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(targetDir,srcFiles(i).name);
    a = imread(filename);
    I{i}=  calfeature(a);
    
end

%normalize all feature entries

Inature = cell2mat(Inature);
Imanmade = cell2mat(Imanmade);
I = cell2mat(I);
[m,col] = size(Inature);

for i = 1: col
       temp = max([max(Inature(:,i)),max(I(:,i)),max(Imanmade(:,i))])
       Inature(:,i) ./ temp;
       I(:,i) ./ temp;
       Imanmade(:,i) ./ temp;
end




%For each Image calculate nearest neighbor and set the label to the same

   manNumber = 0;
   natureNumber = 0;
   [m1,n1] = size(I);
for i = 1 : m1
   natDist1 = inf;
   natDist2 = inf;
   manDist1 = inf;
   manDist2 = inf;
   
   [m2,n2] = size(Inature);
   for j = 1 : m2
       tempDist = 0;
       for k =1 :n2
           tempDist = tempDist +(I(i,k)-Inature(j,k))^2;
       end
      tempDist = sqrt(tempDist);
      if tempDist < natDist2
          if tempDist < natDist1
              t=natDist1;
              natDist1=tempDist;
              natDist2=t;                       
          else natDist1 = tempDist;
          end       
      end
   end
   [m3,n3] = size(Imanmade);
   for j = 1 : m3
     tempDist = 0;
       for k =1 :n3
           tempDist = tempDist +(I(i,k)-Imanmade(j,k))^2;
       end
      tempDist = sqrt(tempDist);
      if tempDist < manDist2
          if tempDist < manDist1
              t=manDist1;
              manDist1=tempDist;
              manDist2=t;                       
          else manDist2 = tempDist;
          end
      end
   end
  
   mf=[natDist1 natDist2 manDist1 manDist2];
   mminl=find(mf==max(mf));
   
   if mminl>2
       fprintf('image %i is considered a nature image\n',i)
       natureNumber = natureNumber +1;
   else
       fprintf('image %i is considered a manmade image\n',i)
       manNumber = manNumber +1;
   end
    
end

    fprintf('number of nature images: %i\n',natureNumber)
    fprintf('number of manmade image %i\n',manNumber)


