import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mail/mail/mail_list/mail_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F6),
      body: SafeArea(
        child: ListView (
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(
                          CupertinoIcons.square_arrow_left,
                          size: 20,
                          color: Colors.blueAccent,
                        ),),
                      Text(
                        "편집",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "메일상자",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:8),
                        color: Colors.white,
                        child: Column(
                          children:[
                          _mainButton(CupertinoIcons.tray, "받은 편지함"),
                          Divider(indent: 50, color: Colors.grey),
                          _mainButton(CupertinoIcons.star, "VIP"),
                          Divider(indent: 50, color: Colors.grey),
                          _mainButton(CupertinoIcons.flag, "깃발 표시됨"),
                          Divider(indent: 50, color: Colors.grey),
                          ],

                      )
                  ),
                  ),

                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Gmail",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      ],
                  ),
                      SizedBox(
                        height: 10,
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white,
                          child: Column(
                            children: [
                              _mainButton(CupertinoIcons.doc,"임시저장"),
                              Divider(indent: 50,color: Colors.grey,),

                              _mainButton(CupertinoIcons.paperplane,"보낸편지함"),
                              Divider(indent: 50,color: Colors.grey,),

                              _mainButton(CupertinoIcons.bin_xmark,"정크"),
                              Divider(indent: 50,color: Colors.grey,),

                              _mainButton(CupertinoIcons.delete,"휴지통"),
                              Divider(indent: 50,color: Colors.grey,),

                              _mainButton(CupertinoIcons.archivebox,"모든메일"),
                              Divider(indent: 50,color: Colors.grey,),

                              _mainButton(CupertinoIcons.folder,"별표 편지함"),
                              Divider(indent: 50,color: Colors.grey,),
                            ],

                          ),
                        ),
                      ),
        ],
              ),
            )



          ],

        ),
      ),
    );
  }
}

Widget _mainButton( IconData icon, String title){
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0),
      child: Stack( alignment: AlignmentDirectional.centerStart,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.blueAccent,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                CupertinoIcons.chevron_right,
                size: 15,
                color: Colors.grey,
              ),
            ],
          ),
        ],

      ),
    ),
    onTap: (){
      Get.to(MailScreen(title));
    },
  );
}
