class SocialServiceResponseModel {
  String? providerId;
  String? providertype;
  bool status;
  String? message;

  SocialServiceResponseModel(
      {this.providerId, this.providertype, required this.status, this.message});
}
