import 'package:flutter/material.dart';
import 'package:hedeyety2/pages/my_events.dart';
import '../app_colors.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/my_pledged_gifts_page.dart';
import '../pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  final bool theme;

  const MyDrawer({Key? key, this.theme = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: theme ? [AppColors.primaryDark, AppColors.secondaryDark] : [AppColors.secondaryDark, AppColors.secondaryLight],
              ),
              color: theme ? AppColors.thirdDark : AppColors.secondaryDark,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: theme ? AppColors.primaryDark : AppColors.textColor,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Handle Home tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));// Close the drawer
              // Navigate to Home screen
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Handle Profile tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())); // Close the drawer
              // Navigate to Profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text('My Pledged Gifts'),
            onTap: () {
              // Handle My Pledged Gifts tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => PledgesPage())); // Close the drawer
              // Navigate to My Pledged Gifts screen
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('My Events'),
            onTap: () {
              // Handle My Events tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage(isDarkMode: theme))); // Close the drawer
              // Navigate to My Events screen
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Log Out'),
            onTap: () {
              // Handle Log Out tap
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); // Close the drawer
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}