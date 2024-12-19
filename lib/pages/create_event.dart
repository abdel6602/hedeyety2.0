import 'package:flutter/material.dart';
import 'package:hedeyety2/models/event.dart';
import 'package:hedeyety2/models/gift.dart';
import 'package:hedeyety2/pages/gift_details.dart';
import 'package:hedeyety2/reusables/app_bar.dart';
import 'package:hedeyety2/reusables/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../app_colors.dart';
import '../models/user.dart';
import 'invite_friend.dart';

class CreateEvent extends StatefulWidget {
  final bool isCreating;
  final bool isDarkMode;
  final Event? event;
  const CreateEvent({super.key, required this.isCreating, required this.isDarkMode, this.event});

  @override
  State<CreateEvent> createState() => _CreateEventState(isCreating:isCreating, isDarkMode: isDarkMode, event: event);
}

class _CreateEventState extends State<CreateEvent> {
  final bool isCreating;
  final bool isDarkMode;
  final Event? event;
  late String original_title;
  late String original_address;
  _CreateEventState({required this.isCreating, required this.isDarkMode, this.event});
  List<User> invitees = [];
  List<Gift> gifts = [];
  DateTime? selectedDate;
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(!isCreating){
      selectedDate = event!.date;
      gifts = event!.gifts;
      invitees = event!.invitees;
      _eventNameController.text = event!.title;
      _addressController.text = event!.address ?? "";
    }
  }

  Future<void> show_gift_details() async {
    // Navigate to the gift details page
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => GiftDetails(isDarkMode: isDarkMode,)));

    if(result != null && result is Gift){
      print(gifts);
      setState(() {
        gifts.add(result);
      });
    }
  }

  bool doesFileExist(String path){
    return File(path).existsSync();
  }

  Future<void> showInvitePage()async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => InviteFriend(isDarkMode: isDarkMode,)));
    print(result);
    if(result != null && result is List<User>){
      print(invitees);
      setState(() {
        invitees = result;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.primaryDark : AppColors.primaryLight,
      appBar: CustomAppBar(showProfilePicture: true, title: "Event", isDarkMode: isDarkMode,),
      drawer: MyDrawer(theme: isDarkMode,),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView( // Added for scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Center(
                child: Icon(
                  Icons.card_giftcard,
                  size: 50,
                  color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,),
              ),
              const SizedBox(height: 20),
              _buildTextField('Event Name', Icons.edit, _eventNameController, isCreating ? null : event!.title),
              const SizedBox(height: 10),
              _buildTextField('Address (optional)', Icons.edit, _addressController, (isCreating && (event?.address != null)) ? null : event?.address),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Date", style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark, fontSize: 18),),
                  const Spacer(),
                  IconButton(
                      onPressed: (){
                        // Show date picker
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_today, color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,))
                  ,
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Gifts", style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark, fontSize: 18),),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // Navigate to the add gift page
                        show_gift_details();
                      },
                      icon: Icon(Icons.add, color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text("Invitees", style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark, fontSize: 18),),
                  const Spacer(),
                  IconButton(onPressed: () {
                    // Navigate to the invite friend page
                    showInvitePage();
                  }, icon: Icon(Icons.add, color: isDarkMode ? AppColors.textColor : AppColors.primaryDark,),),

                ],
              ),
              const SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true, // Important for ListView inside Column
                physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemCount: invitees.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        tileColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('images/${invitees[index].profilePicture}'),
                        ),
                        title: Text(invitees[index].name),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              invitees.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red,),
                        ),
                      ),
                      SizedBox(height: 15,)
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Text("Gifts", style: TextStyle(color: isDarkMode ? AppColors.textColor : AppColors.primaryDark, fontSize: 18),),
              ListView.builder(
                shrinkWrap: true, // Important for ListView inside Column
                physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                itemCount: gifts.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        tileColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                        leading: CircleAvatar(
                          backgroundImage: doesFileExist(gifts[index].imageUrl) ?
                          FileImage(File(gifts[index].imageUrl)) :
                          AssetImage(gifts[index].imageUrl),
                        ),
                        title: Text(gifts[index].name),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              gifts.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red,),
                        ),
                      ),
                      SizedBox(height: 15,)
                    ],
                  );
                },
              ),
              // insert a save button
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      // Save the event in database
                      Navigator.pop(context, Event(
                          title: _eventNameController.text ?? event!.title,
                          address: _addressController.text,
                          date: selectedDate!,
                          invitees: invitees,
                          gifts: gifts
                      ));
                    },
                    child: Text('Save', style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, IconData icon, TextEditingController controller, String? _value) {
    return TextField(
      controller: controller,

      style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),
      decoration: InputDecoration(
        hintText: (_value != null) ? _value : hintText,
        hintStyle: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),
        filled: true,
        fillColor: isDarkMode ? AppColors.textColor : AppColors.primaryDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(icon, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,),
      ),
    );
  }

}

