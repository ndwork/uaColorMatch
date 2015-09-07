
function template = getTimingTemplate()
  % Get the template
  timingFile1 = './calibrations/timing1.jpg';
  template1 = getTimingTemplateComponent( timingFile1, ...
    438, 354, 631, 675, 438, 1274 );
  timingFile2 = './calibrations/timing2.jpg';
  diffX = 631-438;
  diffY = 675-354;
  template2 = getTimingTemplateComponent( timingFile2, ...
    486, 362, 486+diffX, 362+diffY, 502, 1282 );
  template = ( template1 + template2 ) / 2;
end


function template = getTimingTemplateComponent( file, ...
  minX1, minY1, maxX1, maxY1, minX2, minY2 )

  img = imread( file );
  img = double( img ) / 255;
  hsv = rgb2hsv(img);
  v = hsv(:,:,3);

  timingTemplate1 = img( minY1:maxY1, minX1:maxX1 );
  diffX = maxX1 - minX1;
  diffY = maxY1 - minY1;
  maxX2 = minX2 + diffX;
  maxY2 = minY2 + diffY;
  timingTemplate2 = img( minY2:maxY2, minX2:maxX2 );
  
  template = ( timingTemplate1 + timingTemplate2 ) / 2;
end

