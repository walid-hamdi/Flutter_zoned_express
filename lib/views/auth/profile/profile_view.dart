import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoned_express/utils/constants.dart';

import '../../../services/database.dart';
import '../../../widgets/custom_appbar.dart';
// import '../../widgets/custom_container.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/scaffold_wrapper.dart';
import '../../../widgets/cached_image.dart';
import '../settings/settings_view.dart';
import "../../../services/auth.dart";

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return ScaffoldWrapper(
      appBar: CustomAppBar(
        context: context,
        title: "Profile",
        widget: PopupMenuButton(
          onSelected: (result) async {
            if (result == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            } else if (result == 1) {
              await _auth.signOut();
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
          future: DatabaseService(uid: user?.uid).userData,
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) return const Text("Error");

            if (snapshot.hasData) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: CachedNetworkImageWidget(
                      imageUrl: data["photo"] ?? defaultProfilePlaceholderPhoto,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 40,
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const SizedBox(
                        height: 90,
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Container(
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
                  ),
                ],
              );
            } else {
              return const Loading();
            }
          }),
    );
  }
}
