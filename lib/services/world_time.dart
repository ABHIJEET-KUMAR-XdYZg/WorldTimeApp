import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String url;
  String location;
  String flag;
  bool isDaytime=true;
  late String time;

  WorldTime({required this.url,required this.location,required this.flag});

  Future<void> getTime() async{

    try{
      Uri u=Uri.parse('http://worldtimeapi.org/api/timezone/$url');

      // make the request
      Response response=await get(u);
      Map data=jsonDecode(response.body);

      //get properties from json
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(1,3);

      //create Datetime object
      DateTime now=DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));

      isDaytime=now.hour>6 && now.hour<20 ? true :false;

      //set time property
      time=DateFormat.jm().format(now);
    }
    catch(e){
      time='could not get the time';
    }
  }
}