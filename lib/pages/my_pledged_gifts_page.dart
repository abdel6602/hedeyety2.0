import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../models/gift.dart';
import '../reusables/app_bar.dart';
import '../reusables/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PledgesPage extends StatefulWidget {
  const PledgesPage({super.key});

  @override
  State<PledgesPage> createState() => _PledgesPageState();
}

class _PledgesPageState extends State<PledgesPage> {

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
    if(enabled == null){
      isDarkMode = true;
      return true;
    }
    else{
      isDarkMode = enabled;
      return enabled;
    }
  }

  final List<Gift> pledgedGifts = [
    Gift(name: "Playstation 5", description: "amazing console", imageUrl: "images/Playstation 5.jpeg", price: "419.99", id: "1", requestingUserId: "1", pledgedUserId: "2", isPledged: true, categoryId: "1"),
    Gift(name: "Fidget Spinner", description: "sjdha", imageUrl: "images/spinner.jpeg", price: "1.99", id: "1", requestingUserId: "1", pledgedUserId: "1", isPledged: true, categoryId: "2")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.primaryDark  : AppColors.primaryLight,
      appBar: CustomAppBar(showProfilePicture: true, title: "Pledged Gifts", isDarkMode: isDarkMode),
      drawer: MyDrawer(theme: isDarkMode,),
      body: Center(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Container(
            color: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
            child: ListView.builder(
              itemCount: pledgedGifts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: AssetImage(pledgedGifts[index].imageUrl), radius: 30,),
                      title: Text(pledgedGifts[index].name, style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),),
                      subtitle: Text('\$' + pledgedGifts[index].price, style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor)),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
                              onPressed: () {
                                // Navigate to edit gift page
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
                              onPressed: () {
                                // Delete the gift
                              },
                            ),
                          ],
                        ),
                      ),
                      // ... rest of the ListTile content
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

