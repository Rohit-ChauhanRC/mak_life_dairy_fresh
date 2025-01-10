import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:mak_life_delivery/app/modules/delivery/orderDetails/Widgets/successfully_delivery.dart';
import 'package:mak_life_delivery/app/modules/delivery/orderDetails/controllers/order_details_controller.dart';
import 'package:mak_life_delivery/app/utils/alert_popup_utils.dart';

class DeliveryConfirmationPopup extends StatefulWidget {
  String? orderId;
   DeliveryConfirmationPopup({super.key, this.orderId});

  @override
  State<DeliveryConfirmationPopup> createState() => _DeliveryConfirmationPopupState();
}

class _DeliveryConfirmationPopupState extends State<DeliveryConfirmationPopup> {
  final orderDetailsController = Get.find<OrderDetailsController>();
  final TextEditingController receiverName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit:BoxFit.fill,
                image: AssetImage("assets/curveBg.png")
            )
          ),
          child: Column(
            children: [
              const SizedBox(height: 80,),
              const Text("Delivery Confirmation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: blackColor),),
              const Text("Please enter order receiver name for verification purpose.", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: blackColor),),
              const SizedBox(height: 10,),
              SizedBox(
                width: Get.width * 0.8,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // onChanged: (v) => controller.mobileNumber = v,
                  controller: receiverName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: whiteColor,
                      // prefixIcon: Padding(
                      //     padding: const EdgeInsets.only(
                      //         left: 10, right: 10, top: 14, bottom: 10),
                      //     child: Image.asset("assets/flag.png")),
                      hintText: 'Enter receiver number',
                      hintStyle: const TextStyle(
                          color: greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w200)),
                  validator: (value) => value!.isEmpty
                      ? "Please enter receiver name!"
                      : null,
                  keyboardType: TextInputType.name,
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    if(receiverName.text.trim().isNotEmpty){
                      Get.back();
                      orderDetailsController.updateOrderStatusAPI(widget.orderId.toString(), "D", receiverName.text).then((c){
                        Get.to(SuccessfullyDelivery(orderID: widget.orderId,));
                      });
                    }else{
                      showAlertMessage("Please enter order receiver name.");
                    }


                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width * 0.8, 50),
                    backgroundColor: appGreen,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Continue", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),)),
              const SizedBox(height: 20,),
            ],
          ),
        )
      ),
    );
  }
}
