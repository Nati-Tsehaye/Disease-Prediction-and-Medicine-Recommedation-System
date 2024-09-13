# Disease Prediction and Medicine Recommedation System

## Overview

The **Disease Prediction and Medicine Recommendation System** is a mobile application that helps users identify potential diseases based on their inputted symptoms. It uses a machine learning model for accurate disease prediction and provides comprehensive information about the diagnosed condition, including:
- Disease description
- Precautionary measures
- Recommended medications
- Suggested diets
- Workout recommendations

This system is built with Flutter for the mobile frontend, which communicates with a pre-trained machine learning model for backend disease prediction. The user interface is designed to be user-friendly and informative, making it easy for anyone to receive helpful health insights.

## Features

- **Symptom Input:** Users can select and input their symptoms, with the app preventing duplicate entries.
- **Disease Prediction:** Based on the input symptoms, the app predicts the most likely disease.
- **Disease Information:** Detailed descriptions of the predicted disease are provided.
- **Precautions & Medications:** The app suggests precautionary measures and medications for the predicted disease.
- **Diet & Workout Plans:** Recommended diet plans and workout routines tailored to the predicted disease are included to promote a healthy recovery.

## Demo
Check out the video below to see the Disease Prediction and Medicine Recommendation System in action:


https://github.com/user-attachments/assets/61ac3856-8b13-460e-a301-6c2fb8a5dd9c





## Technology Stack

- **Frontend:** Flutter for cross-platform mobile development.
- **Backend:** TensorFlow Lite for disease prediction via a machine learning model.
- **Data:** Symptom-to-disease mappings and disease information loaded from JSON files.
- **Languages:** Dart (Flutter), Python (Machine Learning Model)

## Getting Started

### Prerequisites

1. [Flutter](https://flutter.dev/docs/get-started/install) installed on your system.
2. A compatible mobile device or emulator to run the app.
3. TensorFlow Lite model for disease prediction.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Nati-Tsehaye/Disease-Prediction-and-Medicine-Recommedation-System.git
   cd Disease-Prediction-System
   ```

2. Install the necessary Flutter dependencies:

   ```bash
   flutter pub get
   ```

3. Ensure the TensorFlow Lite model and supporting files (e.g., `encoded_diseases.json`, `symptoms.json`) are correctly placed in the appropriate directories.

### Running the Application

1. Start an emulator or connect your device.
2. Run the app with:

   ```bash
   flutter run
   ```

## Dataset

The model is trained using a dataset containing various disease symptom mappings. It predicts diseases based on symptom patterns and provides corresponding treatment recommendations.

## Model Details

The disease prediction model uses machine learning techniques to classify diseases based on the symptoms provided by the user. The model was trained using TensorFlow and converted into TensorFlow Lite for mobile integration. It is connected to Flutter to allow real-time predictions on the mobile app.

## Contributions

Feel free to contribute to this project by submitting pull requests or opening issues. 

---

Let me know if you'd like any adjustments!


