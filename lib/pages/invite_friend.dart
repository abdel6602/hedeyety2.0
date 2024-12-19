import 'package:flutter/material.dart';
import 'package:hedeyety2/app_colors.dart';
import 'package:hedeyety2/models/user.dart';
import 'package:hedeyety2/pages/profile_page.dart';
import 'package:hedeyety2/reusables/app_bar.dart';
import 'package:hedeyety2/reusables/drawer.dart';
import 'package:hedeyety2/services/user_service.dart';

class InviteFriend extends StatefulWidget {
  final bool isDarkMode;
  const InviteFriend({super.key, required this.isDarkMode});

  @override
  State<InviteFriend> createState() => _InviteFriendState(isDarkMode: isDarkMode);
}

class _InviteFriendState extends State<InviteFriend> {
  final bool isDarkMode;

  _InviteFriendState({required this.isDarkMode});

  late List<User> friends = [];
  late List<User> invitedFriends = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      friends = Userservices.getFriendsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Friends"),
        backgroundColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
          onPressed: (){
            Navigator.pop(context, invitedFriends);
          },
        ),
        actions: [
          Padding(padding: const EdgeInsets.all(5.0),
            child:
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
              ),),),)
          ],
      ),
      backgroundColor: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            TextField(
              controller: _searchController,
              onSubmitted: (value){
                setState(() {
                  friends = Userservices.searchForFriend(value);
                });
              },
              style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                ),
                hintStyle: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark),
                hintText: "Search for a friend",
                prefixIcon: Icon(Icons.search, color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,),
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        tileColor: invitedFriends.any((invitedFriend) => invitedFriend.name == friends[index].name) ? AppColors.secondaryDark : AppColors.thirdDark,
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('images/${friends[index].profilePicture}'),
                        ),
                        title: Text(friends[index].name),
                        subtitle: Text(friends[index].phoneNumber),
                        trailing: IconButton(onPressed: () {
                          setState(() {
                            invitedFriends.add(friends[index]);
                          });
                        }, icon: GestureDetector(
                          child: Icon((invitedFriends.any((invitedFriend) => invitedFriend.name == friends[index].name)) ? Icons.delete : Icons.add,
                            color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
                          onTap: (){
                            setState(() {
                              if(invitedFriends.any((invitedFriend) => invitedFriend.name == friends[index].name)){
                                invitedFriends.removeWhere((invitedFriend) => invitedFriend.name == friends[index].name);
                              }else{
                                invitedFriends.add(friends[index]);
                              }
                            });
                          },
                        ),),
                      ),
                      SizedBox(height: 15,)
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
