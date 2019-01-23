function [ maskCropped ] = removePedestrians( stats, img, mask )
%detect pedestrians in foreground and remove the using a pre trained
%cascade

    global parameters;    
    maskCropped = mask;
    
    for i = 1: length(stats)
        %get the extent of the blob
        x= int16(stats(i).BoundingBox(1));
        y = int16(stats(i).BoundingBox(2));
        width = stats(i).BoundingBox(3);
        height = stats(i).BoundingBox(4);
        I = img( y:y+height- 1, x:x+width -1 ,:);
        %applying the detection on the foreground blob extent
        if(predict(parameters.categoryClassifier, I) == 2)
            maskCropped(y:y+height- 1, x:x+width -1) = 0;
        end

    end

end

