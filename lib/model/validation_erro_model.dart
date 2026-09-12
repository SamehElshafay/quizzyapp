class ValidationErroModel {
  String? message;
  Errors? errors;

  ValidationErroModel({this.message, this.errors});

  factory ValidationErroModel.fromJson(Map<String, dynamic> json) {
    return ValidationErroModel(
      errors: json['errors'] != null ? Errors.fromJson(json['errors']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'errors': errors != null ? errors!.toJson() : {},
    };
  }
}

class Errors {
  List? email;
  List? phone;

  Errors({this.email, this.phone});

  factory Errors.fromJson(Map<String, dynamic> json) {
    return Errors(email: json['email'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'phone': phone};
  }
}
