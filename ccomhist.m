
function y= ccomhist(a)
y(1,:)=imhist(a(:,:,1));
y(2,:)=imhist(a(:,:,2));
y(3,:)=imhist(a(:,:,3));
% y(y<0)=0;
% 
% for n=1:3
%     z=1;
%   for f=1:32
%        s=0;
%       for m=1:8
%        s=s+y(n,z);
%        z=z+1;
%       end
%     x(n,f)=s;
%   end
% 
% end
% 
% x=x-10;
% x(x<0)=0;
