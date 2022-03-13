
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class anaSayfa extends StatefulWidget {
  const anaSayfa({Key? key}) : super(key: key);

  @override
  State<anaSayfa> createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> {


  String kullaniciAdi="";
  String sifre="";


  Future <void> veriAl() async
  {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      kullaniciAdi = sp.getString("kullaniciAdi")!;
      sifre = sp.getString("parola")!;
    });

  }

  Future <void> cikis() async
  {
    var sp = await SharedPreferences.getInstance();

    sp.remove("kullaniciAdi");
    sp.remove("parola");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veriAl();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          IconButton(onPressed: ()
              {
                cikis();
              }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kullanıcı Adı: $kullaniciAdi",style: TextStyle(fontSize: 30),),
            Text("Şifre: $sifre",style: TextStyle(fontSize: 30)),
          ],

        ),


      ),

    );
  }
}
