clear
clc
%topothetountai ta periexomena tou arxeiou se mia metablhth
file_txt = fileread('kwords.txt');
%dimiourgia alfavitou
getsymbols = unique(file_txt);
symbols={};
for i=1 :length(getsymbols)
    symbols{length(symbols)+1} = getsymbols(i);
end

%eyresh pithanothtwn emfanishs kathe symvolou
p=[];
for i=1:length(symbols)
    p = [p, count(file_txt,symbols{i})/length(file_txt)];
end
%metatroph se alphanumeric cell array
file_txt_cell = {};
for i=1:length(file_txt)
    file_txt_cell{length(file_txt_cell)+1} = file_txt(i);
end
%dimiourgia dictionary pou antistoixei ta symvola tou alfavitou me tis
%antistoixes pithanothtes se kwdika Huffman
[dict_b,avglen_b] = myhuffmandict(symbols,p);
disp('To leksiko Huffman dimiourgithike');
%kwdikopoihsh Huffman toy simatos ths pighs B
comp_b = myhuffmanenco(file_txt_cell, dict_b);
disp('Gia thn phgh B:');
fprintf('Mhkos kwdikopoihshs phghs : %d \n', length(comp_b));
%apokwdikopoihsh phghs B
dsig_b = myhuffmandeco(comp_b, dict_b);
%elegxos an to shma pou apokwdikopoihthike einai to idio me to sima pou kwdikopoihthike 

if isequal(file_txt_cell,dsig_b)
    disp('Ta simata einai idia');
else 
    disp('Ta simata DEN einai idia');
end
fprintf('To Meso Mhkos Kwdika einai : %.4f \n', avglen_b);
%ypologismos entropias 
entropia=0;
for i=1:length(p)
    entropia=entropia+p(i)*log2(1./p(i));
end

fprintf('H apodotikotita tou kwdika einai : %.4f \n', entropia./avglen_b);