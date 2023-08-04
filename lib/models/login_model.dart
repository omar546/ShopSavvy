class LoginModel {
  bool? status;
  String? message;
  UserData? data;

  LoginModel.formJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = UserData.fromJson(json['data']);
    } else {
      data = null;
    }

  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  UserData(
      {this.name,
      this.phone,
      this.email,
      this.credit,
      this.id,
      this.image,
      this.token,
      this.points});

  //named constructor
UserData.formJson(Map<String,dynamic> json)
{
  id = json['id'];
  name = json['name'];
  email = json['email'];
  phone = json['phone'];
  image = json['image'];
  points = json['points'];
  credit = json['credit'];
  token = json['token'];

}
// Factory constructor to create UserData object from JSON data
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      points: json['points'],
      credit: json['credit'],
      token: json['token'],
    );
  }
}
