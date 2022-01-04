import 'dart:async';
import 'package:flutter_application_1/const/collor.dart';
import 'package:flutter_application_1/server/server.dart';
import 'package:flutter_application_1/ui/home.dart';
import 'package:flutter_application_1/ui/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddProduk extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<AddProduk> {
  //Tambahkan varibale untuk menampung data dari inputan
  TextEditingController brand_laptop = new TextEditingController();
  TextEditingController processor_laptop = new TextEditingController();
  TextEditingController ram_laptop = new TextEditingController();
  TextEditingController vga_laptop = new TextEditingController();
  TextEditingController hardisk_laptop = new TextEditingController();
  TextEditingController harga_laptop = new TextEditingController();

  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Simpan() async {
    var url = "http://localhost:5000/produk/add";
    String brand = brand_laptop.text;
    String processor = processor_laptop.text;
    String ram = ram_laptop.text;
    String vga = vga_laptop.text;
    String hardisk = hardisk_laptop.text;
    String harga = harga_laptop.text;
    if (brand.isEmpty ||
        processor.isEmpty ||
        ram.isEmpty ||
        vga.isEmpty ||
        hardisk.isEmpty ||
        harga.isEmpty) {
      // Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Tidak Kosong !', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "brand": brand,
        "processor": processor,
        "ram": ram,
        "vga": vga,
        "hardisk": hardisk,
        "harga": harga
      });
      var result = convert.jsonDecode(response.body);
      String Message = result['message'];
      if (result['status']) {
        // Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        var _duration = const Duration(seconds: 1);
        Timer(_duration, () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => homepage()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 15),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/iconlaptop.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Tambah Produk',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: brand_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Brand Laptop',
                    hintText: 'Masukan Brand Laptop'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: processor_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Processor',
                    hintText: 'Masukan Processor'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: ram_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'RAM',
                    hintText: 'Masukan RAM'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: vga_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'VGA',
                    hintText: 'Masukan VGA'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: hardisk_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Hardisk',
                    hintText: 'Masukan hardisk'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: harga_laptop,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Harga',
                    hintText: 'Masukan Harga'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Simpan();
    } catch (error) {
      print(error);
    }
  }
}
