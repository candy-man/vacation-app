// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vacationapp/services/database.dart';
// import 'package:vacationapp/shared/loading.dart';

// import '../../models/user_model.dart';
// import '../../shared/colors.dart';
// import '../../shared/constants.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/form_text_field.dart';

// class SettingsForm extends StatefulWidget {
//   const SettingsForm({super.key});

//   @override
//   State<SettingsForm> createState() => _SettingsFormState();
// }

// class _SettingsFormState extends State<SettingsForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];

//   //form controllers
//   final currentNameController = TextEditingController();
//   String? _currentSugarsController;
//   int? _currentStrenghtController;
//   // String _currentName = "";
//   // String _currentSugars = "";
//   // final int _currentStrenght = 0;

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel?>(context);

//     return StreamBuilder<UserData>(
//         stream: DatabaseService(uid: user!.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserData userData = snapshot.data!;

//             currentNameController.text = userData.name;

//             return Form(
//               key: _formKey,
//               child: Column(children: [
//                 const Text(
//                   "Update your brew settings",
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 const SizedBox(height: 20.0),
//                 CustomTextField(
//                   controller: currentNameController,
//                   hintText: 'Please enter a name',
//                   obscureText: false,
//                 ),
//                 const SizedBox(height: 20.0),
//                 // dropdown
//                 DropdownButtonFormField(
//                   decoration: textInputDecoration,
//                   // value: _currentSugarsController ?? userData.sugars,
//                   items: sugars.map((sugar) {
//                     return DropdownMenuItem(
//                       value: sugar,
//                       child: Text('$sugar sugars'),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _currentSugarsController = value;
//                     });
//                   },
//                 ),
//                 // slider
//                 Slider(
//                     min: 100,
//                     max: 900,
//                     divisions: 8,
//                     activeColor: Colors.brown,
//                     inactiveColor: Colors
//                         .brown[_currentStrenghtController ?? userData.strength],
//                     value: (_currentStrenghtController ?? userData.strength)
//                         .toDouble(),
//                     onChanged: (value) {
//                       setState(() {
//                         _currentStrenghtController = value.round();
//                       });
//                     }),

//                 CustomButton(
//                   onTap: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await DatabaseService(uid: userData.uid).updateUserData(
//                           _currentSugarsController ?? userData.sugars,
//                           currentNameController.text,
//                           _currentStrenghtController ?? userData.strength);
//                     }
//                     Navigator.pop(context);
//                     print(currentNameController.text);
//                     print(_currentSugarsController);
//                     print(_currentStrenghtController);
//                   },
//                   label: "Update",
//                 )
//               ]),
//             );
//           } else {
//             return const Loading();
//           }
//         });
//   }
// }
