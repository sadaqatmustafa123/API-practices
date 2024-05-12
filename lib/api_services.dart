import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:multipledataapicalls/multi_data_model.dart';


class ApiServices{
  Future <MultiData?> getMultiDataWithModel() async {

    try{
      var response = await http.get(Uri.parse("https://reqres.in/api/unknown"));
      if (response.statusCode == 200){
        MultiData model = MultiData.fromJson(json.decode(response.body));
        return model;
      }
    }catch(e){
      print(e.toString());
    }
    return null;
  }
}