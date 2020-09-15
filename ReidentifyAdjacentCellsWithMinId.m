function ReidentifyAdjacentCellsWithMinId(i,j)
global CCL
global IdlinkedList
global MinId
global Bins
if CCL(i,mod(j-2,Bins)+1) > MinId
    for k=1:length(eval(['IdlinkedList.droplet',num2str(CCL(i,mod(j-2,Bins)+1))]))
        eval(['IdlinkedList.droplet',num2str(MinId),'=[','IdlinkedList.droplet',num2str(MinId),...
            ',{','IdlinkedList.droplet',num2str(CCL(i,mod(j-2,Bins)+1)),'{',num2str(k),'}}];']);
    end
    %add the element in cell with other Ids into MinId cell {}
    IdlinkedList = rmfield(IdlinkedList,['droplet',num2str(CCL(i,mod(j-2,Bins)+1))]);
    %delete the field in struct with the name droplet "CCL(i,mod(j-2,Bins)"
end

if CCL(mod(i-2,Bins)+1,j)>MinId
    for k=1:length(eval(['IdlinkedList.droplet',num2str(CCL(mod(i-2,Bins)+1,j))]))
        eval(['IdlinkedList.droplet',num2str(MinId),'=[','IdlinkedList.droplet',num2str(MinId),...
            ',{','IdlinkedList.droplet',num2str(CCL(mod(i-2,Bins)+1,j)),'{',num2str(k),'}}];']);
    end
    IdlinkedList = rmfield(IdlinkedList,['droplet',num2str(CCL(mod(i-2,Bins)+1,j))]);
end

for k=1:length(eval(['IdlinkedList.droplet',num2str(MinId)]))
    CCL(eval(['IdlinkedList.droplet',num2str(MinId),'{',num2str(k),'}','{',num2str(1),'}']),...
        eval(['IdlinkedList.droplet',num2str(MinId),'{',num2str(k),'}','{',num2str(2),'}']))=MinId;
end
    

end
