function comp = myhuffmanenco(sig, dict) 
comp = [];
%ginetai elegxos gia to an to sima einai cell h vector kai epita dimiourgitai h kwdikopoihmenh diadikh akolouthia eksodou
%analoga me ton kwdika pou antistoixei sto kathe symvolo tou alfavitou
if iscell(sig)
    for i=1:length(sig)
        for j=1:length(dict)
            if strcmp(sig{i},dict{j,1})
                comp=[ comp , cell2mat(dict(j,2)) ];
            end
        end
    end
else
    for i=1:length(sig)
        comp=[ comp , cell2mat(dict(find(cell2mat(dict(:,1))==sig(i)),2)) ];
    end
end
end