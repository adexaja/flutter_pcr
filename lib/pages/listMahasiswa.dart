import 'package:flutter/material.dart';
import 'package:flutter_pcr/components/navigationComponent.dart';
import 'package:flutter_pcr/models/mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  ListMahasiswa({Key key}) : super(key: key);

  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  
  var dataMahasiswa = <Mahasiswa>[
      new Mahasiswa("150402002", "Rezki Nasrullah", "https://image.shutterstock.com/image-vector/people-icon-260nw-522300817.jpg"),
      new Mahasiswa("150402017", "Annisa Ulfa", "http://www.handandbeak.com/wp-content/uploads/mi/microsoft-clip-art-vector-people-icon.jpg")
    ];
  
  Widget listTile(context, index){
     return Card(
       child: ListTile(
         leading: CircleAvatar(
           radius: 30,
           backgroundImage: NetworkImage(dataMahasiswa[index].image),
         ),
         title: Text(dataMahasiswa[index].nim),
         subtitle: Text(dataMahasiswa[index].nama),
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
          child: ListView.builder(
             itemCount: dataMahasiswa.length,
             itemBuilder: (context, index) => listTile(context, index),
          ),
        ), 
        drawer: NavigationComponent(),
      );
  }
}