function dsig = myhuffmandeco(comp,dict) 
dsig = {};
c2= 1;
c1 = 1;
%ginetai apokwdikopoihsh ths kwdikopoihmens diadikhs akolouthias wste na metatrapei sto arxiko keimeno 
%antistoixizontas ton kwdika tou kathe symvolou sto antistoixo symvolo
while c2 < length(comp)
    flag = 0 ;
    while 1       
        for i = 1:length(dict)
            if isequal(comp(c1:c2) , dict{i,2})
                dsig{length(dsig)+1} = dict{i,1};
                flag = 1 ;
                break
            end
        end
        c2 = c2 + 1;
        if flag == 1
            break
        end
    end
    c1 = c2;
end
end

