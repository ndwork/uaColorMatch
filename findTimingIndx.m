
function [startTimingIndx,rotk] = findTimingIndx( data, zeroBorderNCC )

  nccThresh = 0.85;

  timingTemplate = getTimingTemplate();
  sTemplate = size( timingTemplate );
  halfNccR = ceil(sTemplate(1)/2);
  halfNccC = ceil(sTemplate(2)/2);

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

    ncc = ncc( halfNccR:end-halfNccR, halfNccC:end-halfNccC );
    ncc(:,1:zeroBorderNCC) = 0;  ncc(:,end-zeroBorderNCC:end) = 0;
    ncc(1:zeroBorderNCC,:) = 0;  ncc(end-zeroBorderNCC:end,:) = 0;

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

