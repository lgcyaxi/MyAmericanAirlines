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
ToAirport({String origins = 'University of Arzina',String destinations = 'Tucson International Airport'}) async{
	// Optinal positional parameters for function
	//var origins = 'N Umbra Ct';
	//var destinations = 'Tucson International Airport';

	//Google API 获取地点到机场时间
	var api_key = 'AIzaSyAb3ZcVT0MBncm1ZekebYY1NWUtFyHoHlo';
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



//机场捏指引
void Navigation(){
	//定位到机场大门
	//根据定位找到对应登机楼
	//根据航班提示checkin 和 行李 路牌
	//根据checkin的点 给定机场内部的路线规划
	//生成流程图
}


//获取所有到站的航班
void GetAllDest(){
	//给服务器获取对应航班
	//进行筛选显示
}