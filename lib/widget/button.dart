import 'package:flutter/material.dart';
import 'package:firstproject/Constants/colors.dart';

class StyleButton extends StatelessWidget {
  String btntext;
  Color btncolor;
  Function onpress;

  StyleButton(
      {required this.btntext,required this.btncolor,required this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          onpress(btntext);
      },
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          child: Center(child: Text(btntext,style: TextStyle(fontSize: 30,color: btncolor))),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF2B2B2B),
                blurRadius: 5,
                offset: Offset(
                    -1,-1
                ),
              ),
              BoxShadow(
                color: Color(0xFF202020),
                blurRadius: 5,
                offset: Offset(
                  2,3
                ),
              ),


            ],
            color: kbuttoncolor,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}

