import 'package:expense_tracker/home_screen/contoller/home_controller.dart';
import 'package:expense_tracker/untils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Home_Controller controller = Get.put(Home_Controller());
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtNotes = TextEditingController();
  TextEditingController txtPaytypes = TextEditingController();
  TextEditingController txtStatus = TextEditingController();
  TextEditingController txtDate = TextEditingController(
      text:
          "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
  TextEditingController txtTime = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Expense tracker"),
          actions: [
            Obx(
              () => PopupMenuButton(
                onSelected: (value) {
                  controller.status.value = value;
                },
                initialValue: controller.status.value,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text(
                      "Income",
                    ),
                    value: 0,
                  ),
                  const PopupMenuItem(
                    child: Text(
                      "Expanse",
                    ),
                    value: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  "Total balance",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text("Income"),
                    Spacer(),
                    Text("Expense"),
                  ],
                ),

                SizedBox(height: 100,),
                TextField(
                  controller: txtCategory,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    label: Text(
                      "category",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtAmount,
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(
                      "Amount",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtNotes,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    label: Text(
                      "Notes",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => DropdownButton(
                    isExpanded: true,
                    value: controller.ChangePayment.value,
                    items: [
                      const DropdownMenuItem(
                        child: Text("Offline"),
                        value: "Offline",
                      ),
                      const DropdownMenuItem(
                        child: Text("Online"),
                        value: "Online",
                      ),
                    ],
                    onChanged: (value) {
                      controller.ChangePayment.value = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtTime,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    label: Text(
                      "Time",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: txtDate,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    label: Text(
                      "Date",
                      style: TextStyle(color: Colors.black),
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          print("${txtTime.text}   ${txtDate.text}");
                          DBHelper.dbHelper.insertData(
                            category: txtCategory.text,
                            amount: txtAmount.text,
                            notes: txtNotes.text,
                            paytypes: controller.ChangePayment.value,
                            status: controller.status.value,
                            date: txtDate.text,
                            time: txtTime.text,
                          );

                          // student_controller.DataList.value =
                          //     await DBHelper.dbHelper.ReadData();
                        },
                        child: const Text(
                          "Insert",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () async {
                          print("${txtTime.text}   ${txtDate.text}");

                          Get.toNamed('/read');
                          controller.DataList.value =
                              await DBHelper.dbHelper.ReadData();
                        },
                        child: const Text(
                          "Read Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
