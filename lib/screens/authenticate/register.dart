import 'package:flutter/material.dart';
import 'package:vacationapp/shared/loading.dart';

import '../../shared/colors.dart';
import '../../models/user_model.dart';
import '../../services/auth.dart';
import '../../widgets/form_text_field.dart';
import '../../widgets/custom_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  //state
  String error = '';
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: CustomColors.color1, //change your color here
              ),
              backgroundColor: CustomColors.color2,
              elevation: 0.0,
              actions: [],
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
                          alignment: Alignment.centerRight,
                          child: const Text(
                            "Register",
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
                        CustomTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          obscureText: false,
                        ),
                        CustomTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          obscureText: false,
                        ),
                        const SizedBox(height: 50),
                        // LoginButton(onTap: signUserIn),
                        CustomButton(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              UserModel? result =
                                  await _auth.registerWithEamilAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                      firstNameController.text,
                                      lastNameController.text);
                              if (result == null) {
                                setState(() {
                                  error = "Error while registering!";
                                  loading = false;
                                });
                              } else {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            }
                          },
                          label: "Register now",
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
                            const Text("Already have an account?"),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Sign in",
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
