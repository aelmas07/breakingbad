import 'dart:convert';
import 'package:breakingbad/fonksiyonlar/card.dart';
import 'package:breakingbad/models/karakter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_fade/image_fade.dart';

class Ayrinti extends StatefulWidget {
  final int id; /* bir kere oluştuktan sonra sabit kalacağı için */
  Ayrinti({this.id});

  @override
  _AyrintiState createState() => _AyrintiState();
}

class _AyrintiState extends State<Ayrinti> {
  Karakter k = new Karakter();
  bool yukleniyor = false;

  void karakterGetir() async {
    // print(widget.id);
    Response res;
    if (widget.id == -1) {
      res = await get('https://breakingbadapi.com/api/character/random');
    } else {
      res = await get('https://breakingbadapi.com/api/characters/${widget.id}');
    }

    var data = await jsonDecode(res.body);

    setState(() {
      k.ad = data[0]['name'] == null ? 'Bilinmiyor' : data[0]['name'];
      k.img = data[0]['img'] == null ? 'Bilinmiyor' : data[0]['img'];
      k.id = data[0]['char_id'];
      k.oyuncu =
          data[0]['portrayed'] == null ? 'Bilinmiyor' : data[0]['portrayed'];
      k.takmaAd =
          data[0]['nickname'] == null ? 'Bilinmiyor' : data[0]['nickname'];
      k.durum = data[0]['status'] == null ? 'Bilinmiyor' : data[0]['status'];
      k.dogumGun =
          data[0]['birthday'] == null ? 'Bilinmiyor' : data[0]['birthday'];

      yukleniyor = true;
    });
  }

  @override
  void initState() {
    super.initState();
    karakterGetir();
  }

  @override
  Widget build(BuildContext context) {
    return yukleniyor == false
        ? Scaffold(
            body: Center(
              child: SpinKitPulse(
                color: Colors.black,
                size: 150.0,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TypewriterAnimatedTextKit(
                text: ['${k.ad}'],
                repeatForever: true,
                textStyle: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                ),
                speed: Duration(milliseconds: 500),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center
              /* yatayda */,
              mainAxisAlignment: MainAxisAlignment.center
              /* dikeyde */,
              children: <Widget>[
                Center(
                  child: ImageFade(
                    image: NetworkImage(k.img),
                    height: 200,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    fadeDuration: Duration(seconds: 5),
                    fadeCurve: Curves.bounceInOut,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 250.0,
                  child: Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                cardOlusturucu('İsim', k.ad, context),
                cardOlusturucu('Oyuncu', k.oyuncu, context),
                cardOlusturucu('Takma Ad', k.takmaAd, context),
                cardOlusturucu('Doğum Günü', k.dogumGun, context),
                cardOlusturucu('Durum', k.durum, context),
              ],
            ),
          );
  }
}
