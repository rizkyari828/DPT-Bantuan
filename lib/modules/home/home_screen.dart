import 'package:flutter/material.dart';
import 'package:cleaner/modules/home/home.dart';
import 'package:cleaner/shared/shared.dart';

import 'package:flutter_svg/flutter_svg.dart';
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
    return controller.groupId.value == '5'
        ? BottomNavigationBar(
            iconSize: 30,
            backgroundColor: Colors.white,
            items: [
              _buildNavigationBarItem(
                "Beranda",
                MainTabs.home == controller.currentTab.value
                    ? Icon(Icons.home_rounded)
                    : Icon(Icons.home_outlined),
              ),
              _buildNavigationBarItem(
                "Absen",
                MainTabs.discover == controller.currentTab.value
                    ? Icon(Icons.alarm)
                    : Icon(Icons.alarm_outlined),
              ),
              _buildNavigationBarItem(
                "Task List",
                MainTabs.inbox == controller.currentTab.value
                    ? Icon(Icons.task)
                    : Icon(Icons.task_outlined),
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
            currentIndex:
                controller.getCurrentIndex(controller.currentTab.value),
            selectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            onTap: (index) => controller.switchTab(index),
          )
        : BottomNavigationBar(
            iconSize: 30,
            backgroundColor: Colors.white,
            items: [
              _buildNavigationBarItem(
                "Beranda",
                MainTabs.home == controller.currentTab.value
                    ? Icon(Icons.home_rounded)
                    : Icon(Icons.home_outlined),
              ),
              _buildNavigationBarItem(
                "Task List",
                MainTabs.inbox == controller.currentTab.value
                    ? Icon(Icons.task)
                    : Icon(Icons.task_outlined),
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
            currentIndex:
                controller.getCurrentIndex(controller.currentTab.value),
            selectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            onTap: (index) => controller.switchTab(index),
          );
  }

  Widget _buildContent(MainTabs tab) {
    if (controller.groupId.value == '3' || controller.groupId.value == '4') {
      switch (tab) {
        case MainTabs.home:
          return controller.mainTab;
        case MainTabs.inbox:
          return controller.taskListTab;
        case MainTabs.me:
          return controller.meTab;
        default:
          return controller.mainTab;
      }
    } else {
      switch (tab) {
        case MainTabs.home:
          return controller.mainTab;
        case MainTabs.discover:
          return controller.discoverTab;
        case MainTabs.inbox:
          return controller.taskListTab;
        case MainTabs.me:
          return controller.meTab;
        default:
          return controller.mainTab;
      }
    }
  }

  BottomNavigationBarItem _buildNavigationBarItem(String label, Icon svg) {
    return BottomNavigationBarItem(
      backgroundColor: Colors.white,
      icon: svg,
      label: label,
    );
  }
}
