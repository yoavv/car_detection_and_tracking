function [ imgCell ] = extractCars( stats,img )
%extractCars return an array of detected car images with the background
%being 0 vales

    carNumber = length(stats);
    imgCell = cell(carNumber,1);

    for j = 1:carNumber
        %extent of the cars
        x= int16(stats(j).BoundingBox(1,1));
        y= int16(stats(j).BoundingBox(1,2));
        %geting the car contour
        carContour = stats(j).Image;
        %getting the image inside the contour and adding to the array
        car = img(y: y+size(carContour,1) -1 ,x:x+ size(carContour,2)-1, :);
        imgCell{j} = car .*repmat(carContour, [1 1 3]);
    end
end

