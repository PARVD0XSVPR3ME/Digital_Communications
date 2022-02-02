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
%dimiourgia tyxaias phghs me vash tis pithanothtes emfanishs kathe symvolou
%tou alfavitou 
out = randsrc(1,5000,[numbers; p]);
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
disp('Gia thn phgh A:');
fprintf('Mhkos kwdikopoihshs phghs : %.d \n', length(comp_a));
%apokwdikopoihsh phghs A
dsig_a = myhuffmandeco(comp_a, dict_a);
%elegxos an to shma pou apokwdikopoihthike einai to idio me to sima pou kwdikopoihthike 

if isequal(phgh_a,dsig_a)
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