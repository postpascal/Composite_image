
%%%%%%%%%%%%%%%%%%%%%source images read%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I=cell(1000);
J1=cell(1000);
J2=cell(1000);
J3=cell(1000);

file_path =  './source_image/';
img_path_list = dir(strcat(file_path,'*.jpg'));
img_num = length(img_path_list);
if img_num > 0
    for n= 1:img_num
        image_name = img_path_list(n).name;
        a=  imread(strcat(file_path,image_name));
        a=imresize(a,[20,20]);
%         a=gaussian(a);
        I{n}=a;
        J1{n}=comhist(a);
        J3=J1;
        fprintf('%d %s\n',n,strcat(file_path,image_name))
    end
end

%%%%%%%%%%%%%%%%%%%%% source images read %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% target image read %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tim=imread('mosaic_target1.jpg');
% figure(1)
% hold on
% imshow(tim)
tim=imresize(tim,[1100,1600]);

outImage = zeros(size(tim));
nRow = 55;
nCol =80;
r = round(linspace(1,size(outImage,1),nRow+1));
c = round(linspace(1,size(outImage,2),nCol+1));
m=1;
for rstar=1:55
    
    for cstar=1:80
        J2{m}=tim(r(rstar):r(rstar+1),c(cstar):c(cstar+1),:);
        jp=J2{m};
        J2{m}=comhist(jp);
        m=m+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%target image read%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% image copmare %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v=[];
tom= zeros(size(I{1}));
tom1=zeros(20,1600,3);
z=1;
y=0;
o=0;
for m=1:4400
    for n=1:1000
        f=J1{n};
        d=J2{m};
        v(m,n)=rgbsum(f,d);
    end
    
    s=v(m,:);
    s=nmmax(s);
    J1{s}=J1{s}-J1{s};
    o=o+1;
    if o>400
        J1=J3;
        o=0;
    end
    if max(tom(:))<2
        tom=I{s};
    else  tom=[tom I{s}];
    end
   
    y=y+1;
    if y>=80
        if max(tom1(:))<2
            tom1=tom;
        else  tom1=[tom1;tom];
        end
        
        tom=I{1}-I{1};
        y=0;
    end
end

tom1=imresize(tom1,[1100,1600]);
tom1=0.4.*tom1+0.6.*tim;
figure(1)
imshow(tom1);

%%%%%%%%%%%%%%%%%%%%%% image copmare %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%