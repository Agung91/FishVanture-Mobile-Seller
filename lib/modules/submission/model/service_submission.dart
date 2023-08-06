import 'package:seller/modules/submission/model/model_submission.dart';

abstract class SubmissionService {
  Future<String?> createPond(SubmissionModel input);
}
