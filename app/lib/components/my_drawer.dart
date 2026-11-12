import 'package:flutter/material.dart';
import 'package:test/admin/profile_page.dart';
import 'package:test/components/my_drawer_tile.dart';
import 'package:test/pages/settings_page.dart';
import 'package:test/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          //logo
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Icon(
              Icons.lock_open_rounded,
              size: 80,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          //profile
          MyDrawerTile(
            text: "P R O F I L E",
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
          //home
          MyDrawerTile(
            text: "H O M E",
            icon: Icons.home,
            onTap: () => Navigator.pop(context),
          ),
          //settings
          MyDrawerTile(
            text: "S E T T I N G S",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),

          const Spacer(),
          //logout
          MyDrawerTile(text: "L O G O U T", icon: Icons.logout, onTap: logout),

          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
