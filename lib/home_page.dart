import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_locations.dart';
import 'package:weather_app/widgets/slider.dart';
import 'package:weather_app/widgets/weather_template.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  String _bgImg = "";

  String cityQuery = "Delhi";
  
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text( '' );
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Color appBarColor = Colors.transparent;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(locationList[_currentPage].weatherType.toLowerCase() == "sunny" || locationList[_currentPage].weatherType.toLowerCase() == "clear" ) {
      _bgImg = 'assets/sunny.jpg';
    } else if(locationList[_currentPage].weatherType.toLowerCase() == "cloudy" ||
    locationList[_currentPage].weatherType.toLowerCase() == "clouds") {
      _bgImg = 'assets/cloudy.jpeg';
    } else if(locationList[_currentPage].weatherType.toLowerCase() == "night") {
      _bgImg = 'assets/night.jpg';
    } else if(locationList[_currentPage].weatherType.toLowerCase() == "rain") {
      _bgImg = 'assets/rainy.jpg';
    } else if(locationList[_currentPage].weatherType.toLowerCase() == "haze") {
      _bgImg = 'assets/haze.jpg';
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Title",
      home: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appBarColor,
          leading: IconButton(
            icon: _searchIcon,
            onPressed: () {
              setState(() {
                if(this._searchIcon.icon == Icons.search) {
                  // this.appBarColor = Colors.white;
                  this._searchIcon = new Icon(Icons.close);
                  this._appBarTitle = new TextField(
                    style: TextStyle(color: Colors.black),
                    controller: myController,
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search),
                      hintText: "Search...",
                      fillColor: Colors.white38,
                      filled: true,
                    ),
                  );
                  // print(cityQuery);
                } else {
                  this._searchIcon = new Icon(Icons.search);
                  this._appBarTitle = new Text("");
                  this.appBarColor = Colors.transparent;
                  // print(cityQuery);
                  // myController.clear();
                }
                cityQuery = myController.text;
              });
              // print(cityQuery);
              fetchWeather(cityQuery);
            },
          ),
          title: _appBarTitle,
          actions: [
            IconButton(onPressed: () {
              print("Menu tapped");
            }, icon: Icon(Icons.menu,color: Colors.white,))
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Image.asset(
                _bgImg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black38),
              ),
              Container(
                margin: EdgeInsets.only(top:120, left: 20),
                child: Row(
                  children: [
                    for(int i=0;i<locationList.length;i++)
                      if( i==_currentPage)
                        SliderDot(true)
                    else
                      SliderDot(false)
                  ],
                ),
              ),
              PageView.builder(
                // pageSnapping: true,
                physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                onPageChanged: _onPageChanged,
                itemCount: locationList.length,
                itemBuilder: (ctx,i) => WeatherTemplate(i),
              ),
              // WeatherTemplate()
              ],
            ),
        )),
    );
  }
}
