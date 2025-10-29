% Task 5.2.10 (Matrix S of any size)
size=5;
S=zeros(size);

for i=1:size
    S(i,(size-i+1))=1;
end

% Task 5.2.11 (Verify that S=S^-1)

Sinv=inv(S);
if S==Sinv
    disp('S=S^-1')
else
    disp('S=/=S^-1')
end