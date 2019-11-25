import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pcr/components/navigationComponent.dart';
import 'package:flutter_pcr/models/mahasiswa.dart';
import 'package:flutter_pcr/services/mahasiswaService.dart';

class ListMahasiswa extends StatefulWidget {
  ListMahasiswa({Key key}) : super(key: key);

  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  
  Widget listTile(List<Mahasiswa> arrayMahasiswa, context, index){
     return Card(
       child: ListTile(
         leading: CircleAvatar(
           radius: 30,
           backgroundImage: 
                arrayMahasiswa[index].foto != "" && arrayMahasiswa[index].foto != null ? // jika foto tidak kosong dan null
                FileImage(File(arrayMahasiswa[index].foto)) : 
                NetworkImage("https://via.placeholder.com/300/09f/a71000.png"),
         ),
         title: Text(arrayMahasiswa[index].nim.toString()),
         subtitle: Text(arrayMahasiswa[index].nama),
         trailing: Icon(Icons.restore_from_trash),
       ),
     );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: FutureBuilder(
            future: MahahasiswaService.getMahasiswa(),
            builder: (context, AsyncSnapshot<List<Mahasiswa>> snapshot) {
                if(snapshot.hasData)
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => listTile(snapshot.data, context, index),
                    );
                else 
                    return Container(
                      child: Center(
                         child: CircularProgressIndicator(),
                      ),
                    );
            }
          ),
        ), 
        drawer: NavigationComponent(),
      );
  }
}