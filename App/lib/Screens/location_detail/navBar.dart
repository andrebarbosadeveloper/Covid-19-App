import 'package:LPIproject/Screens/Search/searchtest.dart';
import 'package:LPIproject/Screens/locations/locations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:LPIproject/Screens/profile/profile.dart';

class Navbar extends StatefulWidget{
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar>{

  int _currentIndex=0;
  List<Widget> pages=<Widget>[
    //Locations(),
    LocationsPageTest(),
    //SearchPage(),
    SearchPageTest(),
    ProfilePage(),

  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child:pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex ,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Procurar"),
              backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Área Pessoal"),
              backgroundColor: Colors.black
          ),
        ],
        onTap:(index){
          setState((){
            _currentIndex= index;
          });
        },
      ),
    );
  }
}