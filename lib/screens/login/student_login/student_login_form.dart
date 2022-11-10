// import 'package:flutter/material.dart';

// class StudentLoginForm extends StatefulWidget {
//   const StudentLoginForm({super.key});

//   @override
//   State<StudentLoginForm> createState() => _StudentLoginFormState();
// }

// class _StudentLoginFormState extends State<StudentLoginForm> {
//   late String _name;
//   late String _email;
//   late String _password;
//   late String _phoneNumber;

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Widget _buildName() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: "Name"),
//       validator: (String? value) {
//         if (value != null) {
//           if (value.isEmpty) {
//             return 'Name is required';
//           }
//         }
//       },
//       onSaved: (String? value) {
//         if (value != null) _name = value;
//       },
//     );
//   }
// // Widget _buildEmail(){
// //   return null;
// // }
// // Widget _buildPassword(){
// //   return null;
// // }
// // Widget _buildPhoneNumber(){
// //   return null;
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(24),
//       child: Form(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _buildName(),
//             // _buildEmail(),
//             // _buildPassword(),
//             // _buildPhoneNumber(),
//             SizedBox(
//               height: 100,
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               child: Text(
//                 "Submit",
//                 style: TextStyle(color: Colors.blue, fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
