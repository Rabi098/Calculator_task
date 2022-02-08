

import 'package:firstproject/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
String strInput = "";
final textControllerInput = TextEditingController();
final textControllerResult = TextEditingController();
bool flag = false;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }
  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundblack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: "0",
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontFamily: 'RobotoMono',
                    )),
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.right,
                controller: textControllerInput,
                onTap: () =>
                    FocusScope.of(context).requestFocus(FocusNode()),
              )),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: "",
                    // fillColor: Colors.deepPurpleAccent,
                    hintStyle: TextStyle(fontFamily: 'RobotoMono')),
                textInputAction: TextInputAction.none,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'RobotoMono',
                    fontWeight: FontWeight.bold
                  // color: Colors.deepPurpleAccent
                ),
                textAlign: TextAlign.right,
                controller: textControllerResult,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());

                },)),
          SizedBox( height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('AC',kgrey,),
              btn('Del',kgrey),
              btn('%',korange),
              btn('/',korange,),],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('7', kwhite),
              btn('8', kwhite),
              btn('9', kwhite),
              btn('*',korange,),],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('4', kwhite),
              btn('5', kwhite),
              btn('6', kwhite),
              btn('-',korange,),],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btn('1', kwhite),
              btn('2', kwhite),
              btn('3', kwhite),
              btn('+', korange),],),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              zerobtn('0', kwhite),
              btn('.', korange),
              btn('=',korange),],),
          SizedBox(height: 10.0,)],),
    );
  }

  Widget btn(btntext,btncolor) {
    return GestureDetector(
      onTap: (){
        //onpress(btntext);
        setState(() {
          if(btntext == "AC")
          {
            textControllerInput.text = "";
            textControllerResult.text = "";
            flag = false;
          } else if(btntext == "Del")
          {
            textControllerInput.text = (textControllerInput.text.length > 0)
                ? (textControllerInput.text
                .substring(0, textControllerInput.text.length - 1))
                : "";
          } else if (btntext == "=")
          {
            String num = textControllerInput.text;
            if (num.endsWith("+") || num.endsWith("-") || num.endsWith("*") ||
                num.endsWith("/")) {

            }
            else {
              //Calculate everything here
              // Parse expression:
              Parser p = Parser();
              // Bind variables:
              ContextModel cm = ContextModel();
              Expression exp = p.parse(textControllerInput.text);
              setState(() {
                textControllerResult.text =
                    exp.evaluate(EvaluationType.REAL, cm).toString();
                if(textControllerResult.text.contains('.')) {
                   List<String> splitDecimal = textControllerResult.text.split('.');
                   if(!(int.parse(splitDecimal[1]) > 0))
                    textControllerResult.text = splitDecimal[0].toString();
                  }
              });
            }
          } else
          {

            if(flag==true && btntext==".")
              {
                   btntext = "";
              }

            if(btntext == "+" || btntext == "-" || btntext == "*" || btntext == "/" || btntext == "%" )
              {
                flag= false;
              }
            textControllerInput.text = textControllerInput.text + btntext;

            if(btntext == ".")
              {
                flag = true;
              }

            if(textControllerInput.text == "/")
              {
                textControllerInput.text = textControllerInput.text.replaceAll("/", "");
              }
            if(textControllerInput.text == "*")
            {
              textControllerInput.text = textControllerInput.text.replaceAll("*", "");
            }
            if(textControllerInput.text == "%")
            {
              textControllerInput.text = textControllerInput.text.replaceAll("%", "");
            }

            if(textControllerInput.text == "+")
            {
              textControllerInput.text = textControllerInput.text.replaceAll("+", "");
            }

            if(textControllerInput.text.contains("*+"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("*+", "+");
            }

            if(textControllerInput.text.contains("+*"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("+*", "*");
            }
            if(textControllerInput.text.contains("/+"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("/+", "+");
            }
            if(textControllerInput.text.contains("+/"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("+/", "/");
            }

            if(textControllerInput.text.contains("-+"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("-+", "+");
            }
            else if (textControllerInput.text.contains("+-")){
              textControllerInput.text = textControllerInput.text.replaceAll("+-", "-");
            }
            else if(textControllerInput.text.contains("-*"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("-*", "*");
            }
            else if(textControllerInput.text.contains("-/"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("-/", "/");
            }
            else if(textControllerInput.text.contains("*/"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("*/", "/");
            }
            else if(textControllerInput.text.contains("/*"))
            {
              textControllerInput.text = textControllerInput.text.replaceAll("/*", "*");
            }

          }
        });
      },
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          child: Center(child: Text(btntext != null? btntext : "Del" ,style: TextStyle(fontSize: 30,color: btncolor))),
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

  Widget zerobtn (btntext,btncolor) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if(kbackgroundblack == Color(0xFF262626)){
            kbackgroundblack = kbackgroundwhite;
            kbuttoncolor = kbackgroundwhite;
            kwhite = kblack;
          }
          else
          {
            setState(() {
              kbackgroundblack = Color(0xFF262626);
              kbuttoncolor = Color(0xFF262626);
              kwhite = Color(0xFFDFDFDF);
            });
          }
        });

      },
      onTap: () {
        textControllerInput.text = textControllerInput.text + btntext;
      },
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 80,
          child: Center(child: Text("0",style: TextStyle(fontSize: 30,color: kwhite))),
          decoration: BoxDecoration(
            boxShadow: const [
              // BoxShadow(
              //   color: Color(0xFF202020),
              //   blurRadius: 3,
              //   offset: Offset(
              //       0,-5
              //   ),
              // ),
              // BoxShadow(
              //   color: Color(0xFF2B2B2B),
              //   blurRadius: 10,
              //   offset: Offset(
              //       5,15
              //   ),
              // ),
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



// import 'package:firstproject/Constants/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firstproject/widget/button.dart';
//
// void main()
// {
//   runApp(
//       MaterialApp(
//         home: HomePage())
//       );
//
// }
//
// class HomePage extends StatefulWidget {
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   String displaytext= "0";
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: kbackgroundblack,
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width * 1,
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Text(displaytext,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 50,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 1,
//                 height: MediaQuery.of(context).size.height * 0.1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Text(displaycalculated,
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 50,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       StyleButton(btntext: "AC", btncolor: kgrey,onpress: Calculation),
//                       StyleButton(btntext: "+/-", btncolor: kgrey,onpress: Calculation),
//                       StyleButton(btntext: "%", btncolor: kgrey,onpress: Calculation),
//                       StyleButton(btntext: "÷", btncolor: korange,onpress: Calculation)
//                     ],
//                   ),
//                   SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       StyleButton(btntext: "7", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "8", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "9", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "x", btncolor: korange,onpress: Calculation)
//                     ],
//                   ),
//                   SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       StyleButton(btntext: "4", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "5", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "6", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "-", btncolor: korange,onpress: Calculation)
//                     ],
//                   ),
//                   SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       StyleButton(btntext: "1", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "2", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "3", btncolor: kwhite,onpress: Calculation),
//                       StyleButton(btntext: "+", btncolor: korange,onpress: Calculation)
//                     ],
//                   ),
//                   SizedBox(height: 15,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       //this is button Zero
//                       GestureDetector(
//                         onLongPress: () {
//                           setState(() {
//                             if(kbackgroundblack == Color(0xFF262626)){
//                               kbackgroundblack = kbackgroundwhite;
//                               kbuttoncolor = kbackgroundwhite;
//                               kwhite = kblack;
//                             }
//                             else
//                               {
//                                 setState(() {
//                                   kbackgroundblack = Color(0xFF262626);
//                                   kbuttoncolor = Color(0xFF262626);
//                                   kwhite = Color(0xFFDFDFDF);
//                                 });
//                               }
//                           });
//
//                         },
//                         onTap: () {
//                           Calculation("0");
//                         },
//                         child: Center(
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.45,
//                             height: 80,
//                             child: Center(child: Text("0",style: TextStyle(fontSize: 30,color: kwhite))),
//                             decoration: BoxDecoration(
//                               boxShadow: const [
//                                 // BoxShadow(
//                                 //   color: Color(0xFF202020),
//                                 //   blurRadius: 3,
//                                 //   offset: Offset(
//                                 //       0,-5
//                                 //   ),
//                                 // ),
//                                 // BoxShadow(
//                                 //   color: Color(0xFF2B2B2B),
//                                 //   blurRadius: 10,
//                                 //   offset: Offset(
//                                 //       5,15
//                                 //   ),
//                                 // ),
//                                 BoxShadow(
//                                   color: Color(0xFF2B2B2B),
//                                   blurRadius: 5,
//                                   offset: Offset(
//                                       -1,-1
//                                   ),
//                                 ),
//                                 BoxShadow(
//                                   color: Color(0xFF202020),
//                                   blurRadius: 5,
//                                   offset: Offset(
//                                       2,3
//                                   ),
//                                 ),
//
//                               ],
//                               color: kbuttoncolor,
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       StyleButton(btntext: ".", btncolor: korange,onpress: Calculation),
//                       StyleButton(btntext: "=", btncolor: korange,onpress: Calculation)
//                     ],
//                   ),
//
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   //Logical work
//
//   dynamic result = '';
//   dynamic finalResult = '';
//   dynamic opr = "";
//   dynamic preOpr = '';
//   dynamic checkopr = "";
//   String displaycalculated = "";
//   String temperory = "";
//
//   dynamic text ='0';
//   double firstnumber = 0;
//   double secondnumber = 0;
//
//   void Calculation(btnText) {
//
//
//     if(btnText  == 'AC') {
//       text ='0';
//       firstnumber = 0;
//       secondnumber = 0;
//       result = '';
//       finalResult = '0';
//       setState(() {
//         displaycalculated = "";
//         displaytext = "0";
//       });
//       opr = '';
//       preOpr = '';
//       checkopr = "";
//       temperory= "";
//
//     } else if( opr == '=' && btnText == '=') {
//       if(preOpr == '+') {
//         finalResult = Addition();
//       } else if( preOpr == '-') {
//         finalResult = subtraction();
//       } else if( preOpr == 'x') {
//         finalResult = multiplication();
//       } else if( preOpr == '÷') {
//         finalResult = division();
//       }
//       setState(() {
//         displaycalculated = "=" + finalResult;
//       });
//
//     } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '÷' || btnText == '=') {
//
//       // if(displaytext == "0" || secondnumber == 0) {
//       //   setState(() {
//       //     displaytext = "Invalid";
//       //   });
//       // }
//           checkopr = btnText;
//
//           if(firstnumber == 0) {
//             firstnumber = double.parse(result);
//           } else {
//             if(checkopr != "=" && checkopr != opr){
//               opr = checkopr;
//             } else {
//               secondnumber = double.parse(result);
//             }
//
//           }
//
//
//
//       if(opr == '+') {
//         finalResult = Addition();
//         setState(() {
//           displaycalculated = "=" + finalResult;
//         });
//       } else if( opr == '-') {
//         finalResult = subtraction();
//       } else if( opr == 'x') {
//         finalResult = multiplication();
//       } else if( opr == '÷') {
//         finalResult = division();
//       }
//           setState(() {
//             displaycalculated = finalResult;
//           });
//
//         preOpr = opr;
//         opr = btnText;
//
//
//
//       // if(opr != "=")
//       //   {
//       //     finalResult = opr;
//       //   }
//       temperory = result;
//       result = '';
//     }
//     else if(btnText == '%') {
//       result  = int.parse(result) / 100;
//       finalResult = doesContainDecimal(result.toString());
//     } else if(btnText == '.') {
//       if(!result.toString().contains('.')) {
//         result = result.toString()+'.';
//       }
//       finalResult = result;
//     }
//
//     else if(btnText == '+/-') {
//       result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
//       finalResult = result;
//
//     }
//
//     else {
//       result = result + btnText;
//       finalResult = result;
//
//       setState(() {
//         displaytext = temperory +  opr + result;
//       });
//     }
//
//
//
//
//
//
//
//   }
//
//   String Addition() {
//     result = (firstnumber + secondnumber).toString();
//     firstnumber = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//   String subtraction() {
//     result = (firstnumber - secondnumber).toString();
//     firstnumber = double.parse(result);
//     return doesContainDecimal(result);
//   }
//   String multiplication() {
//     result = (firstnumber * secondnumber).toString();
//     firstnumber = double.parse(result);
//     return doesContainDecimal(result);
//   }
//   String division() {
//     result = (firstnumber / secondnumber).toString();
//     firstnumber = double.parse(result);
//     return doesContainDecimal(result);
//   }
//
//
//   String doesContainDecimal(dynamic result) {
//
//     if(result.toString().contains('.')) {
//       List<String> splitDecimal = result.toString().split('.');
//       if(!(int.parse(splitDecimal[1]) > 0))
//         return result = splitDecimal[0].toString();
//     }
//     return result;
//   }
// }



