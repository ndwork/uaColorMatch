
function run_testForTiming
  clear; close all;

  img = imread( '../timing.jpg' );
  img = double( img ) / 255;
  hsv = rgb2hsv(img);

  %figure; imshow( hsv(:,:,1), [] );
  %figure; imshow( hsv(:,:,2), [] );
  %figure; imshow( hsv(:,:,3), [] );

  v = hsv(:,:,3);  
  timingTemplate = v( 1292:1664, 383:569 );
  
  ncc = normxcorr2( timingTemplate, v );
  maxNCC = max( ncc(:) );
  

  otherImg = imread( '../img_0028.jpeg' );
  otherImg = double( otherImg ) / 255;
  otherHSV = rgb2hsv( otherImg );
  otherV = otherHSV(:,:,3);
  
  otherNCC = normxcorr2( timingTemplate, otherV );
  otherMaxNCC = max( otherNCC(:) );
  disp( ['Other Max NCC: ', num2str(otherMaxNCC)] );
  
  
end

