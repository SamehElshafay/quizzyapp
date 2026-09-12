import 'package:dio/dio.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/academic_years_repository.dart';
import 'package:quizzy_app/model/academic_year_response_model.dart';
import 'package:quizzy_app/model/acdemic_years_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class AcademicYearsRepositoryService implements AcademicYearsRepository {
  @override
  Future<AcdemicYearsModel> getAllAcademicYear({int? skip, int? limit}) async {
    try {
      var response = await DioHelper().get(EndPoint.academiYears,
          queryParameters: {'skip': skip, 'limit': limit});
      return AcdemicYearsModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AcdemicYearResponseModel> getAcademicYearById(
      {required int id}) async {
    try {
      var response = await DioHelper().get(EndPoint.getAcademiYearById(id: id));
      return AcdemicYearResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }
}
