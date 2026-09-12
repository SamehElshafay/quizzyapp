import 'package:quizzy_app/model/academic_year_response_model.dart';
import 'package:quizzy_app/model/acdemic_years_model.dart';

abstract class AcademicYearsRepository {
  Future<AcdemicYearsModel> getAllAcademicYear({int? skip, int? limit});
  Future<AcdemicYearResponseModel> getAcademicYearById({required int id});
}
