import 'package:e_poster/view/sign_in_view.dart';

import '../services/auth_service.dart';
import '../view/create_post_view.dart';
import '../view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Reusable Code of Drawer
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'E Poster App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_a_photo),
            title: const Text('Create Post'),
            onTap: () {
              Get.off(const CreatePostView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_agenda),
            title: const Text('View All Post'),
            onTap: () {
              Get.off(const HomeView());
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () async {
              await AuthService().signOut();
              Get.off(SignInView());
            },
          ),
        ],
      ),
    );
  }
}
