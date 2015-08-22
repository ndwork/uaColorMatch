
function out = rotateImg( img, theta, pt )

  nImgDims = ndims( img );

  if nImgDims > 2
    out = img;
    out(:,:,1) = rotateGrayImg( img(:,:,1), theta, pt );
    out(:,:,2) = rotateGrayImg( img(:,:,2), theta, pt );
    out(:,:,3) = rotateGrayImg( img(:,:,3), theta, pt );
  else
    out = rotateGrayImg( img, theta, pt );
  end

end


function out = rotateGrayImg( img, theta, pt )

  sImg = size( img );

  ys = 1:sImg(1);
  xs = 1:sImg(2);

  [x,y] = meshgrid( xs, ys );

  y = y - pt(1);
  x = x - pt(2);

  N = numel(img(:));

  pts = zeros( 2, N );
  pts(1,:) = x(:);
  pts(2,:) = y(:);

  R = [ cos(theta) -sin(theta); ...
        sin(theta)  cos(theta); ];

  Rpts = R * pts;
  Xq = reshape( Rpts(1,:), sImg );
  Yq = reshape( Rpts(2,:), sImg );
  
  out = interp2( x, y, double(img), Xq, Yq );
end








