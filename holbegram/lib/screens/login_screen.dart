import 'package:flutter/material.dart';
import 'package:holbegram/widgets/text_field.dart'; // Import the TextFieldInput widget
import 'signup_screen.dart'; // Import SignUpScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true; // Password is initially visible
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 28),

              // App name using Billabong font
              const Text(
                'Holbegram',
                style: TextStyle(
                  fontFamily: 'Billabong',
                  fontSize: 50,
                ),
              ),

              // Logo image
              Image.asset(
                'assets/images/logo.png', // Replace with your logo file path
                width: 80,
                height: 60,
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

              // Password TextFieldInput with suffix icon for visibility toggle
              TextFieldInput(
                controller: passwordController,
                isPassword: !_passwordVisible,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  alignment: Alignment.bottomLeft,
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

              const SizedBox(height: 28),

              // Login button
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
                    // To be implemented
                  },
                  child: const Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Forgot your login details
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Forgot your login details?'),
                  SizedBox(width: 4),
                  Text(
                    'Get help logging in',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Divider
              const Divider(thickness: 2),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        // Navigate to Sign Up Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // OR divider
              Row(
                children: [
                  const Flexible(
                    flex: 1,
                    child: Divider(thickness: 2),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('OR'),
                  ),
                  const Flexible(
                    flex: 1,
                    child: Divider(thickness: 2),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Sign in with Google
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/google.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  const Text('Sign in with Google'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
