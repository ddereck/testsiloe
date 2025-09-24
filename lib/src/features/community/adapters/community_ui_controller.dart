import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../di/controllers_provider.dart' show ControllersProvider;
import '../../user/domain/entities/entity_user.dart' show EntityUser;

class CommunityUIController extends GetxController {


  RxList<EntityUser> allUsers = <EntityUser>[].obs;
  
  final searchFormState = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  Future<void> onSearch() async {
    final users = await ControllersProvider.USER_CONTROLLER.getAllUsers(search: searchController.text);
    allUsers.value = users;
    update();
  }

  Future<void> initUers() async {
    final users = await ControllersProvider.USER_CONTROLLER.getAllUsers();
    allUsers.value = users;
    update();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}