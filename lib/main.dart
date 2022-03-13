import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AnaSayfa.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future <bool> oturumAc() async
  {
    var sp = await SharedPreferences.getInstance();
   String kull_ad= sp.getString("kullaniciAdi")!;
   String sifre = sp.getString("parola")!;

   if(kull_ad==null || sifre == null )
     {
       return false;
     }
    else
      {
        return true;
      }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home:
      FutureBuilder<bool>(
        future: oturumAc(),
        builder: (context,snaphot)
        {
          if(snaphot.hasData)
            {
              bool gecisIzni = snaphot.data!;
              return gecisIzni ? anaSayfa() : MyHomePage();

            }
          else return MyHomePage();//Center(child: Text("Veri alınamadı."),);
        },
      ),

      //MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var kullaniciAdi = TextEditingController();
  var parola = TextEditingController();
 // var scaffoldKey = GlobalKey<ScaffoldState>();

  Future <void> veriAl() async
  {


    if(kullaniciAdi.text=="sinem" && parola.text=="1234")
      {
        var sp = await SharedPreferences.getInstance();
        sp.setString("kullaniciAdi", kullaniciAdi.text);
        sp.setString("parola", parola.text);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => anaSayfa()));
      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed")));
        //  scaffoldKey.currentState.showSnackBar(snackbar)
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Ekranı"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: kullaniciAdi,
                decoration: InputDecoration(
                  label: Text("Kullanıcı Adı"),
                ),
              ),

              TextField(
                controller: parola,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text("Şifre"),
                ),
              ),

              ElevatedButton(onPressed: ()
                  {
                    veriAl();

                  }, child: Text("Giriş"))

            ],
          ),
        ),
      ),

    );
  }
}
