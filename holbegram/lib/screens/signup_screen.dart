import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart'; // Import the TextFieldInput widget
import 'login_screen.dart'; // Import your login screen for navigation

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true; // Password visibility is initially enabled
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28),

              // App title
              const Text(
                'Holbegram',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50,
                ),
              ),

              const SizedBox(height: 28),
              
              // Email TextFieldInput
              TextFieldInput(
                controller: emailController,
                isPassword: false,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 24),

              // Username TextFieldInput
              TextFieldInput(
                controller: usernameController,
                isPassword: false,
                hintText: 'Full Name',
                keyboardType: TextInputType.text,
              ),

              const SizedBox(height: 24),


              // Password TextFieldInput with toggle visibility
              TextFieldInput(
                controller: passwordController,
                isPassword: !_passwordVisible,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Confirm Password TextFieldInput
              TextFieldInput(
                controller: passwordConfirmController,
                isPassword: !_passwordVisible,
                hintText: 'Confirm Password',
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 28),

              // Sign Up Button
              SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(218, 226, 37, 24),
                    ),
                  ),
                  onPressed: () {
                    // Add sign-up logic here
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Navigate to Login Screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 226, 37, 24),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
