I=cell(20);

for n=1:12
   
imageName=strcat(num2str(n),'.jpg');%批量读取图片
I{n}= imread(imageName);
end

% % % I{n}(5,5,1)

for n=1:12
% % % %pre prossing
imgau=fspecial('gaussian',[7,7],30);%%%%%%%参数值？
I{n}(:, :,1)=conv2(double(I{n}(:, :,1)),double(imgau),'same');
I{n}(:, :,2)=conv2(double(I{n}(:, :,2)),double(imgau),'same');
I{n}(:, :,3)=conv2(double(I{n}(:, :,3)),double(imgau),'same');%%%%%%%%gaussian smoothing
uint8(I{n});
end

% % % % imshow(I{n});
% % % % 
% % % % for m=1:256
% % % %     for k=1:256
% % % %         in(m,k)=0;
% % % %     end
% % % % end
% % % % 
J=cell(20);

n=1;
for n=1:12
    m=1;
   for i=1:10:1300
       k=1;
        for j=1:10:1300
        J{n}(m,k,1)=I{n}(i,j,1);%%%%%%subsampling
        J{n}(m,k,2)=I{n}(i,j,2);
        J{n}(m,k,3)=I{n}(i,j,3);
        k=k+1;
        end    
    m=m+1;
   end
end
imhist( J{n}(:,:,1))
% imshow(J{n});