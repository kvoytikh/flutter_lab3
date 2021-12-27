import 'dart:convert';






class PostData {
  String username;
  String userImagePath;
  String location;
  String imagePath;
  int likesNumber;
  int postingTime;
  int id;

  PostData(
      {required this.id,
      required this.username,
      required this.userImagePath,
      required this.location,
      required this.imagePath,
      required this.likesNumber,
      required this.postingTime});

  factory PostData.fromJson(Map<String, dynamic> json) {
    return PostData(
      id: json['id'],
      username: json['username'],
      userImagePath: json['userImageUrl'],
      location: json['location'],
      imagePath: json['imageUrl'],
      likesNumber: json['likesNumber'],
      postingTime: json['postingTime'],
    );
  }
}

final postsData = [
  PostData(
    id: 1,
    username: 'username1',
    userImagePath: 'images/foto5.jpg',
    location: 'Kyiv, Ukraine',
    imagePath: 'images/foto1.jpg',
    likesNumber: 100,
    postingTime: 2,
  ),
  PostData(
    id: 2,
    username: 'username2',
    userImagePath: 'images/foto6.jpg',
    location: 'Kyiv',
    imagePath: 'images/foto2.jpg',
    likesNumber: 120,
    postingTime: 2,
  ),
  PostData(
    id: 3,
    username: 'username3',
    userImagePath: 'images/foto7.jpg',
    location: 'Ukraine',
    imagePath: 'images/foto3.jpg',
    likesNumber: 30,
    postingTime: 2,
  ),
  PostData(
    id: 4,
    username: 'username4',
    userImagePath: 'images/foto8.jpg',
    location: 'Lviv',
    imagePath: 'images/foto4.jpg',
    likesNumber: 215,
    postingTime: 2,
  ),
];
