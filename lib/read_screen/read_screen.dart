import 'package:expense_tracker/home_screen/contoller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Read_Screen extends StatefulWidget {
  const Read_Screen({Key? key}) : super(key: key);

  @override
  State<Read_Screen> createState() => _Read_ScreenState();
}

class _Read_ScreenState extends State<Read_Screen> {
  @override
  void initState() {
    super.initState();
    controller.readTransaction();
  }

  TextEditingController txtCategory_u = TextEditingController();
  TextEditingController txtAmount_u = TextEditingController();
  TextEditingController txtNotes_u = TextEditingController();
  TextEditingController txtPaytypes_u = TextEditingController();
  TextEditingController txtStatus_u = TextEditingController();
  TextEditingController txtDate_u = TextEditingController(
      text:
          "${DateTime.now().day}/ ${DateTime.now().month}/ ${DateTime.now().year}");
  TextEditingController txtTime_u = TextEditingController(
      text: "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");
  Home_Controller controller = Get.put(Home_Controller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Read Income Expense",
            style: TextStyle(fontSize: 20),
          ),
          elevation: 0,
          centerTitle: true,
          actions: [
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("All"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Income"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Expense"),
                ),
              ];
            }, onSelected: (value) {
              if (value == 0) {
                TextButton(
                  onPressed: () {
                    controller.readTransaction();
                  },
                  child: Text(
                    "All Data",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (value == 1) {
                print("Settings menu is selected.");
              } else if (value == 2) {
                print("Logout menu is selected.");
              }
            }),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.black,
                    child: TextButton(
                      onPressed: () {
                        controller.readTransaction();
                      },
                      child: Text(
                        "All Data",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green.shade100,
                    child: TextButton(
                      onPressed: () {
                        controller.filterData(status: 0);
                      },
                      child: Text(
                        "Income",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red.shade100,
                    child: TextButton(
                      onPressed: () {
                        controller.filterData(status: 1);
                      },
                      child: Text(
                        "Expence",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: controller.DataList[index]['status'] == 0
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ),
                      // color: Colors.black26,

                      child: Row(
                        children: [
                          Text("${controller.DataList[index]['id']}"),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${controller.DataList[index]['category']}"),
                              Text("${controller.DataList[index]['amount']}"),
                              Text("${controller.DataList[index]['paytypes']}"),
                              Text("${controller.DataList[index]['date']}"),
                              Text("${controller.DataList[index]['time']}"),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              txtCategory_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['category']}");
                              txtAmount_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['amount']}");
                              txtNotes_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['notes']}");
                              txtPaytypes_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['paytypes']}");
                              txtStatus_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['status']}");
                              txtDate_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['date']}");
                              txtTime_u = TextEditingController(
                                  text:
                                      "${controller.DataList[index]['time']}");
                              updateDialog(index);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.deleteData(
                                id: controller.DataList[index]['id'],
                              );
                              controller.readTransaction();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.DataList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDialog(int index) {
    Get.defaultDialog(
      content: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: txtCategory_u,
              onChanged: (value) {},
              decoration: InputDecoration(
                label: Text(
                  "category",
                  style: TextStyle(color: Colors.blueAccent.shade700),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtAmount_u,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(
                  "Amount",
                  style: TextStyle(color: Colors.blueAccent.shade700),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtNotes_u,
              onChanged: (value) {},
              decoration: InputDecoration(
                label: Text(
                  "Notes",
                  style: TextStyle(color: Colors.blueAccent.shade700),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => DropdownButton(
                isExpanded: true,
                value: controller.ChangePayment.value,
                items: [
                  DropdownMenuItem(
                    child: Text("Offline"),
                    value: "Offline",
                  ),
                  DropdownMenuItem(
                    child: Text("Online"),
                    value: "Online",
                  ),
                ],
                onChanged: (value) {
                  controller.ChangePayment.value = value!;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtTime_u,
              onChanged: (value) {},
              decoration: InputDecoration(
                label: Text(
                  "Time",
                  style: TextStyle(color: Colors.blueAccent.shade700),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent.shade700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtDate_u,
              onChanged: (value) {},
              decoration: InputDecoration(
                label: Text(
                  "Date",
                  style: TextStyle(color: Colors.blueAccent.shade700),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent.shade700,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel"),
                ),
                Spacer(),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    controller.updateData(
                      id: controller.DataList[index]['id'],
                      category: txtCategory_u.text,
                      amount: txtAmount_u.text,
                      notes: txtNotes_u.text,
                      paytypes: txtPaytypes_u.text,
                      status: txtStatus_u.text,
                      date: txtDate_u.text,
                      time: txtTime_u.text,
                    );
                    Get.back();
                  },
                  child: Text("Yes"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
