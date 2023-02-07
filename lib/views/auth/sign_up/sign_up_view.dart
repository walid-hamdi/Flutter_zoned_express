import 'dart:io';

import 'package:flutter/material.dart';

import '../sign_in/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  late String _password;
  late String _phoneNumber;
  late File _photo;

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _validateAndSubmit() async {
    if (_validateAndSave()) {
      // Perform sign up
      // ...
    }
  }

  Future<void> _pickPhoto() async {
    // pick a photo from the gallery
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.only(bottom: 16),
                //   child: InkWell(
                //     onTap: _pickPhoto,
                //     // child: _photo == null
                //     //     ? const CircleAvatar(
                //     //         radius: 50,
                //     //         child: Icon(Icons.add_a_photo),
                //     //       )
                //     //     : CircleAvatar(
                //     //         radius: 50,
                //     //         backgroundImage: FileImage(_photo),
                //     //       ),
                //   ),
                // ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _username = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: _validateAndSubmit,
                    child: const Text('Sign Up'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red[500] // Background color
                        ),
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/google_logo.png',
                      height: 30,
                      width: 30,
                    ),
                    label: const Center(child: Text('Sign Up With Google')),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue[600] // Background color
                        ),
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/facebook_logo.png',
                      height: 30,
                      width: 30,
                    ),
                    label: const Center(child: Text('Sign Up With Facebook')),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Have an account ",
                  style: TextStyle(
                    height: 1.5,
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
                InkWell(
                  child: const Text(
                    "SIGN IN NOW",
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 33, 33, 33),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
