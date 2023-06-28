import 'package:expense_tracker/untils/db_helper.dart';
import 'package:get/get.dart';

class Home_Controller extends GetxController {
  RxList<Map> DataList = <Map>[].obs;

  RxInt filter = 2.obs;
  RxInt status = 0.obs;
  RxString ChangePayment = "Offline".obs;

  Future<void> readTransaction() async {
    DataList.value = await DBHelper.dbHelper.ReadData();
  }

  void deleteData({required id}) {
    DBHelper.dbHelper.deleteData(id: id);
  }

  Future<void> filterData({required status}) async {
    DataList.value = await DBHelper.dbHelper.FilterData(status: status);
  }

  Future<void> updateData({
    required id,
    required category,
    required amount,
    required notes,
    required paytypes,
    required status,
    required date,
    required time,
  }) async {
    DBHelper.dbHelper.updateData(
      id: id,
      category: category,
      amount: amount,
      notes: notes,
      paytypes: paytypes,
      status: status,
      date: date,
      time: time,
    );
    readTransaction();
  }
}
