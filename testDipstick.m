
function testDipstick
  close all; clear;

  imgFile = '../colors.jpg';
  img = imread( imgFile );
  figure; imshow( img, [] );

  knownPts = [ ...
    [ 315.0382  313.1836 ]; ...
    [ 312.6236  373.5473 ]; ...
    [ 312.6236  433.9109 ]; ...
    [ 312.6236  489.4455 ]; ...
    [ 310.2091  549.8091 ]; ...
    [ 310.2091  605.3436 ]; ...
    [ 310.2091  668.1218 ]; ...
  ];
  testPt = [ 302.9655  926.4782 ];

  knownPts = round(knownPts);
  testPt = round(testPt);
  
  [nKnownPts,~] = size(knownPts);
  knownColors = zeros(3,nKnownPts);
  for i=1:nKnownPts
    knownColors(:,i) = img(knownPts(i,2),knownPts(i,1),:);
  end
  testColor = img(testPt(2),testPt(1),:);
  knownColors = double(knownColors) / 255.;
  testColor = squeeze(double(testColor)) / 255.;
  
  thetas = zeros(nKnownPts,1);
  testNorm = norm( testColor, 2 );
  for i=1:nKnownPts
    knownNorm = norm( squeeze(knownColors(:,i)), 2 );
    thetas(i) = acos( sum( knownColors(:,i) .* testColor )  / ...
      testNorm / knownNorm );
  end

  [~,bestIndx] = min(thetas);
  disp(['Best match is index ', num2str(bestIndx)]);


end

