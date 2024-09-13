import 'package:flutter/material.dart';

class DiseasePredictionResultPage extends StatelessWidget {
  final String predictedDisease;
  final Map<String, dynamic> diseaseInfo;

  DiseasePredictionResultPage({
    required this.predictedDisease,
    required this.diseaseInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Disease Prediction Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Predicted disease: $predictedDisease',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Disease Information:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              _buildSection('Description', [diseaseInfo['description'] ?? 'Not available']),
              _buildSection('Precautions', diseaseInfo['precautions'] ?? []),
              _buildSection('Medications', diseaseInfo['medications'] ?? []),
              _buildSection('Diet Recommendations', diseaseInfo['diet'] ?? []),
              _buildSection('Workout Recommendations', diseaseInfo['workout'] ?? []),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildSection(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        if (items.isEmpty)
          Text('No information available.')
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map<Widget>((item) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '• ${item.toString()}',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        SizedBox(height: 20),
      ],
    );
  }
}