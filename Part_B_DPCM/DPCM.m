function [y,x_hat]=DPCM(x,p,N)
    %ypologismos dianysmatos aytosysxetishs r ,diastashs px1 me stoixeio i to Rx(i)
    %opou Rx h synarthsh aytosysxetishs ths tyxaias diadikasias x(n)
    
    %gia 1 <= i <= p
    for i=1:p
        %ypologismos tou R_hat_x(i) pou apotelei to stoixeio sthn thesh i tou
        %dianismatos r
        sum = 0;
        for n=p+1:length(x)
            sum=sum+x(n)*x(n-i);
        end
        r(i) = sum/(length(x)-p);
    end
    r=r';
    %ypologismos pinaka aytosysxetishs r ,diastashs pxp me stoixeio (i,j) 
    %to Rx(i-j) opou Rx h synarthsh aytosysxetishs ths tyxaias diadikasias x(n)
    for i=1:p
        for j=1:p
            %ypologismos tou R_hat_x(i) pou apotelei to stoixeio sthn thesh i tou
            %dianismatos r
            sum = 0;
            for n=p+1:length(x)
                sum=sum+x(n-j)*x(n-i);
            end
            R(i,j)=(sum/(length(x)-p));
        end
    end
    %ypologismos dianismatos a diadtashs px1 me tous syntelestes tou 
    %filtrou provlepshs 
    a=R\r;
    %ypologismos kvantismenwn timwn twn syntelestwn thetontas N=8bit kai 
    %dynamikh perioxh [-2 2] 
    %o ypologismos twn a kai aq ginetai kai ston pompo kai sto dekth
    aq = my_quantizer(a,8,-2,2)';

    %----POMPOS----%

    %Arxikopoihsh Systhmatos 
    %thewroume oti arxizei na leitourgei ws DPCM apo to p+1 deigma 
    %dhladh oti ta prwta p deigmata metadidontai xwris sfalmata
    %kai mh kvantismena opote ginetai apothikeysh sth mnhmh tou pompou 
    %h opoia krataei apothikevmenes tis anakataskevasmenes times 
    %twn prohgoymenwn deigmatwn  
    x_hat_pompou(1:p)=x(1:p)';
    for j=p+1:length(x)
        %ypologismos provlepshs y_tonos
        sum = 0;
        for i = 1:p
            sum = sum + aq(i)*x_hat_pompou(j-i); 
        end
        y_tonos(j) = sum;
        %ypologismos sfalmatos provlepshs
        y(j)=x(j)-y_tonos(j);
        %kvantish sfalmatos provlepshs kai apostolh sto dekth
        y_hat(j)=my_quantizer(y(j),N,-3.5,3.5)';
        x_hat_pompou(j)=y_hat(j)+y_tonos(j);
    end
    x_hat_pompou = x_hat_pompou';

    %----DEKTHS----%

    %ta prwta p deigmata metadidontai xwris sfalmata opote ta p prwta 
    %psifia ths anakataskevhs toy x_hat einai idia 
    x_hat(1:p)=x(1:p)';
    for j=p+1:length(x)
    %ypologismos provlepshs y_tonos apo ton dekth
        sum = 0;
        for i = 1:p
            sum = sum + aq(i)*x_hat(j-i); 
        end
        y_tonos(j) = sum;
        %anakataskevh tou x apo ton dekth
        x_hat(j)=y_hat(j)+y_tonos(j);
    end
    x_hat = x_hat';
end