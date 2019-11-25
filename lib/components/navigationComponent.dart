import 'package:flutter/material.dart';
import 'package:flutter_pcr/pages/listMahasiswa.dart';
import 'package:flutter_pcr/pages/tambahMahasiswa.dart';

class NavigationComponent extends StatefulWidget {

  final appBar;
  final body;

  const NavigationComponent({Key key, this.appBar, this.body}) : super(key: key);
   @override
  State<StatefulWidget> createState() {
    return _NavigationComponentState();
  }
}

class _NavigationComponentState extends State<NavigationComponent>{
  
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: widget.appBar,
    //   body: widget.body,
    //   drawer: ,
      
    // );;
    return Drawer(
        child: ListView(
            children: <Widget>[
               UserAccountsDrawerHeader(
                  accountName: Text("Rezki Nasrullah"),
                  accountEmail: Text("rezkinasrullah22@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white, 
                    child: Text("R", style: TextStyle(fontSize: 40)),
                  ),
               ),
               ListTile(
                 leading: Icon(Icons.access_alarm),
                 title: Text("Item 1"),
                 trailing: Icon(Icons.forward),
                 onTap: () => 
                 Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => ListMahasiswa())
                 ),
               ), 
               ListTile(
                 leading: Icon(Icons.access_alarm),
                 title: Text("Item 2"),
                 trailing: Icon(Icons.forward),
                 onTap: () => 
                 Navigator.push(context, 
                  MaterialPageRoute(builder: (context) => TambahMahasiswa())
                 ),
               )
            ],
        ),
      );
  }

}