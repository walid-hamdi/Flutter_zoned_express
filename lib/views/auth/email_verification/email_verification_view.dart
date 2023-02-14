import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoned_express/services/firebase/database.dart';
import 'package:zoned_express/utils/user/user_provider.dart';

import '../../../services/firebase/auth.dart';
import '../../../utils/theme/theme_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/scaffold_wrapper.dart';

class EmailVerificationView extends StatelessWidget {
  EmailVerificationView({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final User user = getUser(context)!;

    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
        appBar: AppBar(
          title: const Text("Email Verification"),
        ),
        child: CustomContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Please verify your email address. (${user.email})"),
              const SizedBox(height: 20.0),
              CustomButton(
                label: "Resend Verification Email",
                onPressed: () {
                  // code to send email verification
                  user.sendEmailVerification();
                },
              ),
              const SizedBox(height: 5),
              CustomButton(
                label: "Open Mail",
                onPressed: () async {
                  final mailTo = Uri.parse("mailto:");
                  if (await canLaunchUrl(mailTo)) {
                    await launchUrl(mailTo);
                  } else {
                    // String errorMessage = 'Could not launch $mailTo';
                    // debugPrint(errorMessage);
                  }
                },
              ),
              const SizedBox(height: 5),
              CustomButton(
                label: "Logout",
                onPressed: () async {
                  await _auth.signOut(context);
                },
              ),
              const SizedBox(height: 5),
              CustomButton(
                backgroundColor: Colors.red[700],
                label: "Delete Account",
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                          'Are you sure you want to delete your account?'),
                      // content: Text(errorMessage),
                      actions: [
                        ElevatedButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            debugPrint("Cancel");
                          },
                        ),
                        ElevatedButton(
                          child: const Text('Delete'),
                          onPressed: () async {
                            await FirebaseAuth.instance.currentUser!
                                .delete()
                                .whenComplete(() async {
                              await _db
                                  .deleteUser(
                                context: context,
                                userId: user.uid,
                              )
                                  .whenComplete(() {
                                _auth.signOut(context);

                                Navigator.of(context).pop();
                                debugPrint("delete");
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
