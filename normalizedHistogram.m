function [ normHisto ] = normalizedHistogram( img1 )
%normalizedHistogram removes the zero pixels and normalize the histogram
%by dividing by the number of non zero pixels 
    if(size(size(img1),2) == 3)
        img1=rgb2gray(img1);
    end
    n = nnz(img1);
    histo =imhist(img1);
    normHisto=histo/n;
    
    %remove 0 pixels
    normHisto=normHisto(2:end);

end

