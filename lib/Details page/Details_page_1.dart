import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Details%20page/Details_page_2.dart'; // Import the details_page_2.dart

class UserInfoForm extends StatefulWidget {
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String? age;
  String? weight;
  String? height;
  String? favoriteSport;
  String? foodAllergy;
  String? physicalActivity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          'User Info Form',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.purple.shade600,
              Colors.pink.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextField(
                  label: 'What time do you usually go to bed?',
                  onSaved: (value) => age = value,
                ),
                _buildTextField(
                  label:
                      'How much time do you spend on screen activities (like watching TV or playing video games)?',
                  onSaved: (value) => weight = value,
                ),
                _buildTextField(
                  label: 'How many glasses of water do you drink each day?',
                  onSaved: (value) => height = value,
                ),
                _buildTextField(
                  label: 'What is your favorite sport?',
                  onSaved: (value) => favoriteSport = value,
                ),
                _buildTextField(
                  label: 'Do you have any food allergies? (If yes, list them.)',
                  onSaved: (value) => foodAllergy = value,
                ),
                _buildTextField(
                  label:
                      'Do you like to eat vegetables? (If yes, which vegetable do you like to eat?)',
                  onSaved: (value) => physicalActivity = value,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Navigate to DetailsPage2
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserInfoForm2(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF1A237E),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      shadowColor: const Color(0xFF3949AB).withOpacity(0.5),
                    ),
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required void Function(String?) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white70,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(16.0),
          labelStyle: const TextStyle(color: Colors.black),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}
