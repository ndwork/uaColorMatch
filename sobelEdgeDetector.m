
function edgeImg = sobelEdgeDetector( img, thresh )

  Gx = [ [ -1 0 1 ]; ...
         [ -2 0 2 ]; ...
         [ -1 0 1 ]; ];
       
  Gy = [ [ -1 -2 -1 ]; ...
         [  0  0  0 ]; ...
         [  1  2  1 ]; ];

  edgeX = imfilter( img, Gx, 'replicate', 'same' );
  edgeY = imfilter( img, Gy, 'replicate', 'same' );
  
  edgeImg = sqrt( edgeX.*edgeX + edgeY.*edgeY );
 
  if nargin > 1
    edgeImg = edgeImg > thresh;
  end
  
end
