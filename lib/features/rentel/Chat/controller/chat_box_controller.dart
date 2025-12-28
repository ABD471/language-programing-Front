import 'package:apartment_rental_system/api/apiService.dart';
import 'package:apartment_rental_system/api/urlClient.dart';
import 'package:apartment_rental_system/features/rentel/Chat/model/messageModel.dart';
import 'package:get/get.dart';

class ChatBoxController extends GetxController {
  var conversations = <MessageModel>[].obs; // قائمة المحادثات
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getChatList();
  }

  // جلب البيانات من Laravel
  Future<void> getChatList() async {
    try {
      isLoading(true);
      var response = await ApiService.getRequest(
        url: "${urlClient['chat_list']}",
        useAuth: true,
      );
      if (response['statusCode'] == 200) {
        List data = response['body']["body"];
        conversations.assignAll(
          data.map((e) => MessageModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      print(conversations.length);
      isLoading(false);
    }
  }
}
