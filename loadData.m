
function data = loadData( datacase )

  switch datacase
    case 1
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_1';
      fps = 2;
    case 2
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_2';
      fps = 2;
    case 3
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_3';
      fps = 2;
    case 4
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_4';
      fps = 2;
    case 5
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_5';
      fps = 2;
    case 6
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_6';
      fps = 2;
    case 7
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_7';
      fps = 2;
    case 8
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_8';
      fps = 2;
    case 9
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_9';
      fps = 2;
    case 10
      directory = '/Volumes/HP4GB/urinalysis/slippingL2_10';
      fps = 2;
    case 11
      directory = '/Volumes/HP4GB/urinalysis/slippingL1_1';
      fps = 2;
    case 12
      directory = '/Volumes/HP4GB/urinalysis/slippingL1_2';
      fps = 2;
    case 13
      directory = '/Volumes/HP4GB/urinalysis/slippingL1_3';
      fps = 2;
    case 14
      directory = '/Volumes/HP4GB/urinalysis/slippingL1_4';
      fps = 2;
    otherwise
      error('Selected datacase doesn''t exist');
  end

  files = dir( directory );
  files = files(3:end);

  data.directory = directory;
  data.files = files;
  data.fps = fps;
end
