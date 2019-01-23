function [ indexArray ] = compareCars( croppedCarImages,stats, Cars )
%compareCars returns a score array matching each car and blob pair
%the score is based on 3 parameters:
% !)correlation between locations
% 2)histogram similarity
% 3)angle of movement compared to orientation of car since cars move in
   %the same direction as their orientation

    global parameters;
    indexArray = zeros(length(Cars),length(stats));
    
    for i = 1:length(Cars)
        for j =1:length(stats)
            
            %getting the car histogram 
            histo1 = normalizedHistogram( croppedCarImages{j});
            histo2 = Cars(i).histogram;
            %euclidean distance of histograms
            histoDistance = pdist2(histo1', histo2');
            %euclidean distance of locations
            centroidDistance = pdist2(Cars(i).Centroids(end,:),stats(j).Centroid);
            %compare object orientation to angle of movement
            y = (stats(j).Centroid(2) - Cars(i).Centroids(end,2));
            x = (stats(j).Centroid(1) - Cars(i).Centroids(end,1));
            movenentAngle = atan(y/x)*(180/pi);

            Orientation = stats(j).Orientation;

            angleDelta = abs( angdiff(movenentAngle*(pi/180),Orientation*(pi/180)))*(pi/180);
            

            points = 0;
            %point system to compare similarity
            points = points +(centroidDistance < parameters.MinDistanceThresh)* parameters.locationWeight;
            points = points + (histoDistance < parameters.histThresh)* parameters.histoWeight;
            points = points + (angleDelta < parameters.angleThresh)* parameters.angleWeight;
            
            indexArray(i,j) = points;
            
        end
    end
end

