import 'package:ecommerce_app/customer/screens/auth_screens/forget_password_screen.dart';
import 'package:ecommerce_app/customer/screens/auth_screens/sign_in_screen.dart';
import 'package:ecommerce_app/customer/screens/auth_screens/sign_up_screen.dart';
import 'package:ecommerce_app/customer/screens/main_screen.dart';
import 'package:ecommerce_app/customer/services/auth_services.dart';
import 'package:flutter/material.dart';

class OnClick {
  static void onSignUpClick(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    TextEditingController _emailController,
    TextEditingController _passwordController,
    TextEditingController _confirmPasswordController,
    TextEditingController _nameController,
    bool _checkvalue,
  ) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    if (_formKey.currentState!.validate()) {
      if (!_checkvalue) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to our terms.')),
        );
        return;
      }

      _formKey.currentState!.save();

      try {
        String result =
            await AuthServices.instance.signUpUserWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
        );

        if (result == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up successfully!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign up failed!')),
        );
        print('Error during sign up: $e');
      }
    }
  }

  static void onSignInClick(
      BuildContext context,
      GlobalKey<FormState> _formKey,
      TextEditingController _emailController,
      TextEditingController _passwordController) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      try {
        String result =
            await AuthServices.instance.signInUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (result == 'success') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          ); // Hiển thị thông báo lỗi từ AuthServices
        }
      } catch (e) {
        // Xử lý lỗi
        print('Error during sign in: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sign in failed!')),
        );
      }
    }
  }

  static void resetPassword(BuildContext context, GlobalKey<FormState> _formkey,
      TextEditingController _emailController) async {
    final email = _emailController.text;
    if (_formkey.currentState!.validate()) {
      try {
        String? result =
            await AuthServices.instance.sendPasswordResetEmail(email: email);
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Password reset email sent. Please check your inbox.')),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  static void navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  static void navigateToSignIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  static void navigateToSignOut(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  static void navigateToForgotPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen(),
      ),
    );
  }
}
