import 'package:contact_app/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'contact_card.dart';

class ScreenContact extends StatefulWidget {
  List<ContactModel> contacts;
  Function onContactDelete;

  ScreenContact({
    super.key,
    required this.contacts,
    required this.onContactDelete,
  });

  @override
  State<ScreenContact> createState() => _ScreenContactState();
}

class _ScreenContactState extends State<ScreenContact> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, index) => ContactCard(
          contact: widget.contacts[index],
          deleteContact: () {
            setState(() {
              widget.onContactDelete(index);
            });
          },
        ),
        itemCount: widget.contacts.length,
      ),
    );
  }
}
