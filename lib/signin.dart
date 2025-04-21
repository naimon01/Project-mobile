import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:projectmobile/main_dashboard.dart';
import 'package:projectmobile/signup.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 130),
            // Divider line
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
              margin: const EdgeInsets.symmetric(horizontal: 25),
            ),
            const SizedBox(height: 20),
            // Sign in form
            Container(
              padding: const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 20.0),
              child: Form(
                key: _formSignInKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Email'),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[300]!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[300]!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[500]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        labelStyle: TextStyle(color: Colors.green[700]),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[300]!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[300]!,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green[500]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberPassword,
                              onChanged: (bool? value) {
                                setState(() {
                                  rememberPassword = value!;
                                });
                              },
                              activeColor: Colors.green[700],
                            ),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        onPressed: () async {
                          if (_formSignInKey.currentState!.validate()) {
                            try {
                              final userCredential = await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                              final user = userCredential.user;

                              if (user != null) {
                                String userName = user.email?.split('@').first ?? 'User';
                                String userEmail = user.email ?? 'No email';

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainDashboard(
                                      userName: userName,
                                      userEmail: userEmail,
                                    ),
                                  ),
                                );
                              } else {
                                throw Exception('Sign in Failed');
                              }
                            } catch (e) {
                              print('Error: ${e}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error: ${e}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 10,
                          ),
                          child: Text(
                            'Or sign in with',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Social media icons can be added here if needed
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Create Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Learn more about our technology',
                      style: TextStyle(
                        color: Colors.green[700],
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Chip(
      backgroundColor: Colors.green[50],
      label: Text(
        text,
        style: TextStyle(color: Colors.green[700]),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.green[200]!),
      ),
    );
  }
}