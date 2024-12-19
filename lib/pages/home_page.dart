import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hedeyety2/pages/add_friend.dart';
import 'package:hedeyety2/pages/create_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_colors.dart';
import '../models/user.dart';
import '../reusables/app_bar.dart';
import '../reusables/drawer.dart';
import '../services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late List<User> friends;

  String searchValue = '';
  TextEditingController _searchController = TextEditingController();
  bool isDarkMode = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    friends = Userservices.getFriendsList();
    isDarkModeEnabled().then((value) {
      setState(() {
        isDarkMode = value;
      });
    });
  }

  Future<bool> isDarkModeEnabled() async {
    final _instance = await SharedPreferences.getInstance();
    final enabled = _instance.getBool("Theme");
    print('Dark Mode on: ${enabled}');
    if(enabled == null){
      isDarkMode = true;
      return true;
    }
    else{
      isDarkMode = enabled;
      return enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.primaryDark  : AppColors.primaryLight,
      appBar: CustomAppBar(showProfilePicture: true, title: 'Home', isDarkMode: isDarkMode,),
      drawer: MyDrawer(theme: isDarkMode,),
      body: Padding(
        padding: const EdgeInsets.all(29.0),
        child: Column(
          children: [
            _buildElevatedButton('Create a new event', () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => CreateEvent(isCreating: true, isDarkMode: isDarkMode,)));
              // Navigate to the send gift page
            }, false, null),
            const SizedBox(height: 17,),
            _buildElevatedButton("Add Friend", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactSearchScreen()));
            }, true, Icon(Icons.person_add, color: isDarkMode ? AppColors.secondaryDark : AppColors.textColor,)),
            const SizedBox(height: 17,),


            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Friends", style: TextStyle(
                fontSize: 20,
                color: AppColors.textColor,
              ),),
            ),
            const SizedBox(height: 17,),
            _buildTextField(_searchController, "Friend's Name", true, Icon(Icons.search), searchValue, () {
              //process search within friends
              setState(() {
                friends = Userservices.searchForFriend(_searchController.text);
              });
            }),
            const SizedBox(height: 17,),
            // const Spacer(),
            _buildFriendsList(),

          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton(String text, Function() onPressed, bool hasIcon, Icon? icon) {
    return SizedBox(
      width: 227,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark),
            foregroundColor: WidgetStatePropertyAll(isDarkMode ? Colors.black : AppColors.textColor),
        ),
        onPressed: onPressed,
        child: hasIcon? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 10,),
            Text(text),
          ],
        ) : Text(text),
      ),
    );
  }

  Expanded _buildFriendsList() {
    return Expanded(child: ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 29),
                tileColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                leading: CircleAvatar(
                  backgroundImage: AssetImage('images/${friends[index].profilePicture}'),
                  radius: 30,
                  // Add profile picture if available
                ),
                title: Text(friends[index].name, style: TextStyle(color: isDarkMode ? Colors.black : AppColors.textColor),),
                // subtitle: const Text(""),
                trailing: SizedBox(
                  width: 40,
                  child: Row(
                    children: [
                      Text(_getPendingsCount(friends[index]), style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.red : AppColors.thirdDark,
                      ),), SizedBox(width: 5,),
                      Icon(Icons.card_giftcard, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 10),
            ],
        );

      },
    ),);
  }

  Widget _buildTextField(TextEditingController controllerObj, String hint, bool hasIcon, Icon icon, String toInput, Function()? onIconPressed){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(
                color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
              ),
              onSubmitted: (value){
                setState(() {
                  friends = Userservices.searchForFriend(value);
                });
              },
              controller: controllerObj,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
                ),
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          if(hasIcon) IconButton(
            color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
            onPressed: onIconPressed,
            icon: icon,
          ),
        ],
      ),
    );
  }



  String _getPendingsCount(User user) {
    // Get the number of pending gifts for the user
    return (Random().nextInt(10)).toString();
  }
}

