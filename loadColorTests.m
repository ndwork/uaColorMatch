
function tests = loadColorTests()

  colorFile = './calibrations/colors.jpg';

  tests(1).name = 'LEU';
  tests(1).time = 120;    % time in seconds
  tests(1).x = [ 55 56 57 59 60 ];
  tests(1).y = [ 467 419 371 325 277 ];
  tests(1).colorFile = colorFile;
  tests(1).xOffset = -281;
  tests(1).yOffset = 194;

  tests(2).name = 'NIT';
  tests(2).time = 60;
  tests(2).x = [ 100 101 107 ];
  tests(2).y = [ 468 419 184 ];
  tests(2).colorFile = colorFile;
  tests(2).xOffset = -281;
  tests(2).yOffset = 50;

  tests(3).name = 'URO';
  tests(3).time = 60;
  tests(3).x = [ 147 147 148 150 151 152 ];
  tests(3).y = [ 468 419 371 325 278 231 ];
  tests(3).colorFile = colorFile;
  tests(3).xOffset = -286;
  tests(3).yOffset = -91;

  tests(4).name = 'PRO';
  tests(4).time = 60;
  tests(4).x = [ 190 193 194 195 195 197 ];
  tests(4).y = [ 467 419 373 326 280 232 ];
  tests(4).colorFile = colorFile;
  tests(4).xOffset = -286;
  tests(4).yOffset = -234;

  tests(5).name = 'pH';
  tests(5).time = 60;
  tests(5).x = [ 239 239 238 240 242 241 242 ];
  tests(5).y = [ 468 420 373 325 280 232 187 ];
  tests(5).colorFile = colorFile;
  tests(5).xOffset = -286;
  tests(5).yOffset = -383;

  tests(6).name = 'BLO';
  tests(6).time = 60;
  tests(6).x = [ 283 283 285 285 286 ];
  tests(6).y = [ 467 420 374 326 280 ];
  tests(6).colorFile = colorFile;
  tests(6).xOffset = -286;
  tests(6).yOffset = -523;

  tests(7).name = 'SG';
  tests(7).time = 45;
  tests(7).x = [ 329 328 328 329 329 329 330 ];
  tests(7).y = [ 468 420 375 328 280 236 189 ];
  tests(7).colorFile = colorFile;
  tests(7).xOffset = -286;
  tests(7).yOffset = -667;

  tests(8).name = 'KET';
  tests(8).time = 40;
  tests(8).x = [ 372 373 373 374 374 375 ];
  tests(8).y = [ 468 421 372 328 283 236 ];
  tests(8).colorFile = colorFile;
  tests(8).xOffset = -290;
  tests(8).yOffset = -811;

  tests(9).name = 'BIL';
  tests(9).time = 30;
  tests(9).x = [ 418, 418, 419, 419 ];
  tests(9).y = [ 467, 422, 374, 327 ];
  tests(9).colorFile = colorFile;
  tests(9).xOffset = -290;
  tests(9).yOffset = -959;

  tests(10).name = 'GLU';
  tests(10).time = 30;
  tests(10).x = [ 462, 463, 463, 463, 463, 463 ];
  tests(10).y = [ 468, 423, 374, 329, 283, 237 ];
  tests(10).colorFile = colorFile;
  %tests(10).xOffset = -290;
  %tests(10).yOffset = -1107;
  tests(10).xOffset = -302;
  tests(10).yOffset = -1104;

end

