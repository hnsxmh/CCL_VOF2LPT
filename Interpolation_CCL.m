Threshold_alpha=0.005;
global Bins;
Bins=200;%20

A=importdata("data\alpha.liquid_slice005.raw",' ',3);
A=A.data;
y = A(:,2);
z = A(:,3);
v = A(:,4);

%[xq,yq] = meshgrid(-2*10^-5:0.01*10^-3:2*10^-3, -2*10^-3:0.01*10^-3:2*10^-3);
[xq,yq] = meshgrid(linspace(0,max(z),Bins+1), linspace(0,2*pi,Bins+1));
mesh(xq,yq,zeros(Bins+1,Bins+1))
%the value in centre of cell
xq      =xq+max(z)/Bins/2;
yq      =yq+2*pi/Bins/2;
X =  xq.*cos(yq);
X(end,:) = [];
X(:,end) = [];
Y =  xq.*sin(yq);
Y(end,:) = [];
Y(:,end) = [];
vq = griddata(y,z,v,X,Y);

% pcolor(X,Y,vq),shading interp, colorbar

% the interpolation to the cell
% [xq1,yq1] = meshgrid(linspace(0,max(z),Bins+1), linspace(0,2*pi,Bins+1));
% X1 =  xq1.*cos(yq1);
% Y1 =  xq1.*sin(yq1);
% mesh(X1,Y1,zeros(Bins+1))

for i=1:Bins
    for j=1:Bins
        if vq(i,j)<Threshold_alpha
            vq(i,j)=0;
        end
    end
end
%mesh(X,Y,vq)
%initial the alpha matrix with Threshold_alpha i.e if alpha<Threshold_alpha
%then it will be equal to 0


%CCL algorithmus

global CCL;
global Id; 
global IdlinkedList;
global NumOfId;
global MinId;


CCL=zeros(Bins);
Id=1;
IdlinkedList=struct([]);
for i=1:Bins
    for j=1:Bins
        if vq(i,j)~=0
            CalculateTheNumberOfAdjacentCellIdAndMinId(i,j)
            if NumOfId==0
                CreatNewDropletIdlinkedList(i,j)
                LabelCellWithNewId(i,j)
            elseif NumOfId==1
                CCL(i,j)=MinId;
                AddCellToMinimumDropletIdLinkedList(i,j)
            elseif NumOfId==2
                CCL(i,j)=MinId;
                AddCellToMinimumDropletIdLinkedList(i,j)
                ReidentifyAdjacentCellsWithMinId(i,j)
            end
        end
    end
end                
                
%             if j==1
%                 if CCL(i,mod(j,Bins)+1)==0 && CCL(mod(i,Bins)+1,j)==0 && CCL(mod(i-2,Bins)+1,j)==0
%                     CreatNewDropletIdlinkedList(i,j)
%                     LabelCellWithNewId(i,j)
%                 else
%                     C
%                     LinkedCell=[1,CCL(i,mod(j,Bins)+1),CCL(mod(i,Bins)+1,j),CCL(mod(i-2,Bins)+1,j)];
%                     CCL(i,j)=min(LinkedCell);
%                     AddCellToMinimumDropletIdLinkedList(i,j)
%                 end
%             elseif j==Bins
%                 if CCL(i,mod(j,Bins-2)+1)==0 && CCL(mod(i,Bins)+1,j)==0 && CCL(mod(i-2,Bins)+1,j)==0
%                     CreatNewDropletIdlinkedList(i,j)
%                     LabelCellWithNewId(i,j)
%                 else
%                     CCL(i,j)=min(CCL(i,mod(j,Bins-2)+1),CCL(mod(i,Bins)+1,j),CCL(mod(i-2,Bins)+1,j));
%                     AddCellToMinimumDropletIdLinkedList(i,j)
%                 end
%             else
%                 if CCL(i,mod(j,Bins)+1)==0 && CCL(i,mod(j,Bins-2)+1)==0 && CCL(mod(i,Bins)+1,j)==0 && CCL(mod(i-2,Bins)+1,j)==0
%                     CreatNewDropletIdlinkedList(i,j)
%                     LabelCellWithNewId(i,j)
%                 else
%                     CCL(i,j)=min(CCL(i,mod(j,Bins)+1),CCL(i,mod(j,Bins-2)+1),CCL(mod(i-2,Bins)+1,j));
%                     AddCellToMinimumDropletIdLinkedList(i,j)                    
%                 end
%             end
%         end
%     end
% end


%calculate the volume of each Cell
VCell=zeros(Bins);
for i=1:Bins
    for j=1:Bins
        VCell(:,j)=pi*max(z)*(2*j-1)/Bins^3;
    end
end


droplet={};
fields=fieldnames(IdlinkedList);
for k=1:length(fields)
    eval(['droplet',num2str(k),'=struct([]);']);
    eval(['droplet={droplet{:},droplet',num2str(k),'};']);
    clear (['droplet',num2str(k)])
end

for k=1:length(fields)
    V=[];
    for j=1:length(fields(k))
        tmp_i=eval(['IdlinkedList.',char(fields(k)),'{',num2str(j),'}{1}']);
        tmp_j=eval(['IdlinkedList.',char(fields(k)),'{',num2str(j),'}{2}']);
        tmp_V=VCell(tmp_i,tmp_j)*vq(tmp_i,tmp_j);
        V=[V tmp_V];
    end
    sumV=sum(V);
    eval(['droplet{',num2str(k),'}(1).V=',num2str(sumV),';']);    
end

x=[];
for k=1:length(fields)
    x=[x droplet{k}(1).V];
end

h = histogram(x)

            
            
            
        


