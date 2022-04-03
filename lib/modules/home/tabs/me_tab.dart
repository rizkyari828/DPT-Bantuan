import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaner/shared/widgets/button.dart';
import 'package:cleaner/shared/widgets/custom_appbar.dart';
import 'package:cleaner/shared/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:cleaner/modules/home/home.dart';
import 'package:cleaner/shared/shared.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
              fontSize: 20,
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
                    "Anda hanya dapat mengubah picture avatar \npada profile"),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                changePhoto(context, controller);
              },
              child: Obx(() => Container(
                    height: SizeConfig().screenWidth * 0.4,
                    width: SizeConfig().screenWidth * 0.4,
                    child: _buildAvatar(),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            _buildListData(),
            SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  Widget _buildAvatar() {
    return ClipOval(
        // borderRadius: BorderRadius.circular(10.0),
        child: CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: controller.profilePhoto.value,
      placeholder: (context, url) => Image(
        image: AssetImage('assets/images/icon_success.png'),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ));
  }

  Widget _buildListData() {
    final sw = SizeConfig().screenWidth;
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

  void changePhoto(context, controller) {
    Get.defaultDialog(
      title: "Ubah Foto Profil",
      content: Obx(() => Column(
            children: [
              Container(
                height: 100,
                width: 100,
                child: CustomImagePicker.previewImages(controller),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Container(
                        decoration: new BoxDecoration(
                          color: ColorConstants.mainColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                              offset: Offset(
                                -10.0,
                                10.0,
                              ),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        controller.onImageButtonPressed(ImageSource.camera,
                            context: context);
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      child: Container(
                        decoration: new BoxDecoration(
                          color: ColorConstants.mainColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20.0,
                              spreadRadius: 4.0,
                              offset: Offset(
                                -10.0,
                                10.0,
                              ),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        controller.onImageButtonPressed(ImageSource.gallery,
                            context: context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
      textConfirm: 'Submit',
      textCancel: 'Batal',
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        controller.submitPhotoProfile();
      },
    );
  }
}
