import 'package:dio/src/response.dart';
import 'package:mak_life_delivery/app/data/services/api_service.dart';

import '../../constants/constants.dart';
import '../../utils/alert_popup_utils.dart';
import '../services/shared_preference_service.dart';

class DeliveryOrderRepository{
  final SharedPreferenceService sharedPresenceServices;
  final ApiService apiService;

  DeliveryOrderRepository({required this.sharedPresenceServices, required this.apiService});

  Future<Response?> getAssignOrder() async{
    try{
      final params = {
        "UserId": getDeliveryBoyId(),
      };
      return await apiService.get("/api/AssignOrdersToDeliveryBoy",query: params);
    }catch(e){
      print('Error in getAssignOrder: $e');
      showAlertMessage("Error in getAssignOrder: $e");
      return null;
    }
  }

  Future<Response?> getAssignedOrderDetails(String orderId) async{
    try{
      final params = {
        "deliveryBoyId": getDeliveryBoyId(),
        "OrderId": orderId
      };
      return await apiService.get("/api/Response",query: params);
    }catch(e){
      print('Error in getAssignOrder: $e');
      showAlertMessage("Error in getAssignOrder: $e");
      return null;
    }
  }

  Future<Response?> updateOrderStatus(String orderId,String statusCode, String orderReceiverName) async{
    try{
      final params = {
        "DeliveryBoyId":getDeliveryBoyId(),
        "OrderId": orderId,
        "Status": statusCode,
        "ReceiverName": orderReceiverName
      };
      return await apiService.post('/api/OrderShipped',data: params);
    }catch(e){
      print('Error in updateOrderStatusAPI: $e');
      showAlertMessage("Error in updateOrderStatusAPI: $e");
      return null;
    }
  }

  String getDeliveryBoyId(){
    return sharedPresenceServices.getString(userUId) ?? "";
  }
}