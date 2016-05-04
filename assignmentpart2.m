
%Read Source nature Learning images and calculate feature values
natureDir = 'natural_training\';
srcFiles = dir(fullfile(natureDir,'*jpg'));  % the folder in which ur images exists with the filending
Inature2=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(natureDir,srcFiles(i).name);
    a = imread(filename);
    Inature2{i}=  calfeature(a);
    i
    
end
%REad Source manmade learning images
manmadeDir = 'manmade_training\';
srcFiles = dir(fullfile(manmadeDir,'*jpg'));  % the folder in which ur images exists with the filending
Imanmade2=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(manmadeDir,srcFiles(i).name);
    a = imread(filename);
    Imanmade2{i}=  calfeature(a);
    i
    
    
end

%READ Targetset Images 
targetDir = 'natural_test\';
srcFiles = dir(fullfile(targetDir,'*jpg'));  % the folder in which ur images exists with the filending
I2=cell(length(srcFiles),1);
for i = 1 : length(srcFiles)
    filename = strcat(targetDir,srcFiles(i).name);
    a = imread(filename);
    I2{i}=  calfeature(a);
    i
    
end

%normalize all feature entries

Inature = cell2mat(Inature2);
Imanmade = cell2mat(Imanmade2);
I = cell2mat(I2);
[m,col] = size(Inature);

for i = 1: col
       temp = max([max(Inature(:,i)),max(I(:,i)),max(Imanmade(:,i))]);
       Inature(:,i) =  Inature(:,i) ./ temp;
       I(:,i) = I(:,i) ./ temp;
      Imanmade(:,i) = Imanmade(:,i) ./ temp;
end




%For each Image calculate nearest neighbor and set the label to the same

   manNumber = 0;
   natureNumber = 0;
   [m1,n1] = size(I);
for i = 1 : m1
   natDist = inf;
   manDist = inf;
   
   [m2,n2] = size(Inature);
   for j = 1 : m2
       tempDist = 0;
       for k =1 :n2
           tempDist = tempDist +(I(i,k)-Inature(j,k))^2;
       end
      tempDist = sqrt(tempDist);
      if tempDist < natDist
          natDist = tempDist;
      end
   end
   [m3,n3] = size(Imanmade);
   for j = 1 : m3
     tempDist = 0;
       for k =1 :n3
           tempDist = tempDist +(I(i,k)-Imanmade(j,k))^2;
       end
      tempDist = sqrt(tempDist);
      if tempDist < manDist
          manDist = tempDist;
      end
   end
  
  
   if natDist < manDist
       fprintf('image %i is considered a nature image\n',i)
       natureNumber = natureNumber +1;
   end
   if natDist > manDist
       fprintf('image %i is considered a manmade image\n',i)
       manNumber = manNumber +1;
   end
    
end

    fprintf('number of nature images: %i\n',natureNumber)
    fprintf('number of manmade image %i\n',manNumber)


