import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/constants/colors.dart';

import '../controllers/driver_notification_controller.dart';

class DriverNotificationView extends GetView<DriverNotificationController> {
  const DriverNotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTIFICATIONS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 18, right: 18, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("You have 4 notifications", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: blackColor),),
            notificationList(),
          ],
        ),
      ),
    );
  }
  Widget notificationList(){
    return SizedBox(
      height: Get.height,
      child: ListView.builder(
          // controller: scrollController,
          itemCount: 16,
          padding: EdgeInsets.only(top: 10,bottom: 20),
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                extentRatio: 0.2,
                // A motion is a widget used to control how the pane animates.
                motion:  const ScrollMotion(),
                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(
                    key: Key(index.toString()),
                    onDismissed: () async {
                      // var data = await authRepository.deleteNotification(notificationListResponse?[index].id ?? 0, context);
                      // if(data.statusCode == 2000) {
                      //   setState(() {
                      //     notificationListResponse?.removeAt(index);
                      //   });
                      // }
                    }),
                // All actions are defined in the children parameter.
                children:  [
                  SlidableAction(
                    onPressed: (context) async{
                      // var data = await authRepository.deleteNotification(notificationListResponse?[index].id ?? 0, context);
                      // if(data.statusCode == 2000){
                      //   setState(() {
                      //     notificationListResponse?.removeAt(index);
                      //   });
                      // }
                    },
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    icon: Icons.delete_forever,
                    label: '',
                    borderRadius: BorderRadius.circular(20),

                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () async{
                  // var data = await authRepository.isReadNotification(notificationListResponse?[index].id ?? 0, context);
                  // if(data.statusCode == 2000){
                  //   var referenceId = notificationListResponse?[index].referenceId;
                  //   if(referenceId != 0){
                  //     if(userDefault.read(CATID) == userTypeId){
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => OrderDetailScreen(referenceId!)));
                  //     }else{
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => OrderDetailForDriverScreen(referenceId!)));
                  //     }
                  //
                  //   }
                  //   notificationAPICall(pageNo);
                  // }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: index != 1 ? Colors.grey.withOpacity(0.2) : Colors.white,
                      border: Border.all(color: index != 1 ? Colors.transparent:Colors.grey, width: 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/ic_notificationBellIcon.png",
                              height: 40,
                              width: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("New Order Assigned",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: blackColor),),
                                  Text("You have a new job for order 10034",style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12,color: blackColor))
                                ],),
                            )
                          ],
                        ),
                        Text('19 Dec 2024 | 10:24 AM',style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12, color: blackColor),)
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
