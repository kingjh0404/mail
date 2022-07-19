import 'package:firebase_auth/firebase_auth.dart'; //로그인 할때 필요한 파이어 베이스 권한 라이브러리
import 'package:flutter/cupertino.dart'; //아이콘
import 'package:cloud_firestore/cloud_firestore.dart'; //cloud_firestore 라이브러리
import 'package:flutter/material.dart'; //플러터의 다양한 기본 도구(?)를 쓸때 사용하는 라이브러리
import 'package:get/get.dart'; //화면간의 이동에서 필요한 라이브러리
import 'package:get/get_core/src/get_main.dart'; //get 을 쓸때 필요한 라이브러리

import '../../util/size.dart';
import '../mail.dart';
import '../mail_content/show_mail.dart';
import '../mail_content/temporaryStorage_modal.dart';
import '../sendMail_modal.dart';
import 'mail_card.dart';

class MailList extends StatefulWidget {
  MailList(this.title, {Key? key}) : super(key: key);
  String title;

  @override
  State<MailList> createState() => _MailListState();
}

class _MailListState extends State<MailList> {
  final user = FirebaseAuth.instance.currentUser;
  late QuerySnapshot querySnapshot;

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('mail').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Mail> mailDocs = [];

          if (snapshot.hasData) {
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              var one = snapshot.data!.docs[i];
              if (one.get('writer') == user!.email ||
                  one.get('recipient') == user!.email) {
                Timestamp t = one.get('time');
                String time = DateTime.fromMicrosecondsSinceEpoch(
                        t.microsecondsSinceEpoch)
                    .toString()
                    .split(" ")[0];
                time = time.replaceAll("-", ".");

                Mail mail = Mail(
                    one.id,
                    one.get('title'),
                    one.get('content'),
                    one.get('writer'),
                    one.get('recipient'),
                    time,
                    one.get('read'),
                    one.get('sent'));

                if (widget.title == "보낸 편지함") {
                  if (one.get('writer') == user!.email &&
                      one.get('sent') == true) {
                    Mail mymail = Mail(
                        one.id,
                        one.get('title'),
                        one.get('content'),
                        one.get('writer'),
                        one.get('recipient'),
                        time,
                        true,
                        one.get('sent'));
                    mailDocs.add(mail);
                  }
                } else if (widget.title == "받은 편지함") {
                  if (one.get('recipient') == user!.email &&
                      one.get('sent') == true) {
                    mailDocs.add(mail);
                  }
                } else if (widget.title == "임시 저장") {
                  if (one.get('writer') == user!.email &&
                      one.get('sent') == false) {
                    mailDocs.add(mail);
                  }
                } else if (widget.title == "모든 메일") {
                  mailDocs.add(mail);
                } else {}
              }
            }
          }

          return ListView.builder(
              itemCount: mailDocs.length,
              itemBuilder: (context, index) {
                //사용자가 클릭하면 반응함.
                return GestureDetector(
                  onTap: () {
                    widget.title == "임시 저장"?
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      context: context,
                      builder: (context) => Container(
                        height: getScreenHeight(context) * 0.9,
                        child: ShowTemporaryStorage(mailDocs[index]),
                      ),
                    ):
                    Get.to(ShowMail(mailDocs[index]));
                  },
                  //itemCount 갯수만큼, MailCard 를 가져와서 보여줌.
                  child: MailCard(mailDocs[index]),
                );
              });
        });
  }
}
