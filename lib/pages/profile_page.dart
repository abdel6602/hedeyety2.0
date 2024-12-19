import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_colors.dart';
import '../models/user.dart';
// import '../services/shared_preferences.dart.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final List<Event> _events = [
    Event(title: "Birthday", date: DateTime(2025, 12, 17), invitees: [], gifts: []),
    Event(title: "Graduation", date: DateTime(2025, 1, 2), invitees: [], gifts: []),
    Event(title: "Wedding", date: DateTime(2025, 6, 6), invitees: [], gifts: []),
  ];

  final User profile = User(
    name: 'Alice',
    email: 'Alice@gmail.com',
    profilePicture: "images/alice.jpeg",
    id: "2",
    password: "123456",
    phoneNumber: "01094088867",
  );

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

  initState() {
    super.initState();
    isDarkModeEnabled().then((value) {
      setState(() {
        isDarkMode = value;
      });
    });
  }

  late bool isDarkMode;

  List<bool> isEditing = [false, false, false, false];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  // late SharedPrefManager _instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDarkMode ? AppColors.primaryDark  : AppColors.primaryLight,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 55,),          // Profile Picture and dark mode selector
              _buildPreDivider(),
              _buildDivider(),
              const SizedBox(height: 20),
              // Profile Information
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    Text("Name: ", style: TextStyle(
                        color: isDarkMode ? AppColors.textColor : Colors.black,
                        fontSize: 16
                      ),
                    ),
                    const Spacer(),
                    _buildTextField(profile.name, _nameController, 0)
                  ],
                ),

              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    Text("Number: ", style: TextStyle(color: isDarkMode ? AppColors.textColor : Colors.black, fontSize: 16)),
                    const Spacer(),
                    _buildTextField("01094088867", _phoneNumber, 1)
                  ],
                ),

              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    Text("Email: ", style: TextStyle(color: isDarkMode ? AppColors.textColor : Colors.black, fontSize: 16)),
                    const Spacer(),
                    _buildTextField("Alice@gmail.com", _emailController, 2)
                  ],
                ),

              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  children: [
                    Text("Password: ", style: TextStyle(color: isDarkMode ? AppColors.textColor : Colors.black, fontSize: 16)),
                    const Spacer(),
                    _buildTextField("********", _nameController, 3)
                  ],
                ),

              ),

              const SizedBox(height: 20,),

              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                  foregroundColor: isDarkMode ? Colors.black : AppColors.textColor,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Save Changes"),

              ),

              const SizedBox(height: 10,),
              _buildDivider(),

              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("My Events", style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? AppColors.textColor : Colors.black,
                          ),),
                        ),
                        const Spacer(),
                        CircleAvatar(child: IconButton(onPressed: (){}, icon: Icon(Icons.add)), radius: 20, backgroundColor: AppColors.secondaryDark, foregroundColor: AppColors.textColor,)
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _events.length,
                      itemBuilder: (context, index) {
                        final event = _events[index];
                        final DateFormat formatter = DateFormat('MMM d');
                        final String formattedDate = formatter.format(event.date);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            tileColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 29),
                            title: Text(
                                event.title,
                                style: TextStyle(
                                  color: isDarkMode ? Colors.black : AppColors.textColor,
                                ),
                            ),
                            // subtitle: Text("Subtitle $index"),
                            leading: Icon(
                                Icons.card_giftcard,
                                color: isDarkMode ? Colors.black : AppColors.textColor,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: isDarkMode ? Colors.black : AppColors.textColor,
                                ),
                                SizedBox(width: 10,),

                                Text(formattedDate, style: TextStyle(
                                  color: isDarkMode ? Colors.black : AppColors.textColor,
                                  fontSize: 14
                                ),),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }

  SizedBox _buildTextField(String? customHintText, TextEditingController controller, int index) {
    return SizedBox(
      width: 200,
      height: 45,
      child: Stack(
        children: [TextField(
          enabled: isEditing[index],
          controller: _nameController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            fillColor: AppColors.textColor,
            filled: true,
            hintText: customHintText,
            hintStyle: TextStyle(color: isEditing[index]? Colors.black : Colors.grey),
          ),
        ),
          Positioned(
            right: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isEditing[index] = !isEditing[index];
                });
              },
              icon: const Icon(Icons.edit, color: AppColors.primaryDark, size: 15,),
            ),
          )
        ],
      ),
    );
  }

  Center _buildDivider() {
    return Center(
      child: Divider(
        color: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
        thickness: 2,
        indent: 40,
        endIndent: 40,
      ),
    );
  }

  Row _buildPreDivider() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              border: Border.all(
                  color: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                  width: isDarkMode ? 2 : 4)
              ,
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profile.profilePicture),
            ),
          ),
        ),
        const Spacer(),
        Text("Dark Mode", style: TextStyle(color: isDarkMode ? AppColors.textColor : Colors.black, fontSize: 16)),
        SizedBox(width: 10,),
        Switch(
          value: isDarkMode,
          onChanged: (value) async {
            setState(() {
              isDarkMode = !isDarkMode;
            }

            );
            final _instance = await SharedPreferences.getInstance();
            _instance.setBool("Theme", isDarkMode);
            print('Theme saved: ${_instance.getBool("Theme")}');
            // _instance.prefs!.setBool("theme", isDarkMode);
            // print(_instance.prefs!.getBool("theme"));
            // Change the theme
          },
          activeColor: AppColors.secondaryDark,
        ),
        const SizedBox(width: 20),
      ],
    );
  }



}