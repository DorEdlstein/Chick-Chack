import 'package:chick_chack_beta/main.dart';
import 'package:chick_chack_beta/models/user.dart';
import 'package:chick_chack_beta/screens/application_main.dart';
import 'package:chick_chack_beta/screens/signin.dart';
import 'package:chick_chack_beta/styles/styled_text.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enterdEmail = '';
  var _enterdPassword = '';

  bool _isObscure = true;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return; // תרשום מתחת לקלט מדוע הקלט לא עבר ולידציה (ולא התחברות!!!)
    }
    if(isValid){
      _formKey.currentState!.save();
    }
    try {
      // try to sign in
      print('EMAIL: $_enterdEmail');
      print('PASS: $_enterdPassword');
      final userCredentails = await _firebase.signInWithEmailAndPassword(
          email: _enterdEmail, password: _enterdPassword);
      print(userCredentails);

      //-----------------------whensuccesfullsignin
      setState(() {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: StyledText(
              outText: 'Log-in succesfull $_enterdEmail'.toUpperCase(),
              size: 18,
              color: kColorScheme.primaryContainer,
            ),
          ),
        );
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const MainApp(
              // UserCC(
              //   name: 'placeHolder12354',
              //   email: _enterdEmail,
              //   password: _enterdPassword,
              // ),
              ),
        ),
      );
    } on FirebaseAuthException catch (error) {
      print('erroorr');
      if (error.code == 'wrong-password') {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'WORNG PASSWORD',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        title: StyledText(
          outText: 'LOGIN PAGE',
          size: 40,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //     icon: const Icon(Icons.arrow_back),
      //   ),
      // ],
      //backgroundColor: Colors.green,
      body: SingleChildScrollView(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 7 ||
                        value.trim().length > 50 ||
                        value.contains('@') == false) {
                      return 'Must be a valid FORMAT => ex. xxx@gmail.com';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enterdEmail = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          label: const Text('Password'),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().length <= 5 ||
                              value.trim().length > 50) {
                            return 'invalid password!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enterdPassword = value!;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      child: const StyledText.white(
                        'Login',
                        size: 30,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignInScreen()));
                      },
                      child: const Text(
                        'Register here!',
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
