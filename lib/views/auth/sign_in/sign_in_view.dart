import 'package:flutter/material.dart';

import '../sign_up/sign_up_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

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
      // Perform login
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/icons/icon.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
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
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: _validateAndSubmit,
                    child: const Text('Sign In'),
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
                    label: const Center(child: Text('Sign In With Google')),
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
                    label: const Center(child: Text('Sign In With Facebook')),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Don't have an account ",
                  style: TextStyle(
                    height: 1.5,
                    decoration: TextDecoration.underline,
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
                InkWell(
                  child: const Text(
                    "SIGN UP NOW",
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 33, 33, 33),
                    ),
                  ),
                  onTap: () {
                    // perform action when "SIGN UP NOW" is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpView(),
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
