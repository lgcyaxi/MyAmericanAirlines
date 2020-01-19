import 'package:flutter/material.dart';
import 'cli.dart' as cli;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'American Airline',

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
        title: Text('American Airline'),
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
  final TextEditingController controller = new TextEditingController();
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
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('American Airline'),
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
                      onSubmitted: (String str) {
                        setState(() {
                          departure = str;
                        });
                      },
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
                      onSubmitted: (String str) {
                        setState(() {
                          arrival = str;
                        });
                      },
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
                  loc: new Location(departure, arrival, selectedDate)),
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

class BookingScreen extends StatefulWidget {
  final Location loc;

  BookingScreen({Key key, @required this.loc}) : super(key: key);

  @override
  BookingPage2 createState() => BookingPage2();
}

class BookingPage2 extends State<BookingScreen> {
  int _adultCount = 0;
  int _childCount = 0;
  int seat = 1;
  int type = 2;

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
                Expanded(
                  child: Text('Adult    '),
                ),
                Expanded(
                    child: IconButton(
                        icon: new Icon(Icons.remove),
                        onPressed: () => setState(() => _adultCount--))),
                Expanded(
                  child: Text(_adultCount.toString()),
                ),
                Expanded(
                    child: IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: () => setState(() => _adultCount++))),
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Text('Children    '),
                ),
                Expanded(
                    child: IconButton(
                        icon: new Icon(Icons.remove),
                        onPressed: () => setState(() => _childCount--))),
                Expanded(
                  child: Text(_childCount.toString()),
                ),
                Expanded(
                    child: IconButton(
                        icon: new Icon(Icons.add),
                        onPressed: () => setState(() => _childCount++))),
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
          /**
              Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new ConfirmScreen();
              }));
           **/
        },
        label: Text('CONFIRM'),
        icon: Icon(Icons.thumb_up),
        backgroundColor: Colors.orange,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

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

  @override
  void initState() {
    super.initState();
    String date = widget.flightInfo.selectedDate.toString().split(" ")[0];
    String num = widget.flightInfo.myController.text;
    // print(flightValue);
    print(date);
    print(num);

    cli.fetchPost(flightnum: num).then((flight) {
      if (flight != null) {
        print("Found flight number : ${flight.flightNumber}");
        setState(() {
          currFlight = flight;
          origin_city = flight.origin_city;
          origin_code = flight.origin_code;
          dest_city = flight.dest_city;
          dest_code = flight.dest_code;
          departureTime = flight.departureTime.split('T')[1].split('.')[0];
          origin_timezone = flight.origin_timezone;
          arrivalTime = flight.arrivalTime.split('T')[1].split('.')[0];
          dest_timezone = flight.dest_timezone;
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

    print(currFlight);
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
                new Text(
                    '${duration_h}hr${duration_m}min'),
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

//  Widget NavSection = Container(
//
//  );

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
        child: _buildChild(
            CitySection, TimeSection, InfoSection, AirportMapSection));
  }

  Widget _buildChild(Widget CitySection, Widget TimeSection, Widget InfoSection,
      Widget AirportMapSection) {
    print(currFlight);
    print('top');
    if (currFlight == null) {
      print('here1');
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
      print('here2');
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
            AirportMapSection,
          ],
        ),
      );
    }
  }
}
