import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/login page/widgets/rounded_circular_button.dart';
import 'package:gemini_chat_app_tutorial/login page/widgets/rounded_text_form_field.dart';
import 'package:gemini_chat_app_tutorial/Details page/Details_page_1.dart'; // Import UserInfoForm

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        _header(),
        _loginForm(),
      ],
    );
  }

  Widget _header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade800,
            Colors.purple.shade600,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.15,
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Expanded(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _formFields(),
              _bottomButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RoundedTextFormField(
          hintText: "Email Address",
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: 20),
        RoundedTextFormField(
          hintText: "Password",
          prefixIcon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => {},
            child: const Text(
              "Forgot Password?",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _bottomButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.06,
          child: RoundedCircularButton(
            text: "Sign In",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserInfoForm(),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () => {},
          child: const Text(
            "I Don't Have an Account",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
