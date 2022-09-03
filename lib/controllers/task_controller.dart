import 'package:flutter_to_do_app/db/db_helper.dart';
import 'package:get/get.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
}
