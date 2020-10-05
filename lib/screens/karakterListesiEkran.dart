import 'dart:convert';
import 'package:breakingbad/screens/karakterAyrintiEkrani.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/karakter.dart';

class Karakterler extends StatefulWidget {
  @override
  _KarakterlerState createState() => _KarakterlerState();
}

class _KarakterlerState extends State<Karakterler> {
  List<Karakter> karakterDizisi = new List<Karakter>();

  void karakterlerGetir() async {
    Response res = await get('https://breakingbadapi.com/api/characters');
    // print(res.body);

    var data = await jsonDecode(res.body);
    // print(data[0]["name"]);

    setState(() {
      for (var i = 0; i < data.length; i++) {
        Karakter k = Karakter();
        k.id = data[i]['char_id'];
        k.ad = data[i]['name'];
        k.img = data[i]['img'];

        karakterDizisi.add(k);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    karakterlerGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Breaking Bad'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Ayrinti(id: -1)));
              },
              icon: Icon(Icons.autorenew),
              label: Text('Rastgele'))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Theme.of(context).backgroundColor,
              Theme.of(context).scaffoldBackgroundColor
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: ListView.builder(
          itemCount: karakterDizisi.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Ayrinti(id: karakterDizisi[index].id),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  karakterDizisi[index].ad,
                  style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 20.0,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    karakterDizisi[index].img,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
