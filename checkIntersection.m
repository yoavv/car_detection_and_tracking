function [carCount, path] = checkIntersection(Cars)
%checkIntersection return weather a car crosses the border and its
%direction
    global parameters;
    carCount =[0 0];
    path = [];

    for j = 1:length(Cars)

        if(Cars(j).Age >= parameters.minAgeForPathIntersection && Cars(j).invisbiltyCount == 0)
            
            %path is a line between the last two locations
            path = [Cars(j).Centroids(end,:); Cars(j).Centroids(end-1,:) ];
            % check the intersection of the car path and the border 
            [inside, direction] = checkInside(path);
        
            if( inside == 1 && (Cars(j).crossed == 0))
                %increment the count for the relevant crossing direction
                carCount(direction) = carCount(direction) +1;
                %mark car as crossed to prevent double count when on border
                Cars(j).crossed = 1;
            end
        end
    end
end
