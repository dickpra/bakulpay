import 'package:flutter/material.dart';
import 'package:get/get.dart';



class FilterController extends GetxController {
  var isTopUpSelected = true.obs; // Gunakan RxBool untuk pemantauan perubahan
}

class wasuuu extends StatelessWidget {
  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Toggle Button Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Filter Options',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Obx(() {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      filterController.isTopUpSelected.value = true;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: filterController.isTopUpSelected.value ? Colors.blue : Colors.grey,
                                    ),
                                    child: Text('Top Up'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      filterController.isTopUpSelected.value = false;
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: !filterController.isTopUpSelected.value ? Colors.blue : Colors.grey,
                                    ),
                                    child: Text('Withdraw'),
                                  ),
                                ],
                              );
                            }),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);

                                // Lakukan sesuatu dengan filter yang dipilih
                                print('Is Top Up Selected: ${filterController.isTopUpSelected.value}');
                              },
                              child: Text('Apply'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Text('Open Bottom Sheet'),
          ),
        ),
      ),
    );
  }
}
