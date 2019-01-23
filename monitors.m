function [] = monitors(img, mask, Cars, carCount, path)

%monitors prepares the data for display and displys it.
    global parameters;
    %masking the detected cars  
	%img = img -repmat(mask,[ 1 1 3]);
    %adding cars number label     
	for j = 1: length(Cars)
        position = [Cars(j).Centroids(end,:)  1];
        img =insertObjectAnnotation(img, 'circle',position, int2str(Cars(j).id),'FontSize', parameters.fontSize);
	end
    %adding the 2 car count labels
    img = insertObjectAnnotation (img, 'circle', parameters.count1Location,int2str(carCount(1)) , 'FontSize', parameters.fontSize);
    img = insertObjectAnnotation (img, 'circle',parameters.count2Location,int2str(carCount(2)) , 'FontSize', parameters.fontSize);
    %drawing the car movement path
    if(~isempty( path))
        img = linedraw(img,path,'green');
    end
    %drawing the border
    img = linedraw(img,parameters.borderLine,'blue');
    imagesc(img);
    drawnow;
    
end