import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../mail.dart';

class ShowMail extends StatelessWidget {
  ShowMail(this.mailDoc, {Key? key}) : super(key: key);
  Mail ? mailDoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상세 메일",
          style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black,//색변경
          size: 15,
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(30, 10,0,0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(CupertinoIcons.circle_fill, size: 40,color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width:MediaQuery.of(context).size.width - 85,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mailDoc!.writer,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),),
                              Text(mailDoc!.time+".",style: TextStyle(
                                color: Colors.grey,
                              )),
                            ],

                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text("받는 사람: ",),
                            Text(mailDoc!.writer+" ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),),
                            Icon(CupertinoIcons.chevron_right , size:12,color: Colors.grey,),
                          ],
                        ),

                      ],
                    ),
                  ),


                ],
              ),

              Divider(color: Colors.black45,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mailDoc!.title,style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),),
                  Text(mailDoc!.content,)
                ],
              ),


            ],
          ),
        ],
      ),
      bottomNavigationBar:BottomAppBar(
        child: Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.archivebox , color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.folder, color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.arrowshape_turn_up_left , color: Colors.blueAccent,)),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.pencil_outline, color: Colors.blueAccent,)),


          ],
        ),
      ) ,
    );
  }
}