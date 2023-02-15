// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// import '../../../services/firebase/database.dart';
// import '../../../utils/languages/local_notifier.dart';
// import '../../../utils/languages/my_app_localizations.dart';
// import '../../../utils/theme/theme_provider.dart';
// import '../../../utils/user/user_provider.dart';
// import '../../../widgets/custom_avatar_photo.dart';
// import '../../../widgets/loading.dart';
// import '../../../widgets/scaffold_wrapper.dart';
// import '../../../widgets/custom_button.dart';
// import '../../../widgets/custom_input_field.dart';
// import "../../../widgets/custom_switch.dart";
// import 'widgets/language_option.dart';

// class SettingsView extends StatefulWidget {
//   const SettingsView({Key? key}) : super(key: key);

//   @override
//   createState() => _SettingsViewState();
// }

// class _SettingsViewState extends State<SettingsView> {
//   final _formKey = GlobalKey<FormState>();
//   String? _photo;
//   String? _username;
//   String? _phone;
//   Locale? _selectedLocale;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedLocale = const Locale('en', 'US');
//   }

//   _onChangeUsername(String? val) {
//     setState(() {
//       _username = val;
//     });
//   }

//   _onChangePhone(String? val) {
//     setState(() {
//       _phone = val;
//     });
//   }

//   void _selectLanguage(Locale? locale) {
//     setState(() {
//       _selectedLocale = locale;
//     });
//     Provider.of<LocaleNotifier>(context, listen: false).setLocale(locale!);
//   }

//   onChangedTheme(bool value) {
//     toggleTheme(context);
//   }

//   String? _usernameValidator(String? val) =>
//       val!.isEmpty ? "Enter username" : null;

//   String? _phoneValidator(String? val) => val!.isEmpty ? "Enter phone" : null;

//   @override
//   Widget build(BuildContext context) {
//     final User? user = getUser(context);

//     return Theme(
//       data: getTheme(context),
//       child: _loading
//           ? const Center(
//               child: Loading(),
//             )
//           : ScaffoldWrapper(
//               appBar: AppBar(
//                 title: Text(MyAppLocalizations.of(context)?.settingsTitle ??
//                     "Settings"),
//               ),
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 alignment: Alignment.center,
//                 child: SingleChildScrollView(
//                   child: FutureBuilder(
//                     future: DatabaseService(uid: user?.uid).userData,
//                     builder: (BuildContext context,
//                         AsyncSnapshot<DocumentSnapshot> snapshot) {
//                       if (snapshot.hasError) {
//                         return const Center(
//                           child: Text("Internet Issue"),
//                         );
//                       }

//                       if (snapshot.hasData) {
//                         Map<String, dynamic> data =
//                             snapshot.data!.data() as Map<String, dynamic>;

//                         return Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               CustomAvatarPhoto(
//                                 data: data,
//                                 mutable: true,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               CustomInputField(
//                                 initialValue: data["username"],
//                                 hintText: "Username",
//                                 icon: Icons.person,
//                                 onChange: _onChangeUsername,
//                                 validator: _usernameValidator,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               CustomInputField(
//                                 initialValue: data["phone"],
//                                 hintText: "Phone",
//                                 icon: Icons.phone,
//                                 onChange: _onChangePhone,
//                                 validator: _phoneValidator,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               CustomButton(
//                                 onPressed: _updateOnPressed,
//                                 label: "Update",
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   LanguageOption(
//                                     selectedLanguage: _selectedLocale!,
//                                     onChangeLanguage: _selectLanguage,
//                                   ),
//                                   CustomSwitch(
//                                     value: !isDarkMode(context),
//                                     onChanged: (bool value) {
//                                       setState(() {
//                                         toggleTheme(context);
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                             ],
//                           ),
//                         );
//                       } else {
//                         return const Center(
//                           child: Loading(),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   _updateOnPressed() async {
//     if (_formKey.currentState!.validate()) {
//       // setState(() {
//       //   _loading = true;
//       // });
//       // final User? user = getUser(context);

//       // await DatabaseService()
//       //     .updateUserInfo(
//       //   context: context,
//       //   userId: user!.uid,
//       //   username: _username ?? "",
//       //   phone: _phone ?? "",
//       //   photo: _photo ?? "",
//       //   email: user.email ?? "",
//       // )
//       //     .whenComplete(
//       //   () {
//       //     setState(() {
//       //       _loading = false;
//       //     });
//       //     Navigator.pop(context);
//       //   },
//       // );

//       // TODO: change it later for update user info
//       debugPrint("Update user data");
//     }
//   }
// }
