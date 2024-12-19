class Gift {
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final String id;
  final String requestingUserId;
  final String pledgedUserId;
  final bool isPledged;
  final String categoryId;

  Gift({required this.name, required this.description, required this.imageUrl, required this.price, required this.id, required this.requestingUserId, required this.pledgedUserId, required this.isPledged, required this.categoryId});

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      id: json['id'],
      requestingUserId: json['requestingUserId'],
      pledgedUserId: json['pledgedUserId'],
      isPledged: json['isPledged'],
      categoryId: json['categoryId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'id': id,
    'requestingUserId': requestingUserId,
    'pledgedUserId': pledgedUserId,
    'isPledged': isPledged,
    'categoryId': categoryId,
  };

}