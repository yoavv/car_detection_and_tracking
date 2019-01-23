function [ mask, stats ] = cleanMask( mask,imgfull )
%cleanMask preforms manipulation on the foreground in order to filter
%out the noise and returns the mask of foreground objects and their
%properties
    
    global parameters;
    %remove noise from mask
    mask = imopen(mask, strel('rectangle', parameters.imOpen));
	mask = imclose(mask, strel('rectangle',parameters.imClose));
	mask = imfill(mask, 'holes');
    mask = xor(bwareaopen(mask,parameters.smallestBlob),  bwareaopen(mask,parameters.largestBlob));  

    %get the extent of the blobs
    stats = regionprops(mask,'BoundingBox');
    %remove the pedestrian blobs
    mask = removePedestrians( stats, imgfull, mask );

    %get the properties of the blobs
    stats = regionprops(mask,'BoundingBox','Image','Centroid','Orientation');
    %filter out blobs with are too small or too lare
    mask = xor(bwareaopen(mask,parameters.smallestBlob),  bwareaopen(mask,parameters.largestBlob));  
    
end

