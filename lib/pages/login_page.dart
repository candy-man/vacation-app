// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:vacationapp/shared/colors.dart';
// import '../widgets/custom_button.dart';
// import '../widgets/form_text_field.dart';

// class LoginPage extends StatefulWidget {
//   final Function()? onTap;

//   const LoginPage({super.key, this.onTap});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   //text editing controllers
//   final emailController = TextEditingController();

//   void signUserIn() async {
//     //show loading circle
//     showDialog(
//         context: context,
//         builder: (context) {
//           return const Center(child: CircularProgressIndicator());
//         });
//     // try sing in
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: emailController.text, password: passwordController.text);
//       // pop the loading
//       if (!mounted) return;
//       Navigator.pop(context);
//     } on FirebaseAuthException catch (e) {
//       // pop the loading
//       Navigator.pop(context);
//       // show erro message
//       //IF (E.CODE == 'USER-NOT FOUND)
//       showErrorMessage(e.code);
//     }

// // try {
// //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
// //     email: emailAddress,
// //     password: password
// //   );
// // } on FirebaseAuthException catch (e) {
// //   if (e.code == 'user-not-found') {
// //     print('No user found for that email.');
// //   } else if (e.code == 'wrong-password') {
// //     print('Wrong password provided for that user.');
// //   }
// // }
//   }

//   void showErrorMessage(String message) {
//     showDialog(
//         useRootNavigator: false,
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.deepPurple,
//             title: Center(
//               child: Text(
//                 message,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           );
//         });
//   }

//   // void wrongPasswordMessage() {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return const AlertDialog(
//   //           title: Text('Incorrect Password'),
//   //         );
//   //       });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomColors.color1,
//       // backgroundColor: Colors.grey[300],
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),
//                 // logo
//                 const Icon(
//                   Icons.calendar_month_outlined,
//                   size: 120,
//                   color: CustomColors.color2,
//                 ),
//                 const SizedBox(height: 50),
//                 // welcome back
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                   alignment: Alignment.centerLeft,
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(
//                       color: CustomColors.color2,
//                       fontSize: 30,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 //username
//                 CustomTextField(
//                   controller: emailController,
//                   hintText: 'Email',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 10),
//                 // password texfield
//                 CustomTextField(
//                   controller: passwordController,
//                   hintText: 'Password',
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 10),
//                 // forgot password
//                 const Padding(
//                   padding: EdgeInsets.all(25.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     // children: [
//                     //   Text(
//                     //     'Forgote Password?',
//                     //     style: TextStyle(color: Colors.grey[600]),
//                     //   ),
//                     // ],
//                   ),
//                 ),
//                 //sign in button
//                 // LoginButton(
//                 //   onTap: signUserIn,
//                 // ),
//                 const SizedBox(height: 30),
//                 // or continue with
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                 //   child: Row(
//                 //     children: [
//                 //       Expanded(
//                 //         child: Divider(
//                 //           thickness: 0.5,
//                 //           color: Colors.grey[400],
//                 //         ),
//                 //       ),
//                 //       Padding(
//                 //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 //         child: Text(
//                 //           "Or continue with",
//                 //           style: TextStyle(
//                 //             color: Colors.grey[700],
//                 //           ),
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         child: Divider(
//                 //           thickness: 0.5,
//                 //           color: Colors.grey[400],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 const SizedBox(height: 80),
//                 // google + apple sign in
//                 // const Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     SquareTile(imagePath: 'lib/assets/images/google.png'),
//                 //     SizedBox(
//                 //       width: 10,
//                 //     ),
//                 //     SquareTile(imagePath: 'lib/assets/images/apple.png'),
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 30),
//                 // // not a memeaer? register now
//                 // Row(
//                 //   mainAxisAlignment: MainAxisAlignment.center,
//                 //   children: [
//                 //     Text(
//                 //       'Not a memeber?',
//                 //       style: TextStyle(
//                 //         color: Colors.grey[700],
//                 //       ),
//                 //     ),
//                 //     const SizedBox(width: 4),
//                 //     GestureDetector(
//                 //       onTap: widget.onTap,
//                 //       child: const Text(
//                 //         'Register now',
//                 //         style: TextStyle(
//                 //           color: Colors.blue,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     )
//                 //   ],
//                 // ),
//                 // const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
