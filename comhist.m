
function x= comhist(a)

y(1,:)=imhist(a(:,:,1)+1);
y(2,:)=imhist(a(:,:,2)+1);
y(3,:)=imhist(a(:,:,3)+1);
y(y<0)=0;

for n=1:3
    z=1;
  for f=1:15
       s=0;
      for m=1:17
       s=s+y(n,z);
       z=z+1;
      end
    x(n,f)=s;
  end

end
x(1,5)=y(1,256)+x(1,5);
x(2,5)=y(2,256)+x(2,5);
x(3,5)=y(3,256)+x(3,5);
x=x-10;
x(x<0)=0;
