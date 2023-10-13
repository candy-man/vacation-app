import 'package:flutter/material.dart';
import 'package:vacationapp/services/database.dart';
import 'package:vacationapp/shared/colors.dart';
import 'package:vacationapp/screens/authenticate/register.dart';
import 'package:vacationapp/services/auth.dart';
import 'package:vacationapp/shared/loading.dart';
import '../../models/user_model.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/custom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //state
  String error = '';
  bool loading = false;

  // void signUserIn() async {
  //   await _auth.signInAnon();
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: CustomColors.color2,
              elevation: 0.0,
            ),
            backgroundColor: CustomColors.color2,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(height: 50),
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 120,
                          color: CustomColors.color1,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Vacation app",
                            style: TextStyle(
                              color: CustomColors.color1,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 50),
                        CustomButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              UserModel? result =
                                  await _auth.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);
                              if (result == null) {
                                setState(() {
                                  error = "Wrong credentials!";
                                  loading = false;
                                });
                              }
                            }
                          },
                          label: "Sing In",
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 15.0),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Register()),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    color: CustomColors.color1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
