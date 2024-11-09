import 'package:ecommerce_app/config/const.dart';
import 'package:ecommerce_app/config/on_click.dart';
import 'package:ecommerce_app/config/validators.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureTextPassword = true;
  final _formKey = GlobalKey<FormState>();

  void onObscureTextPassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
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
          LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.only(top: screenHeight / 3.2),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Center(
                            child: Column(
                              children: [
                                const Text(
                                  'Sign In',
                                  style: textStyle45,
                                ),
                                const SizedBox(height: 30),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
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
                                      const SizedBox(height: 30),
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
                                      const SizedBox(height: 10),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            OnClick.navigateToForgotPassword(
                                                context);
                                          },
                                          child: const Text(
                                            'Forget Password?',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      //btn login
                                      InkWell(
                                        onTap: () {
                                          OnClick.onSignInClick(
                                              context,
                                              _formKey,
                                              _emailController,
                                              _passwordController);
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: icon,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                  color: btnText,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      const Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              thickness: 0.5,
                                              color: branchColor60,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text('OR',
                                                style: TextStyle(color: text)),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              thickness: 0.5,
                                              color: branchColor60,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // dang nhap ben t3
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     IconButton(
                                      //      onPressed: () async {
                                      //         UserCredential? user =
                                      //             await AuthServices
                                      //                 .instance
                                      //                 .signInWithGoogle();
                                      //         debugPrint(user.toString());
                                      //         if (user != null) {
                                      //           await AuthServices.instance
                                      //               .createUser(
                                      //                   user: user.user,
                                      //                   context: context);
                                      //         }
                                      //       },
                                      //       icon: Image.network(
                                      //         'http://pngimg.com/uploads/google/google_PNG19635.png',
                                      //         width: 50,
                                      //         height: 50,
                                      //       ),
                                      //     ),
                                      //     IconButton(
                                      //       onPressed: () async {
                                      //         UserCredential? user =
                                      //             await AuthServices
                                      //                 .instance
                                      //                 .signInWithFacebook(
                                      //                     context);
                                      //         debugPrint(user.toString());
                                      //         if (user != null) {
                                      //           await AuthServices.instance
                                      //               .createUser(
                                      //                   user: user.user,
                                      //                   context: context);
                                      //         }
                                      //       },
                                      //       icon: Image.network(
                                      //         'https://pngimg.com/uploads/facebook_logos/facebook_logos_PNG19754.png',
                                      //         width: 50,
                                      //         height: 50,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Don't have an account?",
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
                                              OnClick.navigateToSignUp(context);
                                            },
                                            child: const Text(
                                              'Sign Up',
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
}
