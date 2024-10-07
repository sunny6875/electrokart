import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePaymentController extends GetxController {

  String environment = "UAT_SIM";
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checksum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String callbackUrl =
      "https://webhook.site/555ff434-c7a9-4f6c-a5ca-21178eee01bf";
  String body = "";
  String apiEndPoint = "/pg/v1/pay";
  dynamic result;

  @override
  void onInit() {
    super.onInit();
    phonepeInit();
    body = getChecksum().toString();
  }

  void phonepeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) {
      result = 'PhonePe SDK Initialized - $val';
    }).catchError((error) {
      handleError(error);
    });
  }

  String getChecksum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "MT7850590068188104",
      "merchantUserId": "MUID123",
      "amount": 10,
      "callbackUrl": callbackUrl,
      "mobileNumber": "9999999999",
      "paymentInstrument": {"type": "PAY_PAGE"}
    };
    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));
    checksum =
    '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    return base64Body;
  }

  Future<void> startPgTransaction() async {
    try {
      var response = await PhonePePaymentSdk.startTransaction(
          body, callbackUrl, checksum, apiEndPoint);

      if (response != null) {
        String status = response['status'].toString();
        String error = response['error'].toString();
        if (status == 'SUCCESS') {
          result = "Flow complete - status : SUCCESS";
        } else {
          result = "Flow complete - status : $status and error $error";
        }
      } else {
        result = "Flow Incomplete";
      }
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    result = {"error": error};
  }
}
