import 'package:get/get.dart';
import 'package:luso/controller/NetworkController.dart';

class DependencyInjection {
  static void init() {
   Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}