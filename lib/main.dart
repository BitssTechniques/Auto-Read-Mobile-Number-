import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Get Mobile No.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String mobile;
  bool loadMobileNo;
  final moTextController= TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: moTextController,
                style: TextStyle(fontSize: 20.0),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(
                      20, 15, 20, 15),
                  hintText: "Enter mobile no",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,

              ),
              SizedBox(height: 5,),
              RaisedButton(
                onPressed: () async {
                  getMobile();
                },padding: EdgeInsets.all(15),
                child: Text("Load"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.red.shade500,
                textColor: Colors.white,
              )
            ],
          ),
        )


      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  getMobile () async{
    try {
      myNumber().then((val) =>
          setState(() {
            if(val==""){
              loadMobileNo=false;
              moTextController.text=val;
            } else {
              mobile = val;
              loadMobileNo=true;
              moTextController.text=val;
            }
          }));
    } on Exception catch(_){
      print("error");
    }
  }
  Future<String> myNumber() async{
    String mob="";
      try{
          mob=await MobileNumber.mobileNumber;
         } on Exception catch(e){
      debugPrint("Failed to get mobile number because of '${e.toString()}'");
    }
    if (!mounted) return "";

    return mob;

  }
}
