import 'package:hedeyety2/models/user.dart';

import 'gift.dart';

class Event {
  final String title;
  final String? address;
  final DateTime date;
  final List<User> invitees;
  final List<Gift> gifts;

  Event({required this.title, required this.date, required this.invitees, required this.gifts, this.address});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      date: DateTime.parse(json['date']),
      invitees: (json['invitees'] as List).map((e) => User.fromJson(e)).toList(),
      gifts: (json['gifts'] as List).map((e) => Gift.fromJson(e)).toList(),
      address: json['address']
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'date': date,
    'invitees': invitees.map((e) => e.toJson()).toList(),
    'gifts': gifts.map((e) => e.toJson()).toList(),
    'address': address
  };

  void addInvitee(User user) {
    invitees.add(user);
  }

  void removeInvitee(User user) {
    invitees.remove(user);
  }

  void addGift(Gift gift) {
    gifts.add(gift);
  }

  void removeGift(Gift gift) {
    gifts.remove(gift);
  }

}