import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Diet page/Diet_page.dart'; // Update with the correct path

class UserInfoForm2 extends StatefulWidget {
  @override
  _UserInfoForm2State createState() => _UserInfoForm2State();
}

class _UserInfoForm2State extends State<UserInfoForm2> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'male';
  String _selectedActivityLevel = 'sedentary';

  double _maintenanceCalories = 0.0;
  double _targetCalories = 0.0;

  void _calculateCalories() {
    if (_weightController.text.isEmpty) {
      _showErrorDialog('Please enter your weight.');
      return;
    }

    if (_heightController.text.isEmpty) {
      _showErrorDialog('Please enter your height.');
      return;
    }

    if (_ageController.text.isEmpty) {
      _showErrorDialog('Please enter your age.');
      return;
    }

    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;
    int age = int.tryParse(_ageController.text) ?? 0;

    double bmr = calculateBMR(weight, height, age, _selectedGender);
    double activityMultiplier = getActivityMultiplier(_selectedActivityLevel);

    setState(() {
      _maintenanceCalories = bmr * activityMultiplier;
      _targetCalories = _maintenanceCalories -
          200; // Subtract 200 kcal for weight loss target
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  double calculateBMR(double weight, double height, int age, String gender) {
    if (gender.toLowerCase() == 'male') {
      return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else if (gender.toLowerCase() == 'female') {
      return 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    } else {
      throw ArgumentError('Invalid gender specified. Use "male" or "female".');
    }
  }

  double getActivityMultiplier(String activityLevel) {
    switch (activityLevel.toLowerCase()) {
      case 'sedentary':
        return 1.2;
      case 'lightly active':
        return 1.375;
      case 'moderately active':
        return 1.55;
      case 'very active':
        return 1.725;
      case 'extra active':
        return 1.9;
      default:
        throw ArgumentError('Invalid activity level specified.');
    }
  }

  void _navigateToDietPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DietPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calories Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade800,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade700,
              Colors.red.shade500,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
              ),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
              ),
              _buildTextField(
                controller: _ageController,
                label: 'Age',
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: 'Gender',
                value: _selectedGender,
                items: ['male', 'female'],
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildDropdown(
                label: 'Activity Level',
                value: _selectedActivityLevel,
                items: [
                  'sedentary',
                  'lightly active',
                  'moderately active',
                  'very active',
                  'extra active'
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedActivityLevel = value!;
                  });
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _calculateCalories,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your maintenance calories are approximately: ${_maintenanceCalories.toStringAsFixed(2)} kcal/day',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Your target calories for weight loss are: ${_targetCalories.toStringAsFixed(2)} kcal/day',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _navigateToDietPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          labelStyle: TextStyle(color: Colors.grey[800]),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: Colors.white,
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
              underline: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
