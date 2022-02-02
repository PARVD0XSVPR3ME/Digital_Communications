function  y_hat  = my_quantizer(y,N,min_value,max_value)
    %o kvantisths periorizei th dinamikh perioxh tou sfalmatos 
    %provlepshs stis times [min_value:max_value] thettontas ta deigmata 
    %pou vriskontai ektos ths dinamikhs perioxhs sthn akrea apodekth timh 
    for i=1:length(y)
        if y(i)<min_value
            y(i) = min_value;
        elseif y(i)>max_value
            y(i) = max_value;
        end
    end
    %ypologismos tou vimatos kvantismou D
    D = (max_value - min_value) / (2^N) ;
    %ypologismos twn kentrwn kathe perioxhs
    centers(1) = max_value - D/2;
    centers(2^N) = min_value + D/2;
    for i = 2:(2^N-1)
        centers(i) = centers(i-1)-D;
    end
    %ginetai ypologismos tou kwdikopoihmenou shmatos  me vash thn perioxh
    %pou anhkei to deigma eisodou
    y_hat(1:length(y)) = zeros(); 
    for i=1:length(y)
        for j=1:2^N
            %ginetai elegxos gia ton an to deigma eisodou y(i) anikei sthn perioxh
            % (centers(i) - D/2 , centers(i)+D/2] opou to katw akro einai anoixto
            %kai to anw akro kleisto 
            if ((centers(j)-(D/2)) < y(i)) && (y(i) <= (centers(j)+(D/2))) 
                %kai sto kwdikopoihmeno shma dinetai h thesh ston pinaka centers 
                %tou kentrou pou antistoixei sto sigekrimeno deigma eisodou
                y_hat(i) = j;
            end
        end 
        %ektws an isoute me thn timh min_value 
        if y(i) == min_value;
            %opote tote dinetai sto kwdikopoihmeno shma h thesh tou pinaka centers 
            %pou antistoixei sto teleytaio kentro ths teleytaias perioxhs kvantishs
            y_hat(i) = 2^N;
        end
    end
    %to kwdikopoihmeno shma pou ypologisame dinetai ws eisodos sto centers 
    %gia na paroume to kvantismeno deigma ws centers(y_hat)
    y_hat(1:length(y)) = centers(y_hat); 
end 

