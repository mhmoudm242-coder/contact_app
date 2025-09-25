import 'dart:io';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/widgets/custom_text_form_field.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart' hide Animation;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/assetsManager.dart';
import '../utils/colorManager.dart';

class CustomBottomSheet extends StatefulWidget {
  List<ContactModel> contacts;
  VoidCallback onContactAdd;

  CustomBottomSheet({
    super.key,
    required this.contacts,
    required this.onContactAdd,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String userName = "User Name";
    String userMail = "User E-mail";
    String userPhone = "User Phone";

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(28),
            topLeft: Radius.circular(28),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColor.white),
                      ),
                      child: pickedImage == null
                          ? GestureDetector(
                              onTap: () async {
                                File? tempImage = await galleryPicker();
                                if (tempImage != null) {
                                  pickedImage = tempImage;
                                }
                                setState(() {});
                              },
                              child: Lottie.asset(AppAnimation.imagePicker),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.file(pickedImage!, fit: BoxFit.fill),
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                            valueListenable: userNameController,
                            builder: (context, value, child) => Text(
                              value.text.isEmpty ? userName : value.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                            ),
                          ),

                          Divider(color: AppColor.white),
                          ValueListenableBuilder(
                            valueListenable: userEmailController,
                            builder: (context, value, child) => Text(
                              value.text.isEmpty ? userMail : value.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                          Divider(color: AppColor.white),
                          ValueListenableBuilder(
                            valueListenable: userPhoneController,
                            builder: (context, value, child) => Text(
                              value.text.isEmpty ? userPhone : value.text,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user name';
                        }
                        return null;
                      },
                      controller: userNameController,
                      hintText: 'Enter User Name',
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user mail';
                        }
                        return null;
                      },
                      controller: userEmailController,
                      hintText: 'Enter User E-mail ',
                    ),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter user phone';
                        }
                        return null;
                      },
                      controller: userPhoneController,
                      hintText: 'Enter User Phone ',
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(width, height * 0.06),
                        backgroundColor: AppColor.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          addContact();
                        });
                      },
                      child: Text(
                        "Enter User",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addContact() {
    if (formKey.currentState!.validate()) {
      widget.contacts.add(
        ContactModel(
          userName: userNameController.text,
          email: userEmailController.text,
          phone: userPhoneController.text,
          imageFile: pickedImage,
        ),
      );
      widget.onContactAdd;
      Navigator.pop(context);
    }
    setState(() {});
  }

  Future<File?> galleryPicker() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.photos.request();
    }
    if (status.isGranted) {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      }
      return null;
    }
    return null;
  }
}
