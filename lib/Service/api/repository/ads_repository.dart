import 'package:quizzy_app/model/ads_model.dart';

abstract class AdsRepository {
  Future<AdsModel> getAds({int? skip, int? limit});
}
