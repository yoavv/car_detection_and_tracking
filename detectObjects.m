function [mask, stats, croppedCarImages] = detectObjects(imgfull)
%detectObects takes the original image and using background subtraction
%returns the extent of the cars, their image and mask 
    global parameters;
    %detect moving objects by subtrating the backgroud
    mask =  parameters.foregroundDetector.step(imgfull);
    %filter out from the foreground only the cars
    [mask, stats]  = cleanMask( mask,imgfull );

    %remove the cars which do not intersect with the area of intrest for
    %better preformance
    deleted = 0;
    for j = 1:length(stats)
        x= int16(stats(j -deleted).BoundingBox(1));
        y= int16(stats(j -deleted).BoundingBox(2));

        carContour = stats(j -deleted).Image;
        carMask = zeros(size(parameters.crop_large));
        
        carMask(y: y+size(carContour,1) -1 ,x:x+ size(carContour,2)-1, :) = carContour;
        blobIntesectionSize = sum(sum(parameters.crop_large .* carMask));
        if( (blobIntesectionSize < parameters.smallestBlob) || (blobIntesectionSize > parameters.largestBlob) )
            stats(j - deleted) = [];
            deleted = deleted +1;
            mask = mask - carMask;
        end
    end

    %get the car image
	croppedCarImages  = extractCars( stats,imgfull );


end