
function run_analyzeDipstick
  clear; close all;

  datacase = 1;

  data = loadData( datacase );
  tests = loadColorTests();

  results = analyzeDipstick( data, tests, 'angle' );

  for i=1:numel(results)
    disp([ 'For test ', num2str(i), '-', tests(i).name, ...
      ' the best match is ', num2str(results(i)) ]);
  end
  
end
