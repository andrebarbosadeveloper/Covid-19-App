import 'package:LPIproject/Screens/locations/location_detail.dart';
import 'package:flutter/material.dart';
import 'package:LPIproject/Screens/location_detail/navBar.dart';
import 'package:LPIproject/Screens/login/login.dart';




import 'style.dart';

const LocationsRoute = '/locations_test';
const LocationDetailRoute = '/location_detail_test';
const LoginRoute = '/';

class App extends StatelessWidget {
  //final int locationID;
  //const App(this.locationID, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      
      Widget screen;
      switch (settings.name) {
        case LoginRoute:
          screen = LoginPageBonito();
          break;
        case LocationsRoute:
          screen = Navbar();
          break;
        case LocationDetailRoute:
          screen = LocationsDetailPageTest(arguments['id']);
          //screen = Navbar();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme() {
    return ThemeData(
        // ignore: deprecated_member_use
        appBarTheme: AppBarTheme(textTheme: TextTheme(title: AppBarTextStyle)),
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          title: TitleTextStyle,
          caption: CaptionTextStyle,
          // ignore: deprecated_member_use
          subtitle: SubTitleTextStyle,
          // ignore: deprecated_member_use
          body1: Body1TextStyle,
        ));
  }
}

main() {
  //debugPaintSizeEnabled = false;
  runApp(App());
}
