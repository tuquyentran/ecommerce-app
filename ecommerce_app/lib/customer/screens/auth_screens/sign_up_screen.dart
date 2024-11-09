import 'package:ecommerce_app/config/on_click.dart';
import 'package:ecommerce_app/config/validators.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/config/const.dart';
import 'package:ecommerce_app/customer/screens/auth_screens/sign_in_screen.dart';
import 'package:ecommerce_app/customer/services/auth_services.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _checkvalue = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 24.0),
            alignment: Alignment.topCenter,
            child: Image.network(
              "https://random.dog/3f62f2c1-e0cb-4077-8cd9-1ca76bfe98d5.jpg",
              height: 150,
            ),
          ),
          // Image.asset(
          //   'assets/images/dailyplanner.png',
          //   height: 150,
          // ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight / 4),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Center(
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Sign Up',
                                        style: textStyle45,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      //txtf name
                                      TextFormField(
                                        keyboardType: TextInputType.name,
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: icon,
                                          ),
                                          labelText: 'Name',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      //txtf email
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _emailController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: icon,
                                          ),
                                          labelText: 'Email',
                                        ),
                                        validator: Validators.validateEmail,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      //txtf pw
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _passwordController,
                                        obscureText: _obscureTextPassword,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          border: const OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: icon,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              onObscureTextPassword();
                                            },
                                            child: Icon(
                                              _obscureTextPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: icon,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          return Validators.validatePassword(
                                              value);
                                        },
                                      ),
                                      const SizedBox(height: 30),
                                      //txtf cpw
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        controller: _confirmPasswordController,
                                        obscureText:
                                            _obscureTextConfirmPassword,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          border: const OutlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.transparent,
                                          prefixIcon: const Icon(
                                            Icons.lock,
                                            color: icon,
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              onObscureTextConfirmPassword();
                                            },
                                            child: Icon(
                                              _obscureTextConfirmPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: icon,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          return Validators
                                              .validateConfirmPassword(
                                                  value, _passwordController);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: _checkvalue,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _checkvalue = value!;
                                        });
                                      },
                                      activeColor: Colors
                                          .black, // Màu của checkbox khi được chọn
                                      checkColor: Colors
                                          .white, // Màu của dấu check khi được chọn
                                    ),
                                    const Text(
                                      "You agree to",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: branchColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         const SignUpScreen(),
                                        //   ),
                                        // );
                                      },
                                      child: const Text(
                                        'Our terms',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //btn
                                InkWell(
                                  onTap: () {
                                    OnClick.onSignUpClick(
                                      context,
                                      _formKey,
                                      _emailController,
                                      _passwordController,
                                      _confirmPasswordController,
                                      _nameController,
                                      _checkvalue,
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: icon,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            color: btnText,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Already have an account?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: branchColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        OnClick.navigateToSignIn(context);
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void onObscureTextPassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void onObscureTextConfirmPassword() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
