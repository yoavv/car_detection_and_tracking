function [img] = linedraw(img, pos,color)
%adds a line to image in specified location
    pos_line = [pos(1,:) pos(2,:)];
    img = insertShape(img,'line',{pos_line},'Color', {color});

end