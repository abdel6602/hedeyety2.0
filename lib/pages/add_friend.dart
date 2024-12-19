import 'package:flutter/material.dart';
import 'package:hedeyety2/models/user.dart';
import 'package:hedeyety2/pages/profile_page.dart';
import 'package:hedeyety2/reusables/app_bar.dart';
import 'package:hedeyety2/reusables/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_colors.dart';

class ContactSearchScreen extends StatefulWidget {
  const ContactSearchScreen({super.key});

  @override
  State<ContactSearchScreen> createState() => _ContactSearchScreenState();
}

class _ContactSearchScreenState extends State<ContactSearchScreen> {
  List<User> _searchResults = [];
  List<User> _addedFriends = [];
  TextEditingController _searchController = TextEditingController();

  bool isDarkMode = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    if (enabled == null) {
      isDarkMode = true;
      return true;
    } else {
      isDarkMode = enabled;
      return enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor:
            isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'images/alice.jpeg'), // Replace with your actual image URL
                ),
              ),
            ),
          )
        ],
      ),
      drawer: MyDrawer(theme: isDarkMode),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: TextStyle(
                  color:
                      isDarkMode ? AppColors.primaryDark : AppColors.textColor),
              decoration: InputDecoration(
                hintText: 'username or phone number',
                hintStyle: TextStyle(
                    color: isDarkMode
                        ? AppColors.primaryDark
                        : AppColors.textColor),
                filled: true,
                fillColor:
                    isDarkMode ? AppColors.textColor : AppColors.primaryDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color:
                      isDarkMode ? AppColors.primaryDark : AppColors.textColor,
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  _searchResults.add(User(
                      id: "1",
                      name: _searchController.text,
                      profilePicture: "images/alice.jpeg",
                      email: "ksdjakd",
                      password: "ksdjakd",
                      phoneNumber: "0101239012931"));
                });

                // Implement search functionality here
                // You can filter the 'contacts' list based on the 'value'
                // and then call setState to rebuild the UI with the filtered list.
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        tileColor: (_addedFriends.any((addedFriend) =>
                                addedFriend.name == _searchResults[index].name))
                            ? AppColors.secondaryDark
                            : AppColors.thirdDark,
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(_searchResults[index].profilePicture),
                        ),
                        title: Text(
                          _searchResults[index].name,
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.primaryDark
                                  : AppColors.textColor),
                        ),
                        subtitle: Text(
                          _searchResults[index].phoneNumber,
                          style: TextStyle(
                              color: isDarkMode
                                  ? AppColors.primaryDark
                                  : AppColors.textColor),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            if(_addedFriends.any((addedFriend) =>
                                addedFriend.name == _searchResults[index].name)){
                              setState(() {
                                _addedFriends.removeWhere((addedFriend) =>
                                    addedFriend.name == _searchResults[index].name);
                              });
                              print("Removed User with information: ${_searchResults[index].toJson()}");
                              return;
                            }
                            print(

                                "Added User with information: ${_searchResults[index].toJson()}");
                            // TODO: Handle add contact
                            setState(() {
                              _addedFriends.add(_searchResults[index]);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: const CircleBorder(),
                          ),
                          child:  Icon(
                            (_addedFriends.any((addedFriend) =>
                                    addedFriend.name == _searchResults[index].name))
                                ? Icons.check
                                : Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
