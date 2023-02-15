import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase/auth.dart';
import '../../../services/firebase/database.dart';
import '../../../utils/error_util.dart';
import '../../../utils/theme/theme_provider.dart';
import '../../../utils/user/user_provider.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/scaffold_wrapper.dart';
import "../../../widgets/custom_avatar_photo.dart";

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

// check user email verification
  @override
  Widget build(BuildContext context) {
    final User user = getUser(context)!;

    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
        appBar: CustomAppBar(
          context: context,
          title: "Profile",
          widget: PopupMenuButton(
            onSelected: (result) async {
              if (result == 0) {
                // Navigator.pushNamed(context, Routes.settings);
                ErrorUtil.showErrorDialog(context,
                    "This feature of changing the user setting not yet done.");
              } else if (result == 1) {
                await _auth.signOut(context);
              }
            },
            itemBuilder: (cnx) => [
              const PopupMenuItem(
                value: 0,
                child: Text("Settings"),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text("Logout"),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ),
        child: FutureBuilder(
          future: DatabaseService(uid: user.uid).userData,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Internet Issue"),
              );
            }

            if (snapshot.hasData) {
              final myData = snapshot.data;
              if (myData?.data() != null) {
                final data = myData?.data() as Map<String, dynamic>;

                return ListView(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    CustomAvatarPhoto(data: data),
                    const SizedBox(
                      height: 16,
                    ),
                    // todo: this part is not appear in some devices
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data["username"] ?? 'UserName',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data["email"] ?? "user@gmail.com",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              data["phone"] ?? ' +123456789',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Loading();
              }
            } else {
              return const Loading();
            }
          },
        ),
      ),
    );
  }
}
