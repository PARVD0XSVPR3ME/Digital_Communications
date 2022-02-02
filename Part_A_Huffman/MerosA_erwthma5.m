clear
clc
%grammata alfavitou
alphabet = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
%oi pithanothtes pou antistoixoun se kathe symvolo tou alfavitou
p_alphabet = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02361, 0.00150, 0.01974, 0.00074];

%ypologismos alfavitou 2hs takshs epektashs phghs kai pithanothtwn symvolwn ths
symbols = {};
p=[];
for i=1:length(alphabet)
    for j=1:length(alphabet)
        symbols{length(symbols)+1} = strcat(alphabet{1,i} , alphabet{1,j});
        p = [p p_alphabet(1,i)*p_alphabet(1,j)];
    end
end
%dimiourgia pinaka me arithmous pou antistoixoun sto kathe gramma tou
%alfavitou
numbers = [1:length(symbols)];

disp('Gia thn phgh B kwdikopoiontas me to alfavito ths A:');
%dimiourgia dictionary pou antistoixei ta symvola tou alfavitou me tis
%antistoixes pithanothtes se kwdika Huffman
[dict_a,avglen_a] = myhuffmandict(symbols,p);
disp('To leksiko Huffman dimiourgithike');
%diavazoume to arxeio kai kratame mono ta stoixeia pou anikoun sto alfavito me vash tis pithanothtes ths pighs A
file_txt = lower(regexprep(fileread('kwords.txt'),'[^a-zA-Z]',''));
%metatroph se alphanumeric cell array
file_txt_cell = {};
for i=1:length(dict_a{1,1}):length(file_txt)
    file_txt_cell{length(file_txt_cell)+1} = file_txt(i:(i+length(dict_a{1,1})-1));
end
%kwdikopoihsh Huffman toy simatos ths pighs B
comp_b = myhuffmanenco(file_txt_cell, dict_a);

fprintf('Mhkos kwdikopoihshs phghs : %d \n', length(comp_b));
%apokwdikopoihsh phghs A
dsig_b = myhuffmandeco(comp_b, dict_a);
%elegxos an to shma pou apokwdikopoihthike einai to idio me to sima pou kwdikopoihthike 

if isequal(file_txt_cell,dsig_b)
    disp('Ta simata einai idia');
else 
    disp('Ta simata DEN einai idia');
end
fprintf('To Meso Mhkos Kwdika einai : %.4f \n', avglen_a);
%ypologismos entropias 
entropia=0;
for i=1:length(p)
    entropia=entropia+p(i)*log2(1./p(i));
end

fprintf('H apodotikotita tou kwdika einai : %.4f \n', entropia./avglen_a);
%topothetountai ta periexomena tou arxeiou se mia metablhth
file_txt_2 = fileread('kwords.txt');
%dimiourgia alfavitou
getsymbols = unique(file_txt_2);
symbols_2={};
for i=1 :length(getsymbols)
    symbols_2{length(symbols_2)+1} = getsymbols(i);
end
%eyresh pithanothtwn emfanishs kathe symvolou
p_2=[];
for i=1:length(symbols_2)
    p_2 = [p_2, count(file_txt_2,symbols_2{i})/length(file_txt_2)];
end
symbols2 = {};
p2=[];
for i=1:length(symbols_2)
    for j=1:length(symbols_2)
        symbols2{length(symbols2)+1} = sprintf('%s%s' ,symbols_2{1,i} , symbols_2{1,j});
        p2 = [p2 p_2(1,i)*p_2(1,j)];
    end
end
fprintf('\n');
disp('Gia thn phgh B kwdikopoiontas me to alfavito ths B:');
%dimiourgia dictionary pou antistoixei ta symvola tou alfavitou me tis
%antistoixes pithanothtes se kwdika Huffman
[dict_b,avglen_b] = myhuffmandict(symbols2,p2);
disp('To leksiko Huffman dimiourgithike');
%metatroph se alphanumeric cell array
file_txt_cell_2 = {};
for i=1:length(dict_b{1,1}):length(file_txt_2)
    file_txt_cell_2{length(file_txt_cell_2)+1} = file_txt_2(i:(i+length(dict_b{1,1})-1));
end
%kwdikopoihsh Huffman toy simatos ths pighs B
comp_b_2 = myhuffmanenco(file_txt_cell_2, dict_b);

fprintf('Mhkos kwdikopoihshs phghs : %d \n', length(comp_b_2));
%apokwdikopoihsh phghs B
dsig_b_2 = myhuffmandeco(comp_b_2, dict_b);
%elegxos an to shma pou apokwdikopoihthike einai to idio me to sima pou kwdikopoihthike 

if isequal(file_txt_cell_2,dsig_b_2)
    disp('Ta simata einai idia');
else 
    disp('Ta simata DEN einai idia');
end
fprintf('To Meso Mhkos Kwdika einai : %.4f \n', avglen_b);
%ypologismos entropias 
entropia2=0;
for i=1:length(p2)
    entropia2=entropia2+p2(i)*log2(1./p2(i));
end

fprintf('H apodotikotita tou kwdika einai : %.4f \n', entropia./avglen_b);

