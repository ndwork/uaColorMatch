
function results = analyzeDipstick( data, tests, varargin )
  % results = analyzeDipstick( data, tests [, metric] )
  % metric is an optional string supplied to specify which distance
  %   metric to use.  By default, the angle distance is used.

  defaultMetric = 'angle';
  possibleMetrics = {'angle', 'hsDist', 'aDist', 'yetisen'};
  p = inputParser;
  p.addOptional( 'metric', defaultMetric, ...
    @(x) any(validatestring(x,possibleMetrics)) );
  p.parse(varargin{:});
  metric = p.Results.metric;


  %[timingIndx, rotk] = findTimingIndx( data );
timingIndx = 18;
rotk = 1;

  timingTemplate = getTimingTemplate();
  sTemplate = size( timingTemplate );
  halfNccR = ceil(sTemplate(1)/2);
  halfNccC = ceil(sTemplate(2)/2);

colorH = figure;
testH = figure;

  nTests = numel(tests);
  results = zeros(nTests,1);
  fps = data.fps;   % frames per second
  for i=1:nTests
    disp(['Working on test ', num2str(i) ' of ', num2str(nTests) ]);

    % Figure out the frame to use in the test
    testTime = tests(i).time;
    nFramesDiff = testTime * fps;
    testFrameIndx = timingIndx + nFramesDiff;

    testFile = [data.directory, '/', data.files(testFrameIndx).name];
    testImg = imread( testFile );
    testImg = double(testImg) ./ 255;
    if rotk > 0
      sTestImg = size(testImg);
      if mod(rotk,2)==1
        newTestImg = zeros( sTestImg(2), sTestImg(1), 3 );
      else
        newTestImg = zeros( sTestImg(1), sTestImg(2), 3 );
      end
      newTestImg(:,:,1) = rot90( testImg(:,:,1), rotk );
      newTestImg(:,:,2) = rot90( testImg(:,:,2), rotk );
      newTestImg(:,:,3) = rot90( testImg(:,:,3), rotk );
      testImg = newTestImg;
    end

    hsvImg = rgb2hsv( testImg );
    vImg = hsvImg(:,:,3);

    ncc = normxcorr2( timingTemplate, vImg );
    ncc = ncc( halfNccR:end-halfNccR, halfNccC:end-halfNccC );

    nR = size(ncc,1);
    halfR = ceil(nR/2);
    upperNCC = ncc(1:halfR,:);
    [~,maxNccIndxUpper] = max( upperNCC(:) );
    [y1,x1] = ind2sub( size(upperNCC), maxNccIndxUpper );

    lowerNCC = ncc(halfR+1:end,:);
    [~,maxNccIndxLower] = max( lowerNCC(:) );
    [y2,x2] = ind2sub( size(lowerNCC), maxNccIndxLower );
    y2 = y2 + halfR;

    vy = y2 - y1;
    vx = x2 - x1;

    angle2Rotate = -atan2( vx, vy );    
    vertAligned = rotateImg( testImg, angle2Rotate, [y2;x2] );

    testX = x2 + tests(i).xOffset;
    testY = y2 + tests(i).yOffset;

    testSub = vertAligned( testY-1:testY+1, testX-1:testX+1, : );
    testSub = reshape( testSub, [9,3] );
    testRGB = mean( testSub )';
    testNorm = norm( testRGB, 2 );
    testVec = testRGB ./ testNorm;
    testHSV = rgb2hsv( testVec' );
    testLAB = squeeze( rgb2lab( testVec(1), testVec(2), testVec(3) ) );

figure(testH); imshow( vertAligned, [] ); title('Test Image');
hold on; plot( testX, testY, '+' ); drawnow;

    colorPadImg = imread( tests(i).colorFile );
    colorPadImg = double( colorPadImg ) / 255.;

    nTestPad = numel( tests(i).x );
    dists = zeros(nTestPad,1);
    for j=1:nTestPad

figure(colorH); imshow(colorPadImg); title('Color Image');
hold on; plot(tests(i).x(j),tests(i).y(j),'+'); drawnow;

      padRGB = squeeze( colorPadImg(tests(i).y(j),tests(i).x(j),:) );
      padNorm = norm( padRGB, 2 );
      padVec = padRGB ./ padNorm;
      padHSV = rgb2hsv( padVec' );
      padLAB = squeeze( rgb2lab( padVec(1), padVec(2), padVec(3) ) );

      switch metric
        case 'angle'
          dists(j) = acos( sum( padRGB .* testVec )  / padNorm );

        case 'hsDist'
          dists(j) = calculateHsMetric( testHSV, padHSV );

        case 'aDist'
          dists(j) = abs( testLAB(2) - padLAB(2) );  % works on BIL

        case 'yetisen'
          dists(j) = calculateYetisenMetric( testRGB, padRGB );
      end
      %dists(j) = sqrt( sum( (padColor./padNorm - testVec).^2 ) );

    end

    [~,bestMatch] = min(dists);
    results(i) = bestMatch;
  end

end


function out = calculateYetisenMetric( rgbC1, rgbC2 )

  rgbL1 = ( ( 0.055 + rgbC1 ) ./ 1.055 ).^2.4;
  rgbL2 = ( ( 0.055 + rgbC2 ) ./ 1.055 ).^2.4;

  M = [ [ 0.4124 0.3576 0.1805 ]; ...
        [ 0.2126 0.7152 0.0722 ]; ...
        [ 0.0193 0.1192 0.9505 ]  ];

  xyz1 = M * rgbL1;   sumXYZ1 = sum(xyz1);
  xyz2 = M * rgbL2;   sumXYZ2 = sum(xyz2);

  
  x1 = xyz1(1) / sumXYZ1;
  y1 = xyz1(2) / sumXYZ1;
  
  x2 = xyz2(1) / sumXYZ2;
  y2 = xyz2(2) / sumXYZ2;
  
  out = sqrt( (x1-x2)^2 + (y1-y2)^2 );
end


function out = calculateHsMetric( hsv1, hsv2 )
  hue1 = hsv1(1)*2*pi;
  sat1 = hsv1(2);
  hue2 = hsv2(1)*2*pi;
  sat2 = hsv2(2);
  x1 = cos( hue1 ) * sat1;
  y1 = sin( hue1 ) * sat1;
  x2 = cos( hue2 ) * sat2;
  y2 = sin( hue2 ) * sat2;
  out = sqrt( (x1-x2)^2 + (y1-y2)^2 );
end


function [startTimingIndx,rotk] = findTimingIndx( data )

  nccThresh = 0.85;

  timingTemplate = getTimingTemplate();


  % Find the frame where timing begins
  startTimingIndx = 0;
  nFiles = numel(data.files);
  nccs = zeros(nFiles,1);
  rotk = 0;
  for i=1:nFiles
    if mod(i,10)==0
      disp([ 'findTiming frame ', num2str(i), ' of ', ...
        num2str(nFiles) ]);
    end
    file = [ data.directory, '/', data.files(i).name ];
    if numel( regexp( file, 'jpg$' ) ) == 0, continue; end;
    img = imread( file );
    hsv = rgb2hsv(img);
    v = hsv(:,:,3);
    sV = size(v);
    if sV(2) > sV(1)
      rotk = 1;
      v = rot90( v );
    end
    ncc = normxcorr2( timingTemplate, v );
    maxNCC1 = max( ncc(:) );
    v = rot90( v, 2 );
    ncc = normxcorr2( timingTemplate, v );
    maxNCC2 = max( ncc(:) );
    maxNCC = max( maxNCC1, maxNCC2 );
    nccs(i) = maxNCC;
    if maxNCC > nccThresh
      startTimingIndx = i;
      if maxNCC2 > maxNCC1, rotk = rotk + 2; end;
      break;
    end
  end

  if startTimingIndx == 0
    error('Never found frame to start timing');
    return;
  end

end


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


