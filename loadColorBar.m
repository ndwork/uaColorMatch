
function colorBar = loadColorBar()

  colorFile = './calibrations/colors.jpg';

  colorBar.file = colorFile;

  % Color bar in the calibration image
  colorBar.black1 = [ 89 116 ];
  colorBar.white = [ 146 118 ];
  colorBar.gray = [ 198 119 ];
  colorBar.yellow = [ 251 120 ];
  colorBar.blue = [ 304 121 ];
  colorbar.green = [ 355 122 ];
  colorBar.red = [ 408 124 ];
  colorBar.black2 = [ 460 127 ];


  % Offsets to colorbar in test image
  colorBar.black1Offset = [ -182 -1047 ];
  colorBar.whiteOffset = [ -179 -864 ];
  colorBar.grayOffset = [ -179 -684 ];
  colorBar.yellowOffset = [ -179 -513 ];
  colorBar.blueOffset = [ -179 -330 ];
  colorBar.greenOffset = [ -176 -168 ];
  colorBar.redOffset = [ -173 9 ];
  colorBar.black2Offset = [ -173 174 ];

end

