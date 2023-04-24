import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  //// controllers
  final _userPasswordController = TextEditingController();
  final _userName = TextEditingController();
  final _userEmail = TextEditingController();

  //// for Security
  @override
  void dispose() {
    _userEmail;
    _password;
    _userName;
    super.dispose();
  }

//// password strength checking
  late String _password;
  double _strength = 0;
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  // 1: Great

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void _checkPassword(String value) {
    _password = value.trim();

    if (_password.isEmpty) {
      setState(() {
        _strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        _strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        _strength = 2 / 4;
      });
    } else {
      if (!letterReg.hasMatch(_password) || !numReg.hasMatch(_password)) {
        setState(() {
          _strength = 3 / 4;
        });
      } else {
        setState(() {
          _strength = 1;
        });
      }
    }
  }

  //// Check box
  var _checkbox = false;

  bool signUpButton() {
    if (_checkbox == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //// sign in text
                  const SizedBox(height: 20),
                  const Text(
                    "Sign up",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //// outline with image button (Google signUp)
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        style: const ButtonStyle(
                          iconColor: MaterialStatePropertyAll(Colors.grey),
                          iconSize: MaterialStatePropertyAll(35),
                        ),
                        icon: const Icon(
                          Icons.email,
                        ),
                        onPressed: () {},
                        label: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            "Sign up with Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// line
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// name text filed
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Leslie Alexander',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// email text filed
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'example@email.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// password text filed
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    autocorrect: false,
                    onChanged: (value) {
                      _checkPassword(_userPasswordController.text);
                    },
                    keyboardType: TextInputType.text,
                    controller: _userPasswordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'at least 8 charecters',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// The strength indicator bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 5,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _strength >= 0.5
                              ? Colors.blue[200]
                              : Colors.grey[400],
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 5,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _strength >= 0.5
                              ? Colors.yellow[600]
                              : Colors.grey[400],
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 5,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _strength >= 0.75
                              ? Colors.green[400]
                              : Colors.grey[400],
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        height: 5,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: _strength == 1.0
                              ? Colors.green[600]
                              : Colors.grey[400],
                        ),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// agree checkbox
                  Row(children: [
                    Checkbox(
                      value: _checkbox,
                      onChanged: (value) => setState(() {
                        _checkbox == true
                            ? _checkbox = false
                            : _checkbox = true;
                      }),
                    ),
                    const Text(
                      "I agree with",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Terms",
                          style: TextStyle(fontSize: 20.0),
                        )),
                    const Text(
                      "and",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Privacy",
                          style: TextStyle(fontSize: 20.0),
                        )),
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  //// sign up button with elivated  button
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    onPressed: signUpButton() ? () {} : null,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //// login
                  Center(
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 20, color: Colors.grey[750]),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
