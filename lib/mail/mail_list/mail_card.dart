import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../mail.dart';

class MailCard extends StatelessWidget {
  MailCard(this.mailDoc, {Key? key}) : super(key: key);
  Mail? mailDoc;//mail_list.dart 에서 받아온 객체 입니다.


  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Divider(indent: 30,color:Colors.grey), //회색선을 나타내주는 것 인덴트는 간격뛰어주는 정도
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mailDoc!.read == true ? SizedBox(width: 10,)://메일을 읽었으면, 파란 동그라미가 보이지 않고, 읽지 않은 메일은 파란동그라미가 보이게 설정
                Icon(CupertinoIcons.circle_fill, size: 10, color: Colors.blueAccent,),

                SizedBox(width: 10,),
                Text(mailDoc!.recipient,//메일을 받은 사람을 보여줌
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),),

                Expanded(child: SizedBox(),),
                Text(mailDoc!.time+". ",style: TextStyle(//time 부분을 보여줌
                  color: Colors.grey,
                )),
                Icon(CupertinoIcons.chevron_right , size:15,color: Colors.grey,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                        text: mailDoc!.title,
                        style: TextStyle(
                          color: Colors.black,
                        )
                    )
                    ,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,//이 부분은 text가 width 정해진 양보다 넘치게 되면 ... 을 붙인 후, 넘친 부분은 보이지 않게 처리합니다.
                    maxLines: 2,
                    text: TextSpan(
                      //content 부분에는 2줄만 미리 보여주기를 원함.
                      //화면의 너비보다 내용의 길이가 더 길다면 그냥 내용이 나오게 하고(2줄이 당연하게 구성됨) 그렇지 않다면 개행을 추가해줘서 2줄을 유지해줍니다.
                        text:  MediaQuery.of(context).size.width < mailDoc!.content.length ? mailDoc!.content : mailDoc!.content+"\n",
                        style: TextStyle(
                          color: Colors.grey,
                        )
                    )
                    ,),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}