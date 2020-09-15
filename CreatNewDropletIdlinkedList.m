function CreatNewDropletIdlinkedList(i,j)
global IdlinkedList
global Id
eval(['IdlinkedList(1).droplet',num2str(Id),'={{',num2str(i),',',num2str(j),'}};'])
end

