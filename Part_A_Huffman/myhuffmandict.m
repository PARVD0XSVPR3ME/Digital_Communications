function [dict,avglen] = myhuffmandict(symbols,p)
    sz=length(symbols);
    adj_sz = sz;
    %dimiourgia cell pou periexei symvola kai tis pithanothtes emfanishs toys
    symb_cell = cell(sz,5);
    for i=1:sz 
        symb_cell{i,1} = symbols{i};
        symb_cell{i,2} = p(i);
    end
    %diataksi simvolwn kata fthinousa seira pithanothtwn
    symb_cell = sortrows(symb_cell,2,'descend');
    %ylopoihsh Huffman 
    %dhladh gia ta 2 stoixeia me tis mikroteres pithanothtes ginetai sinenosh twn stoixiwn se ena neo me pithanothta 
    %to athroisma twn pithanothtwn twn 2 stoixeiwn ,to neo stoixeio apothikevetai sth thesh 1 tou neoy row pou dimiourgite
    %kai to p tou neou stoixiou sth thesh 2 tou neou row
    %episis dimiourgounte alla 2 collumns pou periexoun ta stoixeia apo ta opoia dimiourgithike to neo stoixeio
    for i = sz : -1 : 2
        adj_sz = adj_sz + 1 ;
        %xrisimopoihtai h sprintf anti ths apo katw wste na mhn xanontai ta newline kai 
        %ta backspace symvola
        %symb_cell{adj_sz,1} = strcat(symb_cell{i,1} , symb_cell{i-1,1});
        symb_cell{adj_sz,1} = sprintf('%s%s' ,symb_cell{i,1},symb_cell{i-1,1});
        symb_cell{adj_sz,2} = symb_cell{i,2} + symb_cell{i-1,2};
        symb_cell{adj_sz,3} = symb_cell{i,1};
        symb_cell{adj_sz,4} = symb_cell{i-1,1};
        symb_cell = sortrows(symb_cell,2,'descend');
    end
    %ginete anathesh kwdika se kathe stoixeio tou alfavitou
    %gia na diasxisoume to dentro huffman xrisimopoioume mia oura gia na krataei tous komvous pou episkeptomaste
    %ksekiname apo to stoixeio sth grammh 1 tou cell to opoio exei th megaliterh pithanothta
    queue = {};
    r=1;
    %mexri na episkeftoume ola ta stoixeia ths ouras 
    while ~isempty(r)
        l_child = symb_cell{r,4};
        r_child = symb_cell{r,3};
        if ~isempty(l_child) 
            %sth stilh 5 tou symvoloy apo to opoio proilthe to neo symvolo vazoume thn timh 0
            symb_cell{find(strcmp(symb_cell(:,1), l_child)),5} = [symb_cell{r,5} 0];
            %prosthetoume sthn oura th thesh toy symvolou apo to opoio proilthe to neo symvolo
            queue{end+1} = find(strcmp(symb_cell(:,1), l_child));
        end
        if ~isempty(r_child)
        %sth stilh 5 tou symvoloy apo to opoio proilthe to neo symvolo vazoume thn timh 1
            symb_cell{find(strcmp(symb_cell(:,1), r_child)),5} = [symb_cell{r,5} 1];
            %prosthetoume sthn oura th thesh toy symvolou apo to opoio proilthe to neo symvolo
            queue{end+1} = find(strcmp(symb_cell(:,1), r_child));
        end
        
        if length(queue) ~= 0
        %sto dikth r vazoume th thesh tou symvolou pou perimenei sthn oura 
            r = queue{1};
        else 
        %an exoume episkeftei ola ta stoixeia ths ouras aadiazoume to r
            r = [];
        end
        %aferoume to 1o stoixeio ths ouras
        queue = queue(2:end);
    end
    %taksinomish twn symvolwn analoga me to megethos tou symvolou
    [~,stringLength] = sort(cellfun(@length,symb_cell(:,1)),'ascend');
    symb_cell = symb_cell(stringLength,:);
    %kratame mono ta arxika symvola
    dict(:,1) = symb_cell(1:sz,1);
    dict(:,2) = symb_cell(1:sz,5);
    %alfavitikh taksinomish symvolwn
    dict = sortrows(dict,1,'ascend');
    %evresh mesou mikous kwdika
    avglen=0;
    for i = 1 : length(dict)
        avglen = avglen+numel(dict{i,2})*p(i);
    end
    
end 