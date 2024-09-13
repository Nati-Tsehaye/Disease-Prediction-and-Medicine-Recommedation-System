import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class DiseasePredictorModel {
  Interpreter? _interpreter;
  List<String> _symptoms = [];
  Map<String, dynamic> _diseaseInfo = {};
  List<String> _encodedDiseases = [];
  bool _isInitialized = false;

  Future<void> initialize() async {
    try {
      await loadModel();
      await loadSymptoms();
      await loadDiseaseInfo();
      await loadEncodedDiseases();
      _isInitialized = true;
      print('Model initialization completed successfully.');
    } catch (e) {
      print('Error during model initialization: $e');
      _isInitialized = false;
    }
  }

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/disease_prediction_model.tflite');
      print('TFLite model loaded successfully.');
    } catch (e) {
      print('Error loading TFLite model: $e');
      rethrow;
    }
  }

  Future<void> loadSymptoms() async {
    try {
      String jsonString = await rootBundle.loadString('assets/symptoms_list.json');
      _symptoms = List<String>.from(json.decode(jsonString));
      print('Symptoms loaded successfully. Count: ${_symptoms.length}');
    } catch (e) {
      print('Error loading symptoms: $e');
      rethrow;
    }
  }

  Future<void> loadDiseaseInfo() async {
    try {
      String jsonString = await rootBundle.loadString('assets/disease_info.json');
      _diseaseInfo = json.decode(jsonString);
      print('Disease info loaded successfully. Disease count: ${_diseaseInfo.length}');
    } catch (e) {
      print('Error loading disease info: $e');
      rethrow;
    }
  }

Future<void> loadEncodedDiseases() async {
  try {
    String jsonString = await rootBundle.loadString('assets/encoded_diseases.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    _encodedDiseases = List<String>.from(jsonData['classes']); // Access the 'classes' key
    print('Encoded diseases loaded successfully. Count: ${_encodedDiseases.length}');
  } catch (e) {
    print('Error loading encoded diseases: $e');
    rethrow;
  }
}


Future<String> predictDisease(List<String> userSymptoms) async {
  if (!_isInitialized) {
    print('Model is not initialized. Attempting to initialize...');
    await initialize();
    if (!_isInitialized) {
      throw Exception('Failed to initialize the model.');
    }
  }

  if (_interpreter == null) {
    throw Exception('Interpreter is not initialized');
  }

  try {
    // Initialize input vector
    List<double> input = List.filled(_symptoms.length, 0);
    
    // Encode user symptoms into the input vector
    for (String symptom in userSymptoms) {
      int index = _symptoms.indexOf(symptom);
      if (index != -1) {
        input[index] = 1;
      }
    }

    // Log input vector to check symptom encoding
    print('Input vector for prediction: $input');

    // Prepare the output
    List<List<double>> output = List.generate(1, (_) => List<double>.filled(_encodedDiseases.length, 0));

    // Run the TFLite model
    _interpreter!.run([input], output);

    // Log model output to check if the model ran successfully
    print('Model output: $output');

    // Find the index with the highest probability
    int predictedIndex = output[0].indexOf(output[0].reduce((curr, next) => curr > next ? curr : next));

    // Log predicted index and disease for verification
    print('Predicted index: $predictedIndex');
    print('Predicted disease: ${_encodedDiseases[predictedIndex]}');

    return _encodedDiseases[predictedIndex];
  } catch (e) {
    print('Error during disease prediction: $e');
    rethrow;
  }
}

  List<String> get symptoms => _symptoms;
  Map<String, dynamic> get diseaseInfo => _diseaseInfo;

  void dispose() {
    _interpreter?.close();
  }
}