 function [inside, direction] = checkInside(line2)
%checkInside checks the intersection of to lines of finite length and
% on which direction line2 crosses line1
    %border line
    global parameters;
    line1 = parameters.borderLine;


    slope = @(line) (line(2,2) - line(1,2))/(line(2,1) - line(1,1));
    m1 = slope(line1);
    m2 = slope(line2);

    intercept = @(line,m) line(1,2) - m*line(1,1);
    b1 = intercept(line1,m1);
    b2 = intercept(line2,m2);
    xintersect = (b2-b1)/(m1-m2);
    yintersect = m1*xintersect + b1;

    isPointInside = @(xint,myline) ...
        (xint >= myline(1,1) && xint <= myline(2,1)) || ...
        (xint >= myline(2,1) && xint <= myline(1,1));
    inside = isPointInside(xintersect,line1) && ...
             isPointInside(xintersect,line2);
         
         
     y2 = line2(1,2);
     x2 = line2(1,1);
     if(y2 < m1*x2 +b1)
         direction = 1;
     else
         direction =2;
     end
     
end