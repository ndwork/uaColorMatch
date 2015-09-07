
function run_batchAnalysis
  close all; clear;

  datacases = 1:30;
  %metrics = {'angle', 'relativeBrightness', 'hsDist', 'aDist', 'yetisen'};
  metrics = {'angle'};

  tests = loadColorTests();
  testNames = [tests(1).name];
  blanks = [];
  for i=2:numel(tests)
    testNames = [ testNames, ', ', tests(i).name ];
    blanks = [ blanks, ', ' ];
  end

  colorBar = loadColorBar();

  outString = [ 'datacase, date, type' ];
  %metricString  = [ ', , ' ];
  outStringParts = strsplit( outString, ',' );
  for i=1:numel(outStringParts)
    outStringParts{i} = ' ';
  end
  metricString = strjoin( outStringParts, ', ' );
  for i=1:numel(metrics)
    outString = [ outString, ', ', testNames ];
    metricString = [ metricString, ', ', metrics{i}, blanks ];
  end

  outFileID = fopen('batch.csv','w');
  fprintf( outFileID, [metricString,'\n'] );
  fprintf( outFileID, [outString,'\n'] );
 
  nDatacases = numel(datacases);
  outStrings = cell(nDatacases,1);
  
  parfor i=1:nDatacases
    disp(['Working on datacase ', num2str(i), ' of ', ...
      num2str(nDatacases)]);
    close all;

    data = loadData( datacases(i) );
    dataDirParts = strsplit( data.directory, '/' );
    datacaseType = dataDirParts{end-2};
    datacaseName = [ dataDirParts{end}, ', ', dataDirParts{end-1} ];

    outString = [ datacaseName, ', ', datacaseType ];

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

    outStrings{i} = outString;
  end

  for i=1:numel(outStrings)
    fprintf( outFileID, [outStrings{i},'\n'] );
  end
  
  fclose(outFileID);
end
