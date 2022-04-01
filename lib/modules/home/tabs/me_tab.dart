import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:cleaner/modules/home/home.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:get/get.dart';

class MeTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 25,
              fontFamily: 'Poppins',
            ),
          ),
          elevation: 0,
          backgroundColor: ColorConstants.mainColor,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            CustomContinuesAppBar(
                type: "medium",
                textLabel: "Profile",
                textSubtitle:
                    "Anda hanya dapar mengubah picture avatar \n pada profile"),
            Container(
              height: SizeConfig().screenHeight / 4,
              child: _buildAvatar(),
              // Stack(
              //   children: [
              //     GradientBackground(
              //       needWave: false,
              //     ),
              //     Obx(
              //       () => _buildUserInfo(),
              //     ),
              //   ],
              // ),
            ),
            _buildListData(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Widget _buildAvatar() {
    return MaterialButton(
      onPressed: () {},
      child: ClipOval(
          // borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: controller.profilePhoto.value,
        placeholder: (context, url) => Image(
          image: AssetImage('assets/images/icon_success.png'),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      )),
    );
  }

  Widget _buildListData() {
    final sw = SizeConfig().screenWidth;
    final sh = SizeConfig().screenHeight;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonWidget.captionText(
                    text: "Nama",
                  ),
                  CommonWidget.bodyText(
                    text: controller.name.value,
                  ),
                  SizedBox(height: 10),
                  CommonWidget.captionText(
                    text: "SIM ID",
                  ),
                  CommonWidget.bodyText(
                    text: controller.simId.value,
                  ),
                  SizedBox(height: 10),
                  CommonWidget.captionText(
                    text: "Group User",
                  ),
                  CommonWidget.bodyText(
                    text: controller.groupName.value,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      borderColor: ColorConstants.mainColor,
                      buttonColor: Colors.white,
                      buttonTextColor: ColorConstants.mainColor,
                      buttonText: 'LOGOUT',
                      width: sw,
                      onPressed: controller.signout),
                ],
              )),
        ),
      ),
    );
  }
}
