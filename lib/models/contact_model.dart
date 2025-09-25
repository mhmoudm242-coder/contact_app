import 'dart:io';

class ContactModel {
  String userName;
  String email;
  String phone;
  File? imageFile;

  ContactModel(
      {required this.userName, required this.email, required this.phone, this.imageFile,});
}