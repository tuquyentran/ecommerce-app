import 'package:ecommerce_app/config/const.dart';
import 'package:ecommerce_app/config/on_click.dart';
import 'package:ecommerce_app/config/validators.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isSendingEmail = false;
  int _secondsLeft = 30;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _isSendingEmail = false;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Password Recovery",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: background,
      ),
      backgroundColor: background,
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    //txtf email
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                    if (_isSendingEmail)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                          child: Text(
                            "Haven't received the mail yet? Resend after $_secondsLeft",
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    //btn
                    InkWell(
                      onTap: _isSendingEmail
                          ? null
                          : () {
                              setState(() {
                                _isSendingEmail = true;
                                _secondsLeft = 30;
                                _startTimer();
                              });
                              OnClick.resetPassword(
                                  context, _formkey, _emailController);
                            },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: _isSendingEmail ? Colors.grey : icon,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            _isSendingEmail ? 'Sending...' : 'Send Email',
                            style: const TextStyle(
                              color: btnText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
