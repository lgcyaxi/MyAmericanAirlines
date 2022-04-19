import 'dart:async';
import 'package:flutter/material.dart';
import 'cli.dart' as cli;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'American Airlines',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('American Airlines'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/aa_logo.png',
              width: MediaQuery.of(context).size.width - 100.0,
              height: MediaQuery.of(context).size.width / 2 - 50.0,
              fit: BoxFit.cover,
            ),
            new MaterialButton(
              minWidth: MediaQuery.of(context).size.width - 100.0,
              height: MediaQuery.of(context).size.width / 2 - 50.0,
              child: new Text(
                " Booking ",
                style: new TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new BookingPage();
                }));
              },
              color: Colors.blueAccent,
              splashColor: Colors.grey,
            ),
            SizedBox(height: 20.0),
            new MaterialButton(
              minWidth: MediaQuery.of(context).size.width - 100.0,
              height: MediaQuery.of(context).size.width / 2 - 50.0,
              child: new Text(
                " Check In ",
                style: new TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new CheckInScreen();
                }));
              },
              color: Colors.blueAccent,
              splashColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  checkIn() {
    print('check in.');
  }
}

class BookingPage extends StatefulWidget {
  BookingPage({Key key}) : super(key: key);

  @override
  BookingPage1 createState() => BookingPage1();
}

class BookingPage1 extends State<BookingPage> {
  final TextEditingController controller1 = new TextEditingController();
  final TextEditingController controller2 = new TextEditingController();
  String departure = "Tucson";
  String arrival = "Phoenix";

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('American Airlines'),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.only(top: 50, right: 50),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Center(
          child: new Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRI1csq6rHjC2UMZXM8yws3Nh33UE0Lrc5V18jc8DKdgfCupjMB',
                        height: 60.0,
                        width: 60.0),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: new InputDecoration(hintText: "Tucson"),
                      controller: controller1,
//                      onSubmitted: (String str) {
//                        setState(() {
//                          departure = str;
//                        });
//                      },
                    ),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                        'https://www.pngrepo.com/png/197159/170/arrival.png',
                        height: 60.0,
                        width: 60.0),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: new InputDecoration(hintText: "Phoneix"),
                      controller: controller2,
//                      onSubmitted: (String str) {
//                        setState(() {
//                          arrival = str;
//                        });
//                      },
                    ),
                  ),
                  //TableCalendar(),
                ],
              ),
              const SizedBox(height: 100),
              new Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(Icons.access_time),
                  ),
                  const SizedBox(width: 0),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => _selectDate(context),
                      child:
                          new Text("${selectedDate.toLocal()}".split(' ')[0]),
                    ),
                  ),
                  //Icon(Icons.access_time),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScreen(
                  loc: new Location(controller1.text, controller2.text, selectedDate)),
            ),
          );
        },
        label: Text('NEXT'),
        icon: Icon(Icons.beenhere),
        backgroundColor: Colors.orange,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Location {
  final String departure;
  final String arrival;
  final DateTime date;

  Location(this.departure, this.arrival, this.date);
}

class Info {
  final String departure;
  final String arrival;
  final DateTime date;
  final int adult;
  final int child;
  final int seat;
  final int type;

  Info(this.departure, this.arrival, this.date, this.adult, this.child,
      this.seat, this.type);
}

class Flight{
  String from;
  String to;
  String departTime;
  String arriveTime;
  String flightNum;

  Flight(
      this.from,
      this.to,
      this.departTime,
      this.arriveTime,
      this.flightNum,
      );
}

class BookingScreen extends StatefulWidget {
  final Location loc;

  BookingScreen({Key key, @required this.loc}) : super(key: key);

  @override
  BookingPage2 createState() => BookingPage2();
}

class BookingPage2 extends State<BookingScreen> {
  int _adultCount = 1;
  int _childCount = 0;
  int seat = 1;
  int type = 2;
  Timer timer;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Details"),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.all(50),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                Text("Adult            "),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    child: Text(
                      '$_adultCount',
                      style: TextStyle(color: Color(0xff333333), fontSize: 20),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    new GestureDetector(child: Container(
                      width: 50,
                      height: 30,
                      child: Icon(Icons.remove),
                    ),
                      onTap: () {
                        setState(() {
                          if (_adultCount <= 1) {
                            return;
                          }
                          _adultCount--;
                        });
                      },
                      onTapDown: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                        if (_adultCount <= 1) {
                          return;
                        }
                        timer = new Timer.periodic(Duration(milliseconds: 1000), (e) {
                          setState(() {
                            if (_adultCount <= 1) {
                              return;
                            }
                            _adultCount--;
                          });
                        });
                      },
                      onTapUp: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                      onTapCancel: () {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                    ),
                    new GestureDetector(
                      child: Container(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.add),
                      ),
                      onTap: () {
                        setState(() {
                          if (_adultCount >= 999999999) {
                            return;
                          }
                          _adultCount++;
                        });
                      },
                      onTapDown: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                        if (_adultCount >= 999999999) {
                          return;
                        }
                        timer = new Timer.periodic(Duration(milliseconds: 1000), (e) {
                          setState(() {
                            if (_adultCount >= 999999999) {
                              return;
                            }
                            _adultCount++;
                          });
                        });
                      },
                      onTapUp: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                      onTapCancel: () {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),

            new Row(
              children: <Widget>[
                Text("Children       "),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Align(
                    child: Text(
                      '$_childCount',
                      style: TextStyle(color: Color(0xff333333), fontSize: 20),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    new GestureDetector(child: Container(
                      width: 50,
                      height: 30,
                      child: Icon(Icons.remove),
                    ),
                      onTap: () {
                        setState(() {
                          if (_childCount <= 0) {
                            return;
                          }
                          _childCount--;
                        });
                      },
                      onTapDown: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                        if (_childCount <= 0) {
                          return;
                        }
                        timer = new Timer.periodic(Duration(milliseconds: 1000), (e) {
                          setState(() {
                            if (_childCount <= 0) {
                              return;
                            }
                            _childCount--;
                          });
                        });
                      },
                      onTapUp: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                      onTapCancel: () {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                    ),
                    new GestureDetector(
                      child: Container(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.add),
                      ),
                      onTap: () {
                        setState(() {
                          if (_childCount >= 999999999) {
                            return;
                          }
                          _childCount++;
                        });
                      },
                      onTapDown: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                        if (_childCount >= 999999999) {
                          return;
                        }
                        timer = new Timer.periodic(Duration(milliseconds: 1000), (e) {
                          setState(() {
                            if (_childCount >= 999999999) {
                              return;
                            }
                            _childCount++;
                          });
                        });
                      },
                      onTapUp: (e) {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                      onTapCancel: () {
                        if (timer != null) {
                          timer.cancel();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            new Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: seat,
                  onChanged: (T) {
                    print(T);
                    setState(() {
                      seat = T;
                    });
                  },
                ),
                Text("FirstClass"),
                Radio(
                  value: 2,
                  groupValue: seat,
                  onChanged: (T) {
                    print(T);
                    setState(() {
                      seat = T;
                    });
                  },
                ),
                Text("Busin."),
                Radio(
                  value: 3,
                  groupValue: seat,
                  onChanged: (T) {
                    print(T);
                    setState(() {
                      seat = T;
                    });
                  },
                ),
                Text("Econ."),
              ],
            ),
            const SizedBox(height: 50),
            new Row(
              children: <Widget>[
                Radio(
                  value: 1,
                  groupValue: type,
                  onChanged: (T) {
                    print(T);
                    setState(() {
                      type = T;
                    });
                  },
                ),
                Text("One Way"),
                Radio(
                  value: 2,
                  groupValue: type,
                  onChanged: (T) {
                    print(T);
                    setState(() {
                      type = T;
                    });
                  },
                ),
                Text("Round Trip"),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingPage3(
                  info: new Info(widget.loc.departure, widget.loc.arrival,
                      widget.loc.date, _adultCount, _childCount, seat, type)),
            ),
          );
        },
        label: Text('NEXT'),
        icon: Icon(Icons.beenhere),
        backgroundColor: Colors.orange,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class BookingPage3 extends StatelessWidget {
  final Info info;
  String seat = "";
  String type = "";

  BookingPage3({Key key, @required this.info}) : super(key: key);

  Widget build(BuildContext context) {
    if (this.info.seat == 1) {
      seat = "FirstClass";
    } else if (this.info.seat == 2) {
      seat = "Business";
    } else {
      seat = "Economy";
    }
    if (this.info.type == 1) {
      type = "One Way";
    } else {
      type = "Round Trip";
    }
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Conformation"),
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.all(100),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          children: <Widget>[
            Text('From  ' +
                this.info.departure +
                '  |   To  ' +
                this.info.arrival),
            const SizedBox(height: 50),
            Text('Date: ' +
                this.info.date.year.toString() +
                "-" +
                this.info.date.month.toString() +
                "-" +
                this.info.date.day.toString() +
                " (yyyy/mm/dd)"),
            const SizedBox(height: 50),
            Text('Adult(s):  ' +
                this.info.adult.toString() +
                '  |   Children  ' +
                this.info.child.toString()),
            const SizedBox(height: 50),
            Text(seat + '  |   ' + type),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FlightListScreen(
                  locInfo: new Location(info.departure, info.arrival,
                      info.date)),
            ),
          );
        },
        label: Text('CONFIRM'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.orange,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// ---------------------------------TESTING--------------------------------
class FlightsMockData {


  static var count = 5;

  static var from = ["BBI", "CCU", "HYD", "BOM", "JAI"];
  static var to = ["BLR", "JAI", "BBI", "CCU", "AMD"];
  static var departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
  static var arriveTime = ["8:40 AM", "7:25 PM", "4:00 PM", "8:21 AM", "3:25 PM"];
  static var flightsNum = ["1111", "2222", "3333", "444", "555"];

  //static var from = List();
  //static var to = List();
  //static var departTime = List();
  //static var arriveTime = List();

  static getFlights(int position) {
    return Flight(
        from[position],
        to[position],
        departTime[position],
        arriveTime[position],
        flightsNum[position]);
  }
}
class FlightListScreen extends StatefulWidget {
  final Location locInfo;
  FlightListScreen({Key key, @required this.locInfo}) : super(key: key);

  @override
  _FlightListState createState() => _FlightListState();
}

class _FlightListState extends State<FlightListScreen> {
  bool noFlights = false;

  @override
  void initState() {
    super.initState();
    String date = widget.locInfo.date.toString().split(" ")[0];
    String departure = widget.locInfo.departure;
    String arrival = widget.locInfo.arrival;

    print(date);
    print(departure);
    print(arrival);

    departure = cli.CityToCode(departure);
    arrival = cli.CityToCode(arrival);

    cli.fetchPost(date: date, origin : departure, dst: arrival).then((flight) {

      if (flight.length > 0){
        setState(() {

          FlightsMockData.from = List();
          FlightsMockData.to = List();
          FlightsMockData.departTime = List();
          FlightsMockData.arriveTime = List();
          FlightsMockData.flightsNum = List();
        });

        for (final i in flight) {
          print(i);
          setState(() {
            FlightsMockData.from.add(i.origin_code);
            FlightsMockData.to.add(i.dest_code);
            FlightsMockData.departTime.add(
                i.departureTime.split('T')[1].split('.')[0]);
            FlightsMockData.arriveTime.add(
                i.arrivalTime.split('T')[1].split('.')[0]);
            FlightsMockData.flightsNum.add(i.flightNumber);
          });
        }

      }else{
        setState(() {
          noFlights = true;
        });
      }
//      FlightsMockData.from = ["BBI", "CCU", "HYD", "BOM", "JAI"];
//      FlightsMockData.to = ["BLR", "JAI", "BBI", "CCU", "AMD"];
//      FlightsMockData.departTime = ["5:50 AM", "3:30 PM", "12:00PM", "4:20 AM", "1:00 PM"];
//      FlightsMockData.arriveTime = ["8:40 AM", "7:25 PM", "4:00 PM", "8:21 AM", "3:25 PM"];

    }, onError: (e) {
      print(e);
    });

  }

  @override
  Widget build(BuildContext context) {
    if (noFlights) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: new Text('Flight not found!'),
        ),
      );
    }
    Flight flight;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: FlightsMockData.count,
            itemBuilder: (context, index) {
              flight = FlightsMockData.getFlights(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlightCard(
                  flight: flight,
                  isClickable: true,
                ),
              );
            }
        ),
      ),
    );
  }
}

class FlightDetailScreen extends StatelessWidget{

  final String passengerName;
  final Flight flight;

  FlightDetailScreen({
    this.passengerName,
    this.flight
  });

  @override
  Widget build(BuildContext context) {



    getRichText(title, name){
      return RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: title, style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: name, style: TextStyle(color: Colors.grey)),
            ]
        ),
      );
    }


    final _passengerDetailsCard =  Card(
      elevation: 5.0,
      margin: EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getRichText("Passenger ", passengerName),
            SizedBox(height: 10.0,),
            getRichText("Date ", "24/05/21"),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText("Flight ", "INDIGO042B"),
                SizedBox(width: 10.0,),
                getRichText("Class ", "Business")
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getRichText("Seat ", "21B"),
                SizedBox(width: 10.0,),
                getRichText("Gate ", "17A")
              ],
            ),
          ],
        ),
      ),
    );


    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //color: Colors.black,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.30,
                color: Colors.amber,
              ),
              Positioned(
                top: MediaQuery.of(context).size.width*0.30,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.90,
                  child: Column(
                    children: <Widget>[
                      FlightCard(
                        flight: flight,
                        isClickable: false,
                      ),
                      SizedBox(height: 20.0,),
                      _passengerDetailsCard,
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

class FlightCard extends StatelessWidget{
  final Flight flight;
  final String fullName;
  final bool isClickable;

  FlightCard({this.flight, this.fullName, @required this.isClickable});

  _cityStyle(code, time){
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(code, style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 10.0,),
          Text(time, style: TextStyle(color: Colors.grey, fontSize: 14.0),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        isClickable?
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context)
                => FlightDetailScreen(
                  passengerName: fullName,
                  flight: flight,
                )
            )
        ):null;
      },

      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical:20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _cityStyle(flight.from, flight.departTime),
                new Text(flight.flightNum),
                Icon(Icons.airplanemode_active),
                _cityStyle(flight.to, flight.arriveTime),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
// ---------------------------------TESTING--------------------------------


class FlightInfo {
  final TextEditingController myController;
  final DateTime selectedDate;

  FlightInfo(this.myController, this.selectedDate);
}

class CheckInScreen extends StatefulWidget {
  CheckInScreen({Key key}) : super(key: key);

  @override
  _CheckInState createState() => _CheckInState();
}

class _CheckInState extends State<CheckInScreen> {
//  String flightValue = "";
  TextEditingController myController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check In'),
      ),
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: myController,
//                onChanged: (text) {
//                  flightValue = text;
//                },
                decoration: InputDecoration(
                  labelText: 'Input Flight Number',
                ),
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Icon(Icons.date_range),
                    new Text("${selectedDate.toLocal()}".split(' ')[0]),
                  ],
                ),
              ),
              ButtonTheme(
                //height: ,
                minWidth: MediaQuery.of(context).size.width - 50.0,
                child: RaisedButton(
                  child: Text('check flight'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlightInfoScreen(
                            flightInfo:
                                new FlightInfo(myController, selectedDate),
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkIn() {
    print(myController.text);
  }
}

class FlightInfoScreen extends StatefulWidget {
  final FlightInfo flightInfo;

  FlightInfoScreen({Key key, @required this.flightInfo}) : super(key: key);

  @override
  _flightState createState() => _flightState();
}

class _flightState extends State<FlightInfoScreen> {
  var currFlight;
  String origin_city = '';
  String origin_code = '';
  String dest_city = '';
  String dest_code = '';
  String departureTime = '';
  String origin_timezone = '';
  String arrivalTime = '';
  String dest_timezone = '';
  int duration_h = 0;
  int duration_m = 0;

  String toAirportInfo = '';

  @override
  void initState() {
    super.initState();
    String date = widget.flightInfo.selectedDate.toString().split(" ")[0];
    String num = widget.flightInfo.myController.text;
    // print(flightValue);
    print(date);
    print(num);

    cli.fetchPost(date: date, flightnum: num).then((flight) {
      if (flight != null) {
        print("Found flight number : ${flight.flightNumber}");
        setState(() {
          currFlight = flight;
          origin_city = flight.origin_city;
          origin_code = flight.origin_code;
          dest_city = flight.dest_city;
          dest_code = flight.dest_code;
          departureTime = flight.departureTime.split('T')[1].split('.')[0];
          origin_timezone = flight.origin_timezone.split('/')[1];
          arrivalTime = flight.arrivalTime.split('T')[1].split('.')[0];
          dest_timezone = flight.dest_timezone.split('/')[1];
          duration_h = flight.duration_h;
          duration_m = flight.duration_m;
        });
      } else {
        print("Did not find flight");
        currFlight = null;
      }
    }, onError: (e) {
      print(e);
    });

    cli.ToAirport(destinations: 'TUS').then((d) => toAirportInfo =
        "distance to the airport is ${d[0]}, estimate taking ${d[1]} plus traffic time ${d[2]}");

    print(toAirportInfo);
  }

  @override
  Widget build(BuildContext context) {
    Widget CitySection = Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(origin_city),
                new Text(origin_code),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Icon(Icons.flight),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(dest_city),
                new Text(dest_code),
              ],
            ),
          ),
        ],
      ),
    );
    Widget TimeSection = Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(departureTime),
                new Text(origin_timezone),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text('Duration'),
                new Text('${duration_h}hr${duration_m}min'),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text(arrivalTime),
                new Text(dest_timezone),
              ],
            ),
          ),
        ],
      ),
    );

    // we did not have enough information APIs for this section
    Widget InfoSection = Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text('terminal'),
                new Text('2'),
              ],
            ),
          ),
          Container(height: 50.0, child: VerticalDivider(color: Colors.black)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text('check-in'),
                new Text('A30-A36'),
              ],
            ),
          ),
          Container(height: 50.0, child: VerticalDivider(color: Colors.black)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text('gate'),
                new Text('8'),
              ],
            ),
          ),
          Container(height: 50.0, child: VerticalDivider(color: Colors.black)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Text('baggage'),
                new Text('F'),
              ],
            ),
          ),
        ],
      ),
    );

    Widget NavSection = Container(
      height: 120.0,
      child: Column(
        children: [
          new Text(toAirportInfo),
          SizedBox(height: 10.0,),
          RaisedButton(
              onPressed:(){
                Navigator.push(
                  context,new MaterialPageRoute(builder:(context)=> new ShopCart()),
                );
              },
              color:Colors.cyan,
              splashColor: Colors.red,
              padding:EdgeInsets.symmetric(vertical:15.0,horizontal:25.0),
              child:Text(
                  "Shop items",
                  style:TextStyle(
                    fontSize:20.0,
                    color:Colors.white,
                  )
              )
          ),
        ],
      ),

    );

    Widget AirportMapSection = Container(
      height: 340.0,
      width: 440.0,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: ExactAssetImage('images/T1.png'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
      ),
    );
    return new Container(
        child: _buildChild(CitySection, TimeSection, InfoSection, NavSection,
            AirportMapSection));
  }

  Widget _buildChild(Widget CitySection, Widget TimeSection, Widget InfoSection,
      Widget NavSection, Widget AirportMapSection) {
    if (currFlight == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              'AA${widget.flightInfo.myController.text}'), // we can only check airlines for AA
        ),
        body: Center(
          child: new Text('Flight not found!'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              'AA${widget.flightInfo.myController.text}'), // we can only check airlines for AA
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            CitySection,
            SizedBox(height: 20.0),
            TimeSection,
            SizedBox(height: 20.0),
            InfoSection,
            SizedBox(height: 20.0),
            NavSection,
            SizedBox(height: 20.0),
            AirportMapSection,
          ],
        ),
      );
    }
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState()=> new RandomWordsState();
}
class RandomWordsState extends State<RandomWords>{
  // final _suggestions=<WordPair>[];
  final _saved = new List<String>();
  final _biggerFont = const TextStyle(fontSize:18.0);
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title:new Text('Menu'),
        actions: <Widget>[
          new IconButton(icon:new Icon(Icons.list),onPressed: _pushSaved,)
        ],
      ),
      body:_buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    List<String> options = ['water','coke','lemonade','book','wine','beer',
      ''];

    return new ListView.builder(
        padding:const EdgeInsets.all(16.0),
        itemBuilder: (context,i){
          if (i.isOdd) return new Divider();
          final index = i~/2;
          if (index>= 5){
            return null;
          }
          return _buildRow(options[index]);
        }
    );
  }
  Widget _buildRow(String Pair){
    final alreadySaved = _saved.contains(Pair);
    return new ListTile(
        title:new Text(
          Pair,

          style:_biggerFont,
        ),
        trailing : new Icon(
          alreadySaved? Icons.favorite:Icons.favorite_border,
          color:alreadySaved?Colors.red:null,
        ),
        onTap:(){
          setState(() {
            if (alreadySaved){
              _saved.remove(Pair);
            }else{
              _saved.add(Pair);
            }
          });
        }
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
                (Pair) {
              return new ListTile(
                title: new Text(
                  Pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
          return new Scaffold(
            appBar: new AppBar(
              title:new Text('Check Out'),
            ),
            body:new ListView(children:divided),

          );
        },
      ),
    );
  }
}
class ShopCart extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title:'Startup Name Generator',
      home: new RandomWords(),
      debugShowCheckedModeBanner: false,
    );
  }
}
