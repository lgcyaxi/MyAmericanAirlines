import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;


class Flight {
  final String model;
  final int first;
  final int main;
  final int total;
  final int speed;
  final String arrivalTime;
  final String departureTime;
  final String dest_city;
  final String dest_code;
  final double dest_lat;
  final double dest_log;
  final String dest_timezone;
  final int distance;
  final int duration_h;
  final int duration_m;
  final String locale;
  final String flightNumber;
  final String origin_city;
  final String origin_code;
  final double origin_lat;
  final double origin_log;
  final String origin_timezone;

  Flight({this.model,this.first,this.main,this.total,this.speed,this.arrivalTime,this.departureTime,
  	this.dest_city,this.dest_code,this.dest_lat,this.dest_log,this.dest_timezone,this.distance,this.duration_h,this.duration_m,
  	this.locale,this.flightNumber,this.origin_city,this.origin_code,this.origin_lat,this.origin_log,this.origin_timezone});

  //与上同步，处理JSON格式完成转换数据变量
  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      model: json['aircraft']['model'],
	  first: json['aircraft']['passengerCapacity']['first'],
	  main: json['aircraft']['passengerCapacity']['main'],
	  total: json['aircraft']['passengerCapacity']['total'],
	  speed: json['aircraft']['speed'],
	  arrivalTime: json['arrivalTime'],
	  departureTime: json['departureTime'],
	  dest_city: json['destination']['city'],
	  dest_code: json['destination']['code'],
	  dest_lat: json['destination']['location']['latitude'],
	  dest_log: json['destination']['location']['longitude'],
	  dest_timezone: json['destination']['timezone'],
	  distance: json['distance'],
	  duration_h: json['duration']['hours'],
  	  duration_m: json['duration']['minutes'],
	  locale: json['duration']['locale'],
	  flightNumber: json['flightNumber'],
	  origin_city: json['origin']['city'],
	  origin_code: json['origin']['code'],
	  origin_lat: json['origin']['location']['latitude'],
	  origin_log: json['origin']['location']['longitude'],
	  origin_timezone: json['origin']['timezone'],
    );
  }
}



//从服务器获取数据的主方法
Future fetchPost({String date = '2020-01-01',String origin = '',String dst = '',String flightnum = ''}) async {
  //var date = '2020-01-01';
  var url = 'https://aaflight.herokuapp.com/flights?date=$date';

  if(origin != ''){
  	url = '$url&origin=$origin';
  	//print(url);
  }

  if(dst !=''){
  	url = '$url&destination=$dst';
  	//print(url);
  }
  

  
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    var jsonResponse = json.decode(response.body);

   	// list of flight, iterate list and generate object of flight
   	var Flights = new List();


   	
   	for (var i = 0;i < jsonResponse.length;i++){
   		var FF = jsonResponse[i];
   		var F = Flight.fromJson(FF);
   		//print("ID $i Flight  ${F}");
		Flights.add(F);

   	}

   	if (flightnum != ''){
   		for (final i in Flights){
   			if(i.flightNumber == flightnum){
   				return i;
   			}
   		}
   		return null;
    }

   	//return list of flgith
   	//print(Flights);
    //print('$FlightNumber');
    return Flights;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

double roundDouble(double value, int places){ 
   double mod = pow(10.0, places); 
   return ((value * mod).round().toDouble() / mod); 
}

//功能函数测试
int calculate() {
  return 6 * 7 ~/ 2;
}




//计算到机场距离 
ToAirport({String dept = 'University of Arzina',String dest = 'Tucson International Airport'}) async{
	// Optinal positional parameters for function
	//var origins = 'N Umbra Ct';
	//var destinations = 'Tucson International Airport';

	//Google API 获取地点到机场时间
	var api_key = 'AIzaSyAb3ZcVT0MBncm1ZekebYY1NWUtFyHoHlo';
	var GoogleAPI = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$dept&destinations=$dest&departure_time=now&key=$api_key';
	
	final response =
      await http.get(GoogleAPI);
    if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    var jsonResponse = json.decode(response.body);

    var distance = jsonResponse['rows'][0]['elements'][0]['distance']['text'];
    var duration = jsonResponse['rows'][0]['elements'][0]['duration']['text'];
    var duration_in_traffic = jsonResponse['rows'][0]['elements'][0]['duration_in_traffic']['text'];
    var result = [distance,duration,duration_in_traffic];
    //print('$distance');
    return result;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to get time');
  }
}

//计算机场内部消耗时间
InternalCost({int n_person = 30,int t_cost = 2,double g_dist = 1.5}){
	//根据checkin的点人数随机一个通过时间
	//给定一个固定时间数
	//计算安检口到gate时间 -通过举例运算
	//总时间
	var random = new Random();
	var sum = n_person * random.nextDouble( ) + t_cost + (g_dist/9*60);
	return roundDouble(sum,2);
}



String CityToCode(String city){
  var MapCode = {
    'Birmingham International Airport':'BHM',
    'Dothan Regional Airport':'DHN',
    'Huntsville International Airport':'HSV',
    'Mobile':'MOB',
    'Montgomery':'MGM',
    'Anchorage International Airport':'ANC',
    'Fairbanks International Airport':'FAI',
    'Juneau International Airport':'JNU',
    'Flagstaff':'FLG',
    'Phoenix':'PHX',
    'Tucson':'TUS',
    'Yuma International Airport':'YUM',
    'Fayetteville':'FYV',
    'Little Rock National Airport':'LIT',
    'Northwest Arkansas Regional Airport':'XNA',
    'California':'CA',
    'Burbank':'BUR',
    'Fresno':'FAT',
    'Long Beach':'LGB',
    'Los Angeles International Airport':'LAX',
    'Oakland':'OAK',
    'Ontario':'ONT',
    'Palm Springs':'PSP',
    'Sacramento':'SMF',
    'San Diego':'SAN',
    'San Francisco International Airport':'SFO',
    'San Jose':'SJC',
    'Santa Ana':'SNA',
    'Colorado':'CO',
    'Aspen':'ASE',
    'Colorado Springs':'COS',
    'Denver International Airport':'DEN',
    'Grand Junction':'GJT',
    'Pueblo':'PUB',
    'Connecticut':'CT',
    'Hartford':'BDL',
    'Tweed New Haven':'HVN',
    'District of Columbia':'DC',
    'Washington, Dulles International Airport':'IAD',
    'Washington National Airport':'DCA',
    'Florida':'FL',
    'Daytona Beach':'DAB',
    'Fort Lauderdale-Hollywood International Airport':'FLL',
    'Fort Meyers':'RSW',
    'Jacksonville':'JAX',
    'Key West International Airport':'EYW',
    'Miami International Airport':'MIA',
    'Orlando':'MCO',
    'Pensacola':'PNS',
    'St. Petersburg':'PIE',
    'Sarasota':'SRQ',
    'Tampa':'TPA',
    'West Palm Beach':'PBI',
    'Panama City-Bay County International Airport':'PFN',
    'Georgia':'GA',
    'Atlanta Hartsfield International Airport':'ATL',
    'Augusta':'AGS',
    'Savannah':'SAV',
    'Hawaii':'HI',
    'Hilo':'ITO',
    'Honolulu International Airport':'HNL',
    'Kahului':'OGG',
    'Kailua':'KOA',
    'Lihue':'LIH',
    'Idaho':'ID',
    'Boise':'BOI',
    'Illinois':'IL',
    'Chicago Midway Airport':'MDW',
    'Chicago O\'Hare International Airport Airport':'ORD',
    'Moline':'MLI',
    'Peoria':'PIA',
    'Indiana':'IN',
    'Evansville':'EVV',
    'Fort Wayne':'FWA',
    'Indianapolis International Airport':'IND',
    'South Bend':'SBN',
    'Iowa':'IA',
    'Cedar Rapids':'CID',
    'Des Moines':'DSM',
    'Kansas':'KS',
    'Wichita':'ICT',
    'Kentucky':'KY',
    'Lexington':'LEX',
    'Louisville':'SDF',
    'Louisiana':'LA',
    'Baton Rouge':'BTR',
    'New Orleans International Airport':'MSY',
    'Shreveport':'SHV',
    'Maine':'ME',
    'Augusta':'AUG',
    'Bangor':'BGR',
    'Portland':'PWM',
    'Maryland':'MD',
    'Baltimore':'BWI',
    'Massachusetts':'MA',
    'Boston, Logan International Airport':'BOS',
    'Hyannis':'HYA',
    'Nantucket':'ACK',
    'Worcester':'ORH',
    'Michigan':'MI',
    'Battlecreek':'BTL',
    'Detroit Metropolitan Airport':'DTW',
    'Detroit':'DET',
    'Flint':'FNT',
    'Grand Rapids':'GRR',
    'Kalamazoo-Battle Creek International Airport':'AZO',
    'Lansing':'LAN',
    'Saginaw':'MBS',
    'Minnesota':'MN',
    'Duluth':'DLH',
    'Minneapolis/St.Paul International Airport':'MSP',
    'Rochester':'RST',
    'Mississippi':'MS',
    'Gulfport':'GPT',
    'Jackson':'JAN',
    'Missouri':'MO',
    'Kansas City':'MCI',
    'St Louis, Lambert International Airport':'STL',
    'Springfield':'SGF',
    'Montana':'MT',
    'Billings':'BIL',
    'Nebraska':'NE',
    'Lincoln':'LNK',
    'Omaha':'OMA',
    'Nevada':'NV',
    'Las Vegas, Las Vegas McCarran International Airport':'LAS',
    'Reno-Tahoe International Airport':'RNO',
    'New Hampshire':'NH',
    'Manchester':'MHT',
    'New Jersey':'NJ',
    'Atlantic City International Airport':'ACY',
    'Newark International Airport':'EWR',
    'Trenton':'TTN',
    'New Mexico':'NM',
    'Albuquerque International Airport':'ABQ',
    'Alamogordo':'ALM',
    'New York':'NY',
    'Albany International Airport':'ALB',
    'Buffalo':'BUF',
    'Islip':'ISP',
    'New York, John F Kennedy International Airport':'JFK',
    'New York, La Guardia Airport':'LGA',
    'Newburgh':'SWF',
    'Rochester':'ROC',
    'Syracuse':'SYR',
    'Westchester':'HPN',
    'North Carolina':'NC',
    'Asheville':'AVL',
    'Charlotte/Douglas International Airport':'CLT',
    'Fayetteville':'FAY',
    'Greensboro':'GSO',
    'Raleigh':'RDU',
    'Winston-Salem':'INT',
    'North Dakota':'ND',
    'Bismark':'BIS',
    'Fargo':'FAR',
    'Ohio':'OH',
    'Akron':'CAK',
    'Cincinnati':'CVG',
    'Cleveland':'CLE',
    'Columbus':'CMH',
    'Dayton':'DAY',
    'Toledo':'TOL',
    'Oklahoma':'OK',
    'Oklahoma City':'OKC',
    'Tulsa':'TUL',
    'Oregon':'OR',
    'Eugene':'EUG',
    'Portland International Airport':'PDX',
    'Portland, Hillsboro Airport':'HIO',
    'Salem':'SLE',
    'Pennsylvania':'PA',
    'Allentown':'ABE',
    'Erie':'ERI',
    'Harrisburg':'MDT',
    'Philadelphia':'PHL',
    'Pittsburgh':'PIT',
    'Scranton':'AVP',
    'Rhode Island':'RI',
    'Providence - T.F. Green Airport':'PVD',
    'South Carolina':'SC',
    'Charleston':'CHS',
    'Columbia':'CAE',
    'Greenville':'GSP',
    'Myrtle Beach':'MYR',
    'South Dakota':'SD',
    'Pierre':'PIR',
    'Rapid City':'RAP',
    'Sioux Falls':'FSD',
    'Tennessee':'TN',
    'Bristol':'TRI',
    'Chattanooga':'CHA',
    'Knoxville':'TYS',
    'Memphis':'MEM',
    'Nashville':'BNA',
    'Texas':'TX',
    'Amarillo':'AMA',
    'Austin Bergstrom International Airport':'AUS',
    'Corpus Christi':'CRP',
    'Dallas Love Field Airport':'DAL',
    'Dallas/Fort Worth International Airport':'DFW',
    'El Paso':'ELP',
    'Houston, William B Hobby Airport':'HOU',
    'Houston, George Bush Intercontinental Airport':'IAH',
    'Lubbock':'LBB',
    'Midland':'MAF',
    'San Antonio International Airport':'SAT',
    'Utah':'UT',
    'Salt Lake City':'SLC',
    'Vermont':'VT',
    'Burlington':'BTV',
    'Montpelier':'MPV',
    'Rutland':'RUT',
    'Virginia':'VA',
    'Dulles':'IAD',
    'Newport News':'PHF',
    'Norfolk':'ORF',
    'Richmond':'RIC',
    'Roanoke':'ROA',
    'Washington':'WA',
    'Pasco, Pasco/Tri-Cities Airport':'PSC',
    'Seattle, Tacoma International Airport':'SEA',
    'Spokane International Airport':'GEG',
    'West Virginia':'WV',
    'Charleston':'CRW',
    'Clarksburg':'CKB',
    'Huntington Tri-State Airport':'HTS',
    'Wisconsin':'WI',
    'Green Bay':'GRB',
    'Madison':'MSN',
    'Milwaukee':'MKE',
    'Wyoming':'WY',
    'Casper':'CPR',
    'Cheyenne':'CYS',
    'Jackson Hole':'JAC',
    'Rock Springs':'RKS'
  };

  //print(MapCode['Tucson']);
  return MapCode[city];
}

