import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class Flight {
  //需要添加额外的数据 来完成整个CLASS 获取的变量
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
  var url = 'url=$date';

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
ToAirport({String origins = 'University of Arzina',String destinations = 'Tucson International Airport'}) async{
	// Optinal positional parameters for function
	//var origins = 'N Umbra Ct';
	//var destinations = 'Tucson International Airport';

	//Google API 获取地点到机场时间
	var api_key = 'YourAPIKey';
	var GoogleAPI = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origins&destinations=$destinations&departure_time=now&key=$api_key';
	
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
    'Alabama':'AL',
    'AL':'AL',
    'Birmingham International Airport':'BHM',
    'BHM':'BHM',
    'Dothan Regional Airport':'DHN',
    'DHN':'DHN',
    'Huntsville International Airport':'HSV',
    'HSV':'HSV',
    'Mobile':'MOB',
    'MOB':'MOB',
    'Montgomery':'MGM',
    'MGM':'MGM',
    'Alaska':'AK',
    'AK':'AK',
    'Anchorage International Airport':'ANC',
    'ANC':'ANC',
    'Fairbanks International Airport':'FAI',
    'FAI':'FAI',
    'Juneau International Airport':'JNU',
    'JNU':'JNU',
    'Arizona':'AZ',
    'AZ':'AZ',
    'Flagstaff':'FLG',
    'FLG':'FLG',
    'Phoenix, Phoenix Sky Harbor International Airport':'PHX',
    'PHX':'PHX',
    'Tucson International Airport':'TUS',
    'TUS':'TUS',
    'Yuma International Airport':'YUM',
    'YUM':'YUM',
    'Arkansas':'AR',
    'AR':'AR',
    'Fayetteville':'FYV',
    'FYV':'FYV',
    'Little Rock National Airport':'LIT',
    'LIT':'LIT',
    'Northwest Arkansas Regional Airport':'XNA',
    'XNA':'XNA',
    'California':'CA',
    'CA':'CA',
    'Burbank':'BUR',
    'BUR':'BUR',
    'Fresno':'FAT',
    'FAT':'FAT',
    'Long Beach':'LGB',
    'LGB':'LGB',
    'Los Angeles International Airport':'LAX',
    'LAX':'LAX',
    'Oakland':'OAK',
    'OAK':'OAK',
    'Ontario':'ONT',
    'ONT':'ONT',
    'Palm Springs':'PSP',
    'PSP':'PSP',
    'Sacramento':'SMF',
    'SMF':'SMF',
    'San Diego':'SAN',
    'SAN':'SAN',
    'San Francisco International Airport':'SFO',
    'SFO':'SFO',
    'San Jose':'SJC',
    'SJC':'SJC',
    'Santa Ana':'SNA',
    'SNA':'SNA',
    'Colorado':'CO',
    'CO':'CO',
    'Aspen':'ASE',
    'ASE':'ASE',
    'Colorado Springs':'COS',
    'COS':'COS',
    'Denver International Airport':'DEN',
    'DEN':'DEN',
    'Grand Junction':'GJT',
    'GJT':'GJT',
    'Pueblo':'PUB',
    'PUB':'PUB',
    'Connecticut':'CT',
    'CT':'CT',
    'Hartford':'BDL',
    'BDL':'BDL',
    'Tweed New Haven':'HVN',
    'HVN':'HVN',
    'District of Columbia':'DC',
    'DC':'DC',
    'Washington, Dulles International Airport':'IAD',
    'IAD':'IAD',
    'Washington National Airport':'DCA',
    'DCA':'DCA',
    'Florida':'FL',
    'FL':'FL',
    'Daytona Beach':'DAB',
    'DAB':'DAB',
    'Fort Lauderdale-Hollywood International Airport':'FLL',
    'FLL':'FLL',
    'Fort Meyers':'RSW',
    'RSW':'RSW',
    'Jacksonville':'JAX',
    'JAX':'JAX',
    'Key West International Airport':'EYW',
    'EYW':'EYW',
    'Miami International Airport':'MIA',
    'MIA':'MIA',
    'Orlando':'MCO',
    'MCO':'MCO',
    'Pensacola':'PNS',
    'PNS':'PNS',
    'St. Petersburg':'PIE',
    'PIE':'PIE',
    'Sarasota':'SRQ',
    'SRQ':'SRQ',
    'Tampa':'TPA',
    'TPA':'TPA',
    'West Palm Beach':'PBI',
    'PBI':'PBI',
    'Panama City-Bay County International Airport':'PFN',
    'PFN':'PFN',
    'Georgia':'GA',
    'GA':'GA',
    'Atlanta Hartsfield International Airport':'ATL',
    'ATL':'ATL',
    'Augusta':'AGS',
    'AGS':'AGS',
    'Savannah':'SAV',
    'SAV':'SAV',
    'Hawaii':'HI',
    'HI':'HI',
    'Hilo':'ITO',
    'ITO':'ITO',
    'Honolulu International Airport':'HNL',
    'HNL':'HNL',
    'Kahului':'OGG',
    'OGG':'OGG',
    'Kailua':'KOA',
    'KOA':'KOA',
    'Lihue':'LIH',
    'LIH':'LIH',
    'Idaho':'ID',
    'ID':'ID',
    'Boise':'BOI',
    'BOI':'BOI',
    'Illinois':'IL',
    'IL':'IL',
    'Chicago Midway Airport':'MDW',
    'MDW':'MDW',
    'Chicago, O\'Hare International Airport Airport':'ORD',
    'ORD':'ORD',
    'Moline':'MLI',
    'MLI':'MLI',
    'Peoria':'PIA',
    'PIA':'PIA',
    'Indiana':'IN',
    'IN':'IN',
    'Evansville':'EVV',
    'EVV':'EVV',
    'Fort Wayne':'FWA',
    'FWA':'FWA',
    'Indianapolis International Airport':'IND',
    'IND':'IND',
    'South Bend':'SBN',
    'SBN':'SBN',
    'Iowa':'IA',
    'IA':'IA',
    'Cedar Rapids':'CID',
    'CID':'CID',
    'Des Moines':'DSM',
    'DSM':'DSM',
    'Kansas':'KS',
    'KS':'KS',
    'Wichita':'ICT',
    'ICT':'ICT',
    'Kentucky':'KY',
    'KY':'KY',
    'Lexington':'LEX',
    'LEX':'LEX',
    'Louisville':'SDF',
    'SDF':'SDF',
    'Louisiana':'LA',
    'LA':'LA',
    'Baton Rouge':'BTR',
    'BTR':'BTR',
    'New Orleans International Airport':'MSY',
    'MSY':'MSY',
    'Shreveport':'SHV',
    'SHV':'SHV',
    'Maine':'ME',
    'ME':'ME',
    'Augusta':'AUG',
    'AUG':'AUG',
    'Bangor':'BGR',
    'BGR':'BGR',
    'Portland':'PWM',
    'PWM':'PWM',
    'Maryland':'MD',
    'MD':'MD',
    'Baltimore':'BWI',
    'BWI':'BWI',
    'Massachusetts':'MA',
    'MA':'MA',
    'Boston, Logan International Airport':'BOS',
    'BOS':'BOS',
    'Hyannis':'HYA',
    'HYA':'HYA',
    'Nantucket':'ACK',
    'ACK':'ACK',
    'Worcester':'ORH',
    'ORH':'ORH',
    'Michigan':'MI',
    'MI':'MI',
    'Battlecreek':'BTL',
    'BTL':'BTL',
    'Detroit Metropolitan Airport':'DTW',
    'DTW':'DTW',
    'Detroit':'DET',
    'DET':'DET',
    'Flint':'FNT',
    'FNT':'FNT',
    'Grand Rapids':'GRR',
    'GRR':'GRR',
    'Kalamazoo-Battle Creek International Airport':'AZO',
    'AZO':'AZO',
    'Lansing':'LAN',
    'LAN':'LAN',
    'Saginaw':'MBS',
    'MBS':'MBS',
    'Minnesota':'MN',
    'MN':'MN',
    'Duluth':'DLH',
    'DLH':'DLH',
    'Minneapolis/St.Paul International Airport':'MSP',
    'MSP':'MSP',
    'Rochester':'RST',
    'RST':'RST',
    'Mississippi':'MS',
    'MS':'MS',
    'Gulfport':'GPT',
    'GPT':'GPT',
    'Jackson':'JAN',
    'JAN':'JAN',
    'Missouri':'MO',
    'MO':'MO',
    'Kansas City':'MCI',
    'MCI':'MCI',
    'St Louis, Lambert International Airport':'STL',
    'STL':'STL',
    'Springfield':'SGF',
    'SGF':'SGF',
    'Montana':'MT',
    'MT':'MT',
    'Billings':'BIL',
    'BIL':'BIL',
    'Nebraska':'NE',
    'NE':'NE',
    'Lincoln':'LNK',
    'LNK':'LNK',
    'Omaha':'OMA',
    'OMA':'OMA',
    'Nevada':'NV',
    'NV':'NV',
    'Las Vegas, Las Vegas McCarran International Airport':'LAS',
    'LAS':'LAS',
    'Reno-Tahoe International Airport':'RNO',
    'RNO':'RNO',
    'New Hampshire':'NH',
    'NH':'NH',
    'Manchester':'MHT',
    'MHT':'MHT',
    'New Jersey':'NJ',
    'NJ':'NJ',
    'Atlantic City International Airport':'ACY',
    'ACY':'ACY',
    'Newark International Airport':'EWR',
    'EWR':'EWR',
    'Trenton':'TTN',
    'TTN':'TTN',
    'New Mexico':'NM',
    'NM':'NM',
    'Albuquerque International Airport':'ABQ',
    'ABQ':'ABQ',
    'Alamogordo':'ALM',
    'ALM':'ALM',
    'New York':'NY',
    'NY':'NY',
    'Albany International Airport':'ALB',
    'ALB':'ALB',
    'Buffalo':'BUF',
    'BUF':'BUF',
    'Islip':'ISP',
    'ISP':'ISP',
    'New York, John F Kennedy International Airport':'JFK',
    'JFK':'JFK',
    'New York, La Guardia Airport':'LGA',
    'LGA':'LGA',
    'Newburgh':'SWF',
    'SWF':'SWF',
    'Rochester':'ROC',
    'ROC':'ROC',
    'Syracuse':'SYR',
    'SYR':'SYR',
    'Westchester':'HPN',
    'HPN':'HPN',
    'North Carolina':'NC',
    'NC':'NC',
    'Asheville':'AVL',
    'AVL':'AVL',
    'Charlotte/Douglas International Airport':'CLT',
    'CLT':'CLT',
    'Fayetteville':'FAY',
    'FAY':'FAY',
    'Greensboro':'GSO',
    'GSO':'GSO',
    'Raleigh':'RDU',
    'RDU':'RDU',
    'Winston-Salem':'INT',
    'INT':'INT',
    'North Dakota':'ND',
    'ND':'ND',
    'Bismark':'BIS',
    'BIS':'BIS',
    'Fargo':'FAR',
    'FAR':'FAR',
    'Ohio':'OH',
    'OH':'OH',
    'Akron':'CAK',
    'CAK':'CAK',
    'Cincinnati':'CVG',
    'CVG':'CVG',
    'Cleveland':'CLE',
    'CLE':'CLE',
    'Columbus':'CMH',
    'CMH':'CMH',
    'Dayton':'DAY',
    'DAY':'DAY',
    'Toledo':'TOL',
    'TOL':'TOL',
    'Oklahoma':'OK',
    'OK':'OK',
    'Oklahoma City':'OKC',
    'OKC':'OKC',
    'Tulsa':'TUL',
    'TUL':'TUL',
    'Oregon':'OR',
    'OR':'OR',
    'Eugene':'EUG',
    'EUG':'EUG',
    'Portland International Airport':'PDX',
    'PDX':'PDX',
    'Portland, Hillsboro Airport':'HIO',
    'HIO':'HIO',
    'Salem':'SLE',
    'SLE':'SLE',
    'Pennsylvania':'PA',
    'PA':'PA',
    'Allentown':'ABE',
    'ABE':'ABE',
    'Erie':'ERI',
    'ERI':'ERI',
    'Harrisburg':'MDT',
    'MDT':'MDT',
    'Philadelphia':'PHL',
    'PHL':'PHL',
    'Pittsburgh':'PIT',
    'PIT':'PIT',
    'Scranton':'AVP',
    'AVP':'AVP',
    'Rhode Island':'RI',
    'RI':'RI',
    'Providence - T.F. Green Airport':'PVD',
    'PVD':'PVD',
    'South Carolina':'SC',
    'SC':'SC',
    'Charleston':'CHS',
    'CHS':'CHS',
    'Columbia':'CAE',
    'CAE':'CAE',
    'Greenville':'GSP',
    'GSP':'GSP',
    'Myrtle Beach':'MYR',
    'MYR':'MYR',
    'South Dakota':'SD',
    'SD':'SD',
    'Pierre':'PIR',
    'PIR':'PIR',
    'Rapid City':'RAP',
    'RAP':'RAP',
    'Sioux Falls':'FSD',
    'FSD':'FSD',
    'Tennessee':'TN',
    'TN':'TN',
    'Bristol':'TRI',
    'TRI':'TRI',
    'Chattanooga':'CHA',
    'CHA':'CHA',
    'Knoxville':'TYS',
    'TYS':'TYS',
    'Memphis':'MEM',
    'MEM':'MEM',
    'Nashville':'BNA',
    'BNA':'BNA',
    'Texas':'TX',
    'TX':'TX',
    'Amarillo':'AMA',
    'AMA':'AMA',
    'Austin Bergstrom International Airport':'AUS',
    'AUS':'AUS',
    'Corpus Christi':'CRP',
    'CRP':'CRP',
    'Dallas Love Field Airport':'DAL',
    'DAL':'DAL',
    'Dallas/Fort Worth International Airport':'DFW',
    'DFW':'DFW',
    'El Paso':'ELP',
    'ELP':'ELP',
    'Houston, William B Hobby Airport':'HOU',
    'HOU':'HOU',
    'Houston, George Bush Intercontinental Airport':'IAH',
    'IAH':'IAH',
    'Lubbock':'LBB',
    'LBB':'LBB',
    'Midland':'MAF',
    'MAF':'MAF',
    'San Antonio International Airport':'SAT',
    'SAT':'SAT',
    'Utah':'UT',
    'UT':'UT',
    'Salt Lake City':'SLC',
    'SLC':'SLC',
    'Vermont':'VT',
    'VT':'VT',
    'Burlington':'BTV',
    'BTV':'BTV',
    'Montpelier':'MPV',
    'MPV':'MPV',
    'Rutland':'RUT',
    'RUT':'RUT',
    'Virginia':'VA',
    'VA':'VA',
    'Dulles':'IAD',
    'IAD':'IAD',
    'Newport News':'PHF',
    'PHF':'PHF',
    'Norfolk':'ORF',
    'ORF':'ORF',
    'Richmond':'RIC',
    'RIC':'RIC',
    'Roanoke':'ROA',
    'ROA':'ROA',
    'Washington':'WA',
    'WA':'WA',
    'Pasco, Pasco/Tri-Cities Airport':'PSC',
    'PSC':'PSC',
    'Seattle, Tacoma International Airport':'SEA',
    'SEA':'SEA',
    'Spokane International Airport':'GEG',
    'GEG':'GEG',
    'West Virginia':'WV',
    'WV':'WV',
    'Charleston':'CRW',
    'CRW':'CRW',
    'Clarksburg':'CKB',
    'CKB':'CKB',
    'Huntington Tri-State Airport':'HTS',
    'HTS':'HTS',
    'Wisconsin':'WI',
    'WI':'WI',
    'Green Bay':'GRB',
    'GRB':'GRB',
    'Madison':'MSN',
    'MSN':'MSN',
    'Milwaukee':'MKE',
    'MKE':'MKE',
    'Wyoming':'WY',
    'WY':'WY',
    'Casper':'CPR',
    'CPR':'CPR',
    'Cheyenne':'CYS',
    'CYS':'CYS',
    'Jackson Hole':'JAC',
    'JAC':'JAC',
    'Rock Springs':'RKS',
    'RKS':'RKS',
    'Tucson':'TUS',
    'Phoenix': 'PHX'
  };

  //print(MapCode['Tucson']);
  return MapCode[city];
}
