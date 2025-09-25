import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/utils/assetsManager.dart';
import 'package:contact_app/utils/colorManager.dart';
import 'package:contact_app/widgets/custom_bottom_sheet.dart';
import 'package:contact_app/widgets/screen_contact.dart';
import 'package:flutter/material.dart' hide Animation;
import '../widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contacts = [];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(AppImages.logo),
        ),
        leadingWidth: width * 0.3,
      ),
      body: contacts.isEmpty
          ? PlaceholderWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 27),
              child: ScreenContact(
                contacts: contacts,
                onContactDelete: deleteContact,
              ),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: contacts.isEmpty ? false : true,
            child: FloatingActionButton(
              onPressed: () {
                deleteLastContact();
              },
              backgroundColor: AppColor.red,
              child: Icon(Icons.delete, size: 28, color: AppColor.white),
            ),
          ),
          SizedBox(height: 12),
          Visibility(
            visible: contacts.length >= 6 ? false : true,
            child: FloatingActionButton(
              onPressed: () {
                contactSheet(context, width, height);
              },
              backgroundColor: AppColor.white,
              child: Icon(Icons.add, color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  contactSheet(BuildContext context, double width, double height) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => CustomBottomSheet(
        contacts: contacts,
        onContactAdd: () {
          setState(() {});
        },
      ),
    );
  }

  deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  deleteLastContact() {
    contacts.removeLast();
    setState(() {});
  }
}
