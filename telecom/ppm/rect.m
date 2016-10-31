function y=rect(t)

y=zeros(size(t,1),size(t,2));

for ii=1:size(t,1)
    for jj=1:size(t,2)
        if -1/2<t(ii,jj) && 1/2>t(ii,jj)
            y(ii,jj)=1;
        end
    end
    
end
