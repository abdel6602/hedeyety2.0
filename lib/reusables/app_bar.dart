import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_colors.dart';

import '../pages/profile_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showProfilePicture;
  final String title;
  final bool isDarkMode;

  const CustomAppBar({super.key, required this.showProfilePicture, required this.title, required this.isDarkMode});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
      title: Text(title, style: TextStyle(
        color: isDarkMode ? Colors.black : AppColors.textColor,
      ),),
      leading: Builder(builder:
          (BuildContext context){
        return IconButton(
          icon: Icon(Icons.menu, color: isDarkMode ? Colors.black : AppColors.textColor,),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      }),
      actions: [
        Padding(padding: const EdgeInsets.all(5.0),
          child: showProfilePicture ?
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(

                radius: 50,
                backgroundImage: AssetImage('images/alice.jpeg'), // Replace with your actual image URL
              ),
            ),
          ) : Container(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}