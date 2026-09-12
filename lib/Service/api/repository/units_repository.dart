import 'package:quizzy_app/model/unit_model.dart';
import 'package:quizzy_app/model/units_model.dart';

abstract class UnitsRepository {
  Future<UnitsModel> getUnits(
      {int? skip,
      int? limit,
      required int subjectId,
      required int bookId,
      String? semester});
  Future<UnitModel> getUnitById({required int id});
}
