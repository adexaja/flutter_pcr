import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_pcr/components/navigationComponent.dart';
import 'package:flutter_pcr/models/mahasiswa.dart';
import 'package:flutter_pcr/pages/listMahasiswa.dart';
import 'package:flutter_pcr/services/mahasiswaService.dart';
import 'package:image_picker/image_picker.dart';

class TambahMahasiswa extends StatefulWidget {
  TambahMahasiswa({Key key}) : super(key: key);

  @override
  _TambahMahasiswaState createState() => _TambahMahasiswaState();
}

class _TambahMahasiswaState extends State<TambahMahasiswa> {
  
  var formKey = new GlobalKey<FormState>();
  var namaController = new TextEditingController();
  var nimController = new TextEditingController();
  var imageController = new TextEditingController();
  Widget fieldNama() {
    return TextFormField(
       decoration: InputDecoration(
          labelText: "Nama Lengkap",
          hintText: 'Masukkan nama lengkap anda'
       ),
       controller: namaController,
       validator: (value){
          if(value.isEmpty){
             return 'Nama tidak boleh kosong';
          }
          return null;
       },
    );
  }
  Widget fieldNim() {
    return TextFormField(
       decoration: InputDecoration(
          labelText: "NIM",
          hintText: 'Masukkan nim anda'
       ),
       controller: nimController,
       validator: (value){
          if(value.isEmpty){
             return 'Nim kosong';
          }
          return null;
       },
    );
  }

  Widget buttonDaftar(){
    return RaisedButton(
      color: Colors.blueAccent,
      child: Text("Daftar", style: TextStyle(color: Colors.white)),
      onPressed: (){
          if(formKey.currentState.validate()){
             formKey.currentState.save();

            print("Nama Lengkap : ${namaController.text}");
            print("NIM : ${nimController.text}");
            print("Nama Lengkap : ${imageController.text}");
            MahahasiswaService.saveMahasiswa(nimController.text, namaController.text, _jenisKelamin, _image.path).then((response){
               // jika sukses atau gagal bisa dilihat dari response.data
               // response.data itu adalah array output dari API

               Navigator.push(context, MaterialPageRoute(
                 builder: (context) => ListMahasiswa()
               ));
            });
          }
      },
    );
  }
  File _image;
  getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  
    setState(() {
      _image = image;
    });

    print(_image.path);
  }
  Widget fieldGambar() {
    return  GestureDetector(
        onTap: () => getImage(),
        child: Container(
              child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Colors.blue,
                  backgroundImage:  _image != null ? FileImage(_image) : NetworkImage("https://via.placeholder.com/150/771796"),
              ),
        )
      );
  }
  Widget radioJenisKelamin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         Radio(
            value: 'L',
            groupValue: _jenisKelamin,
            onChanged: _handleJenisKelamin,
         ),
         Text("Laki-Laki"),
         Radio(
            value: 'P',
            groupValue: _jenisKelamin,
            onChanged: _handleJenisKelamin,
         ),
         Text("Perempuan")
      ],
    );
  }

  String _jenisKelamin;
  _handleJenisKelamin(value){
     setState(() {
        _jenisKelamin = value;
     });
    //  _jenisKelamin = value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Mahasiswa"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
               children: <Widget>[
                  fieldNama(),
                  fieldNim(),
                  fieldGambar(),
                  radioJenisKelamin(),
                  buttonDaftar()
               ],
            ),
          ),
        ), 
        drawer: NavigationComponent(),
      );
  }
}