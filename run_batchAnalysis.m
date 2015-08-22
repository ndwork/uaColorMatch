
function run_batchAnalysis

  datacases = 1:14;
  %metrics = {'angle', 'hsDist', 'aDist', 'yetisen'};
  metrics = {'angle', 'aDist'};

  tests = loadColorTests();
  testNames = [tests(1).name];
  blanks = [];
  for i=2:numel(tests)
    testNames = [ testNames, ', ', tests(i).name ];
    blanks = [ blanks, ', ' ];
  end

  colorBar = loadColorBar();

  outString = [ 'datacase' ];
  metricString  = [ ];
  for i=1:numel(metrics)
    outString = [ outString, ', ', testNames ];
    metricString = [ metricString, ', ', metrics{i}, blanks ];
  end

  outFileId = fopen('batch.csv','w');
  fprintf( outFileId, [metricString,'\n'] );
  fprintf( outFileId, [outString,'\n'] );

  nDatacases = numel(datacases);
  for i=1:nDatacases
    disp(['Working on datacase ', num2str(i), ' of ', ...
      num2str(nDatacases)]);
    close all;
    
    data = loadData( datacases(i) );
    dataDirParts = strsplit( data.directory, '/' );
    datacaseName = dataDirParts{end};

    outString = [ datacaseName ];

    nMetrics = numel(metrics);
    for j=1:nMetrics
      disp(['Working on metric ', num2str(j), ' of ', ...
        num2str(nMetrics) ]);

      results = analyzeDipstick( data, tests, colorBar, metrics{j} );
      resultsString = [num2str(results(1))];
      for rIndx=2:numel(results)
        resultsString = [ resultsString, ', ', num2str(results(rIndx)) ];
      end

      outString = [ outString, ', ', resultsString ];
    end

    fprintf( outFileId, [outString,'\n'] );
  end

  fclose(outFileId);
end
