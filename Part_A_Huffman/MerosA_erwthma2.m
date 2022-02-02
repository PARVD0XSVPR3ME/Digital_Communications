clear
clc
%dimiourgia alfavitou
symbols = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'};
%dimiourgia pinaka me arithmous pou antistoixoun sto kathe gramma tou
%alfavitou
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26];
%oi pithanothtes pou antistoixoun se kathe symvolo tou alfavitou
p = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02361, 0.00150, 0.01974, 0.00074];
%dimiourgia tyxaias phghs me vash tis pithanothtes emfanishs kathe symvolou
%tou alfavitou
out = randsrc(1,10000,[numbers; p]);
phgh_a = {};
for i =1:length(out)
    phgh_a{i} = symbols{out(i)};
end
disp('H phgh dimiourgithike');

%dimiourgia dictionary pou antistoixei ta symvola tou alfavitou me tis
%antistoixes pithanothtes se kwdika Huffman
[dict_a,avglen_a] = myhuffmandict(symbols,p);
disp('To leksiko Huffman dimiourgithike');
%kwdikopoihsh Huffman toy simatos ths pighs A
comp_a = myhuffmanenco(phgh_a, dict_a);
fprintf('\n');
disp('Gia thn phgh A:');
fprintf('Mhkos kwdikopoihshs phghs : %d \n', length(comp_a));
%apokwdikopoihsh phghs A
dsig_a = myhuffmandeco(comp_a, dict_a);
%elegxos an to shma pou apokwdikopoihthike einai to idio me to sima pou kwdikopoihthike 

if isequal(phgh_a,dsig_a)
    disp('Ta simata einai idia');
else 
    disp('Ta simata DEN einai idia');
end
fprintf('To Meso Mhkos Kwdika einai : %.4f \n', avglen_a);
%diavazoume to arxeio kai kratame mono ta stoixeia pou anikoun sto alfavito me vash tis pithanothtes ths pighs A
file_txt = lower(regexprep(fileread('kwords.txt'),'[^a-zA-Z]',''));
%metatroph se alphanumeric cell array
file_txt_cell = {};
for i=1:length(file_txt)
    file_txt_cell{length(file_txt_cell)+1} = file_txt(i);
end
%kwdikopoihsh Huffman toy simatos ths pighs B
comp_b = myhuffmanenco(file_txt_cell, dict_a);
fprintf('\n');
disp('Gia thn phgh B:');
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

fprintf('\nH apodotikotita tou kwdika einai : %.4f \n', entropia./avglen_a);

