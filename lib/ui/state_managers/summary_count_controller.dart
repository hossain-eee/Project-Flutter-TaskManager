import 'package:get/get.dart';
import 'package:module_11_class_3/data/models/network_response.dart';
import 'package:module_11_class_3/data/models/summary_count_model.dart';
import 'package:module_11_class_3/data/services/network_caller.dart';
import 'package:module_11_class_3/data/utils/urls.dart';

class SummaryCountController extends GetxController {
  bool _getCountSummaryInProgress = false;
  bool _noDataReceive = false; // when data can't get from server
  //instance of SummaryCountModel to update summary card data from server
  SummaryCountModel _summaryCountModel = SummaryCountModel();

  String message = '';

  //getter method to access the private variable/object outside of this file
  bool get getCountSummaryInProgress => _getCountSummaryInProgress;
  bool get noDataReceive => _noDataReceive;
  SummaryCountModel get summaryCountModel => _summaryCountModel;

  //api calling for summary Card
  Future<bool> getCountSummary() async {
    _getCountSummaryInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.taskStatusCount);
    _getCountSummaryInProgress = false;
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
      update();
      return true;
    } else {
      message = 'Count summary get failed! Try again.';
      _noDataReceive = true;
      update();
      return false;
    }
  }
}
