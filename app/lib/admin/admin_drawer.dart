import 'package:flutter/material.dart';
import 'package:test/admin/analytics_page.dart';
import 'package:test/admin/marketing_page.dart';
import 'package:test/admin/profile_page.dart';
import 'package:test/components/my_drawer_tile.dart';
import 'package:test/pages/settings_page.dart';
import 'package:test/services/auth/auth_service.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

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
            text: "O R D E R S",
            icon: Icons.table_chart,
            onTap: () => Navigator.pop(context),
          ),
          //analytics
          MyDrawerTile(
            text: "A N A L Y T I C S",
            icon: Icons.signal_cellular_alt_sharp,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalyticsPage(),
                ),
              );
            },
          ),
          //marketing
          MyDrawerTile(
            text: "M A R K E T I N G",
            icon: Icons.campaign,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MarketingPage(),
                ),
              );
            },
          ),

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
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: logout,
          ),

          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
