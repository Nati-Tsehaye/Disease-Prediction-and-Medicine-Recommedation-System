import 'package:flutter/material.dart';
import 'disease_predictor_model.dart';
import 'disease_prediction_result_page.dart'; // Import the new page

class DiseasePredictorPage extends StatefulWidget {
  @override
  _DiseasePredictorPageState createState() => _DiseasePredictorPageState();
}

class _DiseasePredictorPageState extends State<DiseasePredictorPage> {
  final DiseasePredictorModel _model = DiseasePredictorModel();
  final List<String> _selectedSymptoms = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _infoMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeModel();
  }

  Future<void> _initializeModel() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
      await _model.initialize();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to initialize model: $e';
      });
    }
  }

  Future<void> _predictDisease() async {
    if (_selectedSymptoms.length < 3) {
      setState(() {
        _infoMessage = 'Please select at least three symptoms to predict the disease.';
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
        _infoMessage = '';
      });
      String predictedDisease = await _model.predictDisease(_selectedSymptoms);
      setState(() {
        _isLoading = false;
      });

      // Navigate to the result page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiseasePredictionResultPage(
            predictedDisease: predictedDisease,
            diseaseInfo: _model.diseaseInfo[predictedDisease] ?? {},
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error predicting disease: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Predictor'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select your symptoms:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        _model.symptoms.isNotEmpty
                            ? DropdownButtonFormField<String>(
                                isExpanded: true,
                                hint: Text('Select symptoms'),
                                items: _model.symptoms.map((symptom) {
                                  return DropdownMenuItem<String>(
                                    value: symptom,
                                    child: Text(symptom),
                                  );
                                }).toList(),
                                onChanged: (selectedSymptom) {
                                  setState(() {
                                    if (selectedSymptom != null) {
                                      if (_selectedSymptoms.contains(selectedSymptom)) {
                                        _selectedSymptoms.remove(selectedSymptom);
                                      } else {
                                        if (_selectedSymptoms.length < 5) { // Limit to 5 symptoms
                                          _selectedSymptoms.add(selectedSymptom);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('You can select up to 5 symptoms.'),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                value: _selectedSymptoms.isNotEmpty ? _selectedSymptoms.last : null,
                              )
                            : Center(child: Text('No symptoms available')),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _predictDisease,
                            child: Text('Predict Disease'),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (_infoMessage.isNotEmpty)
                          Center(child: Text(_infoMessage, style: TextStyle(color: Colors.orange, fontSize: 16))),
                        if (_selectedSymptoms.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Symptoms:',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              ..._selectedSymptoms.map((symptom) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Text('• $symptom', style: TextStyle(fontSize: 16)),
                                );
                              }).toList(),
                            ],
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
