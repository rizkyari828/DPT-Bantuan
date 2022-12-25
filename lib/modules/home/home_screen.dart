import 'package:flutter/material.dart';
import 'package:konconeDeDe/modules/home/home.dart';
import 'package:konconeDeDe/shared/shared.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Obx(() => _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Scaffold(
      body: Center(
        child: _buildContent(controller.currentTab.value),
      ),
      bottomNavigationBar: _navBar(),
    );
  }

  Widget _navBar() {
    return BottomNavigationBar(
      elevation: 0,
      iconSize: 30,
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      items: [
        _buildNavigationBarItem(
          "Beranda",
          MainTabs.home == controller.currentTab.value
              ? Icon(Icons.home_rounded)
              : Icon(Icons.home_outlined),
        ),
        _buildNavigationBarItem(
          "Profile",
          MainTabs.me == controller.currentTab.value
              ? Icon(Icons.person_rounded)
              : Icon(Icons.person_outline_rounded),
        )
      ],
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: ColorConstants.mainColor,
      currentIndex: controller.getCurrentIndex(controller.currentTab.value),
      selectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      onTap: (index) => controller.switchTab(index),
    );
  }

  Widget _buildContent(MainTabs tab) {
    switch (tab) {
      case MainTabs.home:
        return controller.mainTab;
      case MainTabs.me:
        return controller.meTab;
      default:
        return controller.mainTab;
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, Icon svg) {
    return BottomNavigationBarItem(
      backgroundColor: ColorConstants.lightScaffoldBackgroundColor,
      icon: svg,
      label: label,
    );
  }
}
