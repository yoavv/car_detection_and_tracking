function [carCount] =  main(imagesLocation)
% detects cars using foreground detector
% follows the car and checks if it intersects the border

    %initiaize variables
    global parameters;
    parameters = params(imagesLocation);
    Cars = initCars();
    carCount = [0 0];
    for i= 1:length(parameters.imageNames)
        
        %reading image from directory and 
        imgFull= single(imread([imagesLocation parameters.imageNames(i,:)]))/255;
        %detecing the moving cars using backgroud subtration and filtering
        [mask, stats, croppedCarImages]= detectObjects(imgFull);
        
        %match newly detected cars with previously detected cars
        Cars = connectCars(Cars, stats, croppedCarImages);
        %check if a car has crossed the border and the direction
        [count, path] =  checkIntersection(Cars);
        carCount = carCount + count;
        %display the image with the data on top
        
         monitors(imgFull, mask, Cars, carCount, path);

        

    end 

end

 


