function CalculateTheNumberOfAdjacentCellIdAndMinId(i,j)
global NumOfId
global MinId
global CCL
global Bins

NumOfId=0;

if j==1
    if CCL(mod(i-2,Bins)+1,j)~=0
        NumOfId=1;
        MinId=CCL(mod(i-2,Bins)+1,j);
    end
else
    if CCL(i,mod(j-2,Bins)+1)~=0
        NumOfId=1;
        MinId=CCL(i,mod(j-2,Bins)+1);
        if CCL(mod(i-2,Bins)+1,j)~=0 && CCL(mod(i-2,Bins)+1,j)~=CCL(i,mod(j-2,Bins)+1)
            NumOfId=2;
            MinId=min([CCL(i,mod(j-2,Bins)+1),CCL(mod(i-2,Bins)+1,j)]);
        end
    elseif CCL(mod(i-2,Bins)+1,j)~=0
        NumOfId=1;
        MinId=CCL(mod(i-2,Bins)+1,j);
    else
        return
    end
end
