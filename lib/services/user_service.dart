import '../models/user.dart';

class Userservices {

  static getFriendsList(){
    return [
      User(id: "1", name: "Alice", email: "Alice@gmail.com", password: "kdsjakdj", profilePicture: "alice.jpeg", phoneNumber: "10129102902"),
      User(id: "2", name: "Bob", email: "Bob@gmail.com", password: "sjhdsajhdasjh", profilePicture: "Bob.jpeg", phoneNumber: "10129102902"),
      User(id: "3", name: "Ethan Bradley", email: "Ethan@gmail.com", password: "sdkjaskdj", profilePicture: "ethan.jpeg", phoneNumber: "10129102902")
    ];
  }

  static searchForFriend(String searchValue){
    return [
      User(id: "1", name: searchValue, email: "sjdhasd", password: "djksakdj", profilePicture: "Bob.jpeg",phoneNumber: "10129102902"),
    ];
  }
}