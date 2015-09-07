
function data = loadData( datacase )

  switch datacase
    case 1
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_1';
      fps = 2;
    case 2
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_2';
      fps = 2;
    case 3
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_3';
      fps = 2;
    case 4
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_4';
      fps = 2;
    case 5
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_5';
      fps = 2;
    case 6
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_6';
      fps = 2;
    case 7
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_7';
      fps = 2;
    case 8
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_8';
      fps = 2;
    case 9
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_9';
      fps = 2;
    case 10
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL2_10';
      fps = 2;
    case 11
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL1_1';
      fps = 2;
    case 12
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL1_2';
      fps = 2;
    case 13
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL1_3';
      fps = 2;
    case 14
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/ambient/20150807/slippingL1_4';
      fps = 2;
    case 15
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL1_1';
      fps = 2;
    case 16
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL1_2';
      fps = 2;
    case 17
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL1_3';
      fps = 2;
    case 18
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL1_4';
      fps = 2;
    case 19
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL2_1';
      fps = 2;
    case 20
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL2_2';
      fps = 2;
    case 21
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL2_3';
      fps = 2;
    case 22
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150826/slippingL2_4';
      fps = 2;
    case 23
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL1_1';
      fps = 2;
    case 24
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL1_2';
      fps = 2;
    case 25
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL1_3';
      fps = 2;
    case 26
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL1_4';
      fps = 2;
    case 27
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL2_1';
      fps = 2;
    case 28
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL2_2';
      fps = 2;
    case 29
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL2_3';
      fps = 2;
    case 30
      directory = '/Volumes/Seagate2TB/Data/Urinalysis_Data/flash/20150904/slippingL2_4';
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
