function [Cars] = connectCars (Cars, stats, croppedCarImages)
%connecrtCars function links between newly detected cars and exsiting ones
%if a new car is similar in appearence and location to an exsiting one it
%is assumed to be the same one. 
%if no similar car is found a new car is created.
%if a car is not detectable for a period of time it is assumed that the car
%has left the frame and the car is delted

    global parameters
    %arrays of cars and blobs that have no match
    unMatchedStats =(1:length(stats));
    unMatchedCars = (1:length(Cars));
    %comparing each blob to each exsisting car
    matchingIndexes = compareCars ( croppedCarImages, stats, Cars );
  
	for i=1: size(matchingIndexes,1)
        %find best match for the current car
        [~,bestIndex] = max( matchingIndexes(i,:));
        if(matchingIndexes(i,bestIndex) > 1)
            %if a match is found, pair the blob and the car and remove them
            %from the unmatched arrays
            Cars(i) =  updateCars( stats(bestIndex), Cars(i), croppedCarImages{bestIndex});   
            unMatchedStats( unMatchedStats == bestIndex) = [];
            unMatchedCars( unMatchedCars == i) = [];
            matchingIndexes(:,bestIndex) = 0;
            break;
        end

	end    
    %create a new car for each unmatched blob
    for i = 1:length(unMatchedStats)    
        Cars =[Cars  createNewCar(stats(unMatchedStats(i)), croppedCarImages{unMatchedStats(i)})];
    end
    %remove cars which do not have a maching blob for some time
    deleted =0;
    for i =1:length(unMatchedCars)           
        Cars( unMatchedCars(i) - deleted).invisbiltyCount = Cars( unMatchedCars(i) - deleted).invisbiltyCount +1;
        if(Cars( unMatchedCars(i) - deleted).invisbiltyCount > parameters.MaxInvisbiltyCount)
            Cars( unMatchedCars(i) - deleted) = [];
            deleted = deleted +1 ;
        end
    end
 
end
    
