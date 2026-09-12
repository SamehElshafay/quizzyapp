import 'package:dio/dio.dart';
import 'package:quizzy_app/Service/Networking/dio_exception.dart';
import 'package:quizzy_app/Service/Networking/dio_helper.dart';
import 'package:quizzy_app/Service/api/repository/subjects_repository.dart';
import 'package:quizzy_app/model/subject_model.dart';
import 'package:quizzy_app/model/subjects_model.dart';
import 'package:quizzy_app/utils/end_point.dart';

class SubjectsRepositoryService implements SubjectsRepository {
  @override
  Future<SubjectModel> getSubjectById({required int id}) async {
    try {
      var response = await DioHelper().get(EndPoint.getSubjectById(id: id));
      return SubjectModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubjectsModel> getSubjects(
      {int? skip, int? limit, int? academicYearId}) async {
    try {
      var response = await DioHelper().get(EndPoint.subjects, queryParameters: {
        'skip': skip,
        'limit': limit,
        'academic_year_id': academicYearId
      });
      return SubjectsModel.fromJson(response);
    } on DioException catch (e) {
      throw DioExceptionHelper.instance.getExceptionMessage(dioException: e);
    } catch (e) {
      rethrow;
    }
  }
}
