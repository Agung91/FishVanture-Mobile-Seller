import 'package:seller/common/http/http.dart';
import 'package:seller/config/hosts.dart';
import 'package:seller/modules/submission/model/model_submission.dart';
import 'package:seller/modules/submission/model/service_submission.dart';

class SubmissionHttpRepo extends HttpService implements SubmissionService {
  @override
  Future<String?> createPond(SubmissionModel input) async {
    try {
      final response = await post(
        '$host/create-pond',
        body: input.toMap(),
      );
      return response.id;
    } catch (e) {
      rethrow;
    }
  }
}
