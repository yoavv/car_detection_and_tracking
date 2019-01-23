function [Car] = updateCars(stats, Car, croppedCarImage)
%update car returns an updated car array 
    global parameters;
    Car.invisbiltyCount =0;
	%car is inly considered a car if it visiable for at least 2 frames
    Car.Age = Car.Age +1;
    if (Car.Age > parameters.minAgeForId && Car.id == 0)
        Car.id = parameters.numCars + 1;
        parameters.numCars = parameters.numCars +1;
    end
    
    %add centroid to vechile path
    Car.Centroids = vertcat(Car.Centroids , stats.Centroid);
    
	%update orientation
    if( pdist2( stats.Centroid,Car.Centroids(end,:)) > parameters.minDistForOrientationChange )
        y = (stats.Centroid(2) - Cars.Centroids(end,2));
        x = (stats.Centroid(1) - Cars.Centroids(end,1));
        movenentAngle = atan(y/x)*(pi/180);
    else
        movenentAngle = stats.Orientation;
    end

    Car.Orientation = movenentAngle;
    %update histogram
    Car.histogram = normalizedHistogram(croppedCarImage);
end