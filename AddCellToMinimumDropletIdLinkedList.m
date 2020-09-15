function AddCellToMinimumDropletIdLinkedList(i,j)
global CCL
global IdlinkedList

eval(['IdlinkedList.droplet',num2str(CCL(i,j)),'=[','IdlinkedList.droplet',num2str(CCL(i,j)),...
    ',{{',num2str(i),',',num2str(j),'}}];']);

% eval(['IdlinkedList(1).droplet',num2str(Id),'={{',num2str(i),',',num2str(j),'}}']);
% a=[a,{{1,3}}]
end