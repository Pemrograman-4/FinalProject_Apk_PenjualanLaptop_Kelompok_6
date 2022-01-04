import 'dart:io';

import 'package:flutter_application_1/server/server.dart';
import 'package:flutter_application_1/ui/detail_produk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ProdukView extends StatelessWidget {
  final String apiUrl = UrlServer + "produk/get";
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    List<dynamic>? fecthDataProduk;
  }

  Future<List<dynamic>> getLists() async {
    var response = await http.get(Uri.parse(apiUrl));
    try {
      var decodedResponse = json.decode(response.body)['data'];
      print(decodedResponse);
      return decodedResponse;
    } on SocketException catch (_) {}
    return [];
  }

  void setDetail(BuildContext context, id, brand, processor, ram, vga, hardisk,
      harga) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('_id', id);
    await prefs.setString('brand', brand);
    await prefs.setString('processor', processor);
    await prefs.setString('ram', ram);
    await prefs.setString('vga', vga);
    await prefs.setString('hardisk', hardisk);
    await prefs.setString('harga', harga);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => detail_produk_view(
                id: id,
                brand: brand,
                processor: processor,
                ram: ram,
                vga: vga,
                hardisk: hardisk,
                harga: harga)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Anda'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getLists(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => setDetail(
                        context,
                        snapshot.data[index]['_id'],
                        snapshot.data[index]['brand'],
                        snapshot.data[index]['processor'],
                        snapshot.data[index]['ram'],
                        snapshot.data[index]['vga'],
                        snapshot.data[index]['hardisk'],
                        snapshot.data[index]['harga'],
                      ),
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.asset('assets/laptop.png'),
                              // child: Image.network("http://pasar.pptik.id/" +
                              //     snapshot.data[index]['IMAGE']),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 2.0, 0.0),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index]['brand'],
                                    style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  subtitle: Text("Processor : " +
                                      snapshot.data[index]['processor'] +
                                      "" +
                                      "                                                                                  " +
                                      "RAM : " +
                                      snapshot.data[index]['ram'] +
                                      "" +
                                      "                                                                                   " +
                                      "VGA : " +
                                      snapshot.data[index]['vga'] +
                                      "" +
                                      "                                                                                           " +
                                      "hardisk : " +
                                      snapshot.data[index]['hardisk'] +
                                      "" +
                                      "                                                                          " +
                                      "harga : Rp. " +
                                      snapshot.data[index]['harga']),

                                  // Text(),

                                  // author: author,
                                  // publishDate: publishDate,
                                  // readDuration: readDuration,
                                ),
                              ),
                            ),
                            // child:Card(),

                            // child:Text('Detail'),
                            // Expanded(child: Text)
                            // widget(child:)
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
