import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

final _formKey = GlobalKey<FormState>();
String _recipient = "";
String _writer = "";
String _title = "";
String _content = "";
late DateTime _dateTime;

class MailModal extends StatelessWidget {
  const MailModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  CollectionReference mail =
                      FirebaseFirestore.instance.collection('mail');
                  _dateTime = DateTime.now();
                  mail.add({
                    'writer': _writer,
                    'recipient': _writer,
                    'title': _title,
                    'content': _content,
                    'read': (_writer == _recipient) ? true : false,
                    'sent': false,
                    'time': _dateTime.toLocal(),
                  });
                  Get.back();
                }
              },
              child: Text(
                "취소",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "새로운 메세지",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    CollectionReference mail =
                        FirebaseFirestore.instance.collection('mail');
                    _dateTime = DateTime.now();
                    mail.add({
                      'writer': _writer,
                      'recipient': _writer,
                      'title': _title,
                      'content': _content,
                      'read': (_writer == _recipient) ? true : false,
                      'sent': true,
                      'time': _dateTime.toLocal(),
                    });
                    Get.back();
                  }
                },
                icon: Icon(
                  CupertinoIcons.arrow_up_circle_fill,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        WritingForm(),
      ],
    );
  }
}

Widget WritingForm() => Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Column(
          children: <Widget>[
            inputField("받는 사람", 0),
            inputField("보낸 사람", 1),
            inputField("제목", 2),
            TextFormField(
              onSaved: (value) {
                _content = value as String;
              },
              validator: (value) {
                if (value == null || value!.isEmpty) {
                  return "내용을 입력하세요";
                }
                return null;
              },
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.multiline,
              minLines: 40,
              maxLines: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "내용을 입력하세요",
              ),
            )
          ],
        ),
      ),
    );

Widget inputField(String text, int index) {
  return TextFormField(
    onSaved: (value) {
      if (index == 0) {
        _recipient = value as String;
      } else if (index == 1) {
        _writer = value as String;
      } else if (index == 2) {
        _title = value as String;
      }
    },
    validator: (value) {
      if (value == null || value!.isEmpty) {
        if (index == 0) {
          return "수신인을 입력하세요";
        } else if (index == 2) {
          return "제목을 입력하세요";
        }
      }
      return null;
    },
    readOnly: (index == 1) ? true : false,
    initialValue:
        (index == 1) ? FirebaseAuth.instance.currentUser!.email : null,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.next,
    autofocus: true,
    decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          fontSize: 12,
        )),
  );
}
