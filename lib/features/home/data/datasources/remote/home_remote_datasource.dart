import 'package:veyra/features/add_activity/data/models/activity_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<ActivityModel>> getActivities();
}

