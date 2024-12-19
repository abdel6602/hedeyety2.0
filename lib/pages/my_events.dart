import 'package:flutter/material.dart';
import 'package:hedeyety2/app_colors.dart';
import 'package:hedeyety2/models/gift.dart';
import 'package:hedeyety2/reusables/app_bar.dart';
import 'package:hedeyety2/services/user_service.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';
import '../reusables/drawer.dart';
import 'create_event.dart';

class EventsPage extends StatefulWidget {
  bool isDarkMode;

  EventsPage({super.key, required this.isDarkMode});

  @override
  State<EventsPage> createState() => _EventsPageState(isDarkMode: isDarkMode);
}

class _EventsPageState extends State<EventsPage> {
  bool isDarkMode;
  String chosenMode = "Current";
  _EventsPageState({required this.isDarkMode});

  List<Event> events = [
    Event(title: "Christmas", date: DateTime(2024,12, 25), invitees: [
      Userservices.getFriendsList()[0],
      Userservices.getFriendsList()[1],
      Userservices.getFriendsList()[2],
    ], gifts: [
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
    ]),
    Event(title: "Birthday", date: DateTime(2025, 3, 7), invitees: [
      Userservices.getFriendsList()[0],
      Userservices.getFriendsList()[1],
      Userservices.getFriendsList()[2],
    ], gifts: [
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
    ]),
    Event(title: "Wedding", date: DateTime(2024, 10, 2), invitees: [
      Userservices.getFriendsList()[0],
      Userservices.getFriendsList()[1],
      Userservices.getFriendsList()[2],
    ], gifts: [
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
      Gift(name: "ps5", description: "sdska", imageUrl: "images/Playstation 5.jpeg", price: "700", id: "2", requestingUserId: "2", pledgedUserId: "2", isPledged: true, categoryId: "1"),
    ]),
  ];

  Future<void> showCreateEvent() async {
    final event = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEvent(isDarkMode: isDarkMode, isCreating: true,)));
    if(event != null){
      setState(() {
        events.add(event);
        events.sort((a,b) => a.date.compareTo(b.date));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    events.sort((a,b) => a.date.compareTo(b.date));
    print(events);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode
          ? AppColors.primaryDark
          : AppColors.primaryLight, // Dark Background
      appBar: CustomAppBar(
          showProfilePicture: true, title: "My Events", isDarkMode: isDarkMode),
      drawer: MyDrawer(theme: isDarkMode),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showCreateEvent();
              },
              icon: Icon(
                Icons.add,
                color: isDarkMode ? AppColors.primaryDark : AppColors.textColor,
              ),
              label: Text("Create a new event",
                  style: TextStyle(
                      color: isDarkMode
                          ? AppColors.primaryDark
                          : AppColors.textColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      chosenMode = "Current";
                    });
                  },
                  child: Text("Current",
                      style: TextStyle(color: (chosenMode == "Current")
                          ? AppColors.primaryDark
                          : Colors.grey)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: chosenMode == "Current"
                          ? AppColors.thirdDark
                          : Colors.grey[700]),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      chosenMode = "Upcoming";
                    });
                  },
                  child: Text("Upcoming",
                      style: TextStyle(color: (chosenMode == "Upcoming")
                          ? AppColors.primaryDark
                          : Colors.grey)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (chosenMode == "Upcoming")
                          ? AppColors.thirdDark
                          : Colors.grey[700]),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      chosenMode = "Past";
                    });
                  },
                  child:
                    Text("Past", style: TextStyle(color: (chosenMode == "Past")
                    ? AppColors.primaryDark
                    : Colors.grey)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: (chosenMode == "Past")
                          ? AppColors.thirdDark
                          : Colors.grey[700]
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Row(
            //   children: [
            //     const Icon(Icons.filter_list, color: Colors.grey),
            //     const SizedBox(width: 8),
            //     const Text("Name", style: TextStyle(color: Colors.grey)),
            //     const Spacer(),
            //     const Text("Category", style: TextStyle(color: Colors.grey)),
            //     const Icon(Icons.arrow_drop_down, color: Colors.grey)
            //   ],
            // ),
            const Divider(color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  final now = DateTime.now();
                  if(chosenMode == "Current"){
                    if(event.date.isBefore(now)){
                      //skip
                      return const SizedBox.shrink();
                    }
                    if(event.date.difference(now).inDays > 30){
                      return const SizedBox.shrink();
                    }
                  }
                  if(chosenMode == "Upcoming"){
                    if(event.date.isBefore(now)){
                      return const SizedBox.shrink();
                    }
                  }
                  if(chosenMode == "Past"){
                    if(event.date.isAfter(now)){
                      return const SizedBox.shrink();
                    }
                  }
                  print(event.toJson());
                  return Card(
                    color: isDarkMode ? AppColors.thirdDark : AppColors.secondaryDark,
                    child: ListTile(
                      leading:
                        Icon(Icons.card_giftcard, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),
                      title: Text(event.title,
                          style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor)),
                      subtitle: Text(DateFormat('MMM d').format(event.date),
                          style: TextStyle(color: isDarkMode ? AppColors.primaryDark : AppColors.textColor)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),
                            onPressed: () async {
                              events[index] = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEvent(event: event, isDarkMode: isDarkMode, isCreating: false,)));
                              setState(() {
                                events.sort((a,b) => a.date.compareTo(b.date));
                              });
                              },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: isDarkMode ? AppColors.primaryDark : AppColors.textColor),
                            onPressed: () {
                              setState(() {
                                events.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
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
