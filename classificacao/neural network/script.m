workingDir = 'C:\Users\Fernanda\Desktop\TCC\classificacao';
datasetsDir = 'C:\Users\Fernanda\Desktop\TCC\classificacao\Alimentos';

paths = Paths( workingDir, datasetsDir );

preprocessFunction=@( i, o ) preProcessDataset( i, o );
preprocessor = Preprocessor( paths, preprocessFunction );
preprocessor.preprocess()

featureExtractor = FeatureExtractor( paths );
featureExtractor.extractFeatures();

techniquesFactoryId = 'ANN';
classificationStrategy = 'default';
%selectionAlgorithm = 'greedy'; 
selectionAlgorithm = 'default'; 
reductionAlgorithm = 'default'; 
errorAlgorithm = 'eqm';

config = ClassifierConfiguration(paths, techniquesFactoryId, classificationStrategy, selectionAlgorithm, reductionAlgorithm, errorAlgorithm);
classifier = Classifier(config);
classifier.train(5,{'entropy', 'contrast', 'transformedRGB'},1);
%classifier.train(5,{'contrast', 'entropy', 'normalizedRG', 'transformedRGB'},1,5);


resultProcessor = ResultProcessor(config);
resultProcessor.processResults();