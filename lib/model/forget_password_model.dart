class ForgetPasswordModel {
  bool? success;
  Data? data;
  String? message;

  ForgetPasswordModel({this.success, this.data, this.message});

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
        message: json['message'],
        success: json['success']);
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'data': data != null ? data!.toJson() : {}
    };
  }
}

class Data {
  String? email;

  Data({this.email});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email};
  }
}
/*

Sucess , Fail : 200 ok

Sucess Reponse:
{
    "success": true,
    "data": {
        "email": "mykholys30@gmail.com"
    },
    "message": "Done"
}

Fail Response:

{
    "success": false,
    "message": "User not found"
}

*/
