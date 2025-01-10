import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:mak_life_delivery/app/utils/alert_popup_utils.dart';
import 'package:mak_life_delivery/app/utils/utils.dart';

import '../../../../data/models/get_assigned_order_model.dart';

class GenerateComplianceReport {
  /// Generates an Excel report from the given data.
  /// [data] - List of orders to be included in the report.
  /// [fromDate] and [toDate] - Selected date range.

  Future<void> generateExcelReport(
      BuildContext context,
      List<GetAssignedOrderModel> data,
      DateTime fromDate,
      DateTime toDate) async {
    try {
      // Create a new Excel workbook
      var excel = Excel.createExcel();
      excel.rename(excel.getDefaultSheet()!, "Compliance Report");

      // Add a sheet
      Sheet sheet = excel["Compliance Report"];

      // Headers
      final headers = [
        {"key": "A1", "value": "Order ID"},
        {"key": "B1", "value": "Customer Name"},
        {"key": "C1", "value": "Customer Mobile No."},
        {"key": "D1", "value": "Order Date Time"},
        {"key": "E1", "value": "Delivery Address"},
        {"key": "F1", "value": "Outlet Address"},
        {"key": "G1", "value": "Total Product Qty"},
        {"key": "H1", "value": "Total Amount"},
        {"key": "I1", "value": "Payment Type"},
        {"key": "J1", "value": "Payment Status"},
        {"key": "K1", "value": "Order Status"},
        {"key": "L1", "value": "Assign Date Time"},
        {"key": "M1", "value": "Transit Date Time"},
        {"key": "N1", "value": "Delivery Date Time"},
      ];

      for (var header in headers) {
        sheet.cell(CellIndex.indexByString(header["key"].toString()))
          ..value = TextCellValue(header["value"].toString())
          ..cellStyle = CellStyle(
            bold: true,
            fontSize: 12,
            backgroundColorHex: ExcelColor.yellow,
            fontColorHex: ExcelColor.black,
          );
      }

      // Add data
      for (var i = 0; i < data.length; i++) {
        sheet.cell(CellIndex.indexByString("A${i + 2}")).value =
            TextCellValue(data[i].orderId ?? "");
        sheet.cell(CellIndex.indexByString("B${i + 2}")).value =
            TextCellValue(data[i].names ?? "");
        sheet.cell(CellIndex.indexByString("C${i + 2}")).value =
            TextCellValue(data[i].custMobile ?? "");
        sheet.cell(CellIndex.indexByString("D${i + 2}")).value =
            TextCellValue(Utils.formatDateTime(date: "${data[i].orderDate}", time: "${data[i].time}"));
        sheet.cell(CellIndex.indexByString("E${i + 2}")).value =
            TextCellValue(data[i].shippingTo.toString());
        sheet.cell(CellIndex.indexByString("F${i + 2}")).value =
            TextCellValue(data[i].shippingFrom ?? "");
        sheet.cell(CellIndex.indexByString("G${i + 2}")).value =
            TextCellValue(""); //productQuantity
        sheet.cell(CellIndex.indexByString("H${i + 2}")).value =
            TextCellValue(data[i].amount ?? "");
        sheet.cell(CellIndex.indexByString("I${i + 2}")).value =
            TextCellValue(""); //PaymentType
        sheet.cell(CellIndex.indexByString("J${i + 2}")).value =
            TextCellValue(data[i].paymentStatus ?? "");
        sheet.cell(CellIndex.indexByString("K${i + 2}")).value =
            TextCellValue(data[i].status ?? "");
        sheet.cell(CellIndex.indexByString("L${i + 2}")).value =
            TextCellValue("${data[i].assignDate}"); //timePending
        sheet.cell(CellIndex.indexByString("M${i + 2}")).value =
            TextCellValue(""); //Transit DateTime
        sheet.cell(CellIndex.indexByString("N${i + 2}")).value =
            TextCellValue(""); //Delivery DateTime

      }

      var fileBytes = excel.save();
      // Save the Excel file locally
      // final directory = await getApplicationDocumentsDirectory();
      final directory = Directory("/storage/emulated/0/Download");
      String filePath =
          '${directory.path}/ComplianceReport${fromDate.day}_${toDate.day}.xlsx';

      // Save the file
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes!);

      showAlertFileSavedDialog(
          context, "The Excel report has been saved successfully.", filePath);
      print("Excel file saved: $filePath");
    } catch (e) {
      print("Error generating Excel report: $e");
    }
  }
}
