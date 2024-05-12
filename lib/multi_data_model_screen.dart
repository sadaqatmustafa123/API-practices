import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multipledataapicalls/api_services.dart';
import 'package:multipledataapicalls/multi_data_model.dart';

class MultiDataModelScreen extends StatefulWidget {
  const MultiDataModelScreen({super.key});

  @override
  State<MultiDataModelScreen> createState() => _MultiDataModelScreenState();
}

class _MultiDataModelScreenState extends State<MultiDataModelScreen> {
  bool isLoading = false;
  MultiData multiData = MultiData();
  _getMultiData(){
    isLoading = true;
    ApiServices().getMultiDataWithModel().then((value) {
      setState(() {
        multiData = value!;
        isLoading = false;
      });
    }).onError((error, stackTrace) {
      print(error);
    });
  }


  @override
  void initState() {
    _getMultiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi data with Model"),
      ),
      body:
      isLoading == true?
          Center(child: CircularProgressIndicator(
            color: Colors.green,
          ),):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(multiData.page.toString(), style: TextStyle(fontSize: 20),),
          ),
          Text(multiData.perPage.toString(), style: TextStyle(fontSize: 20),),
          Text(multiData.total.toString(), style: TextStyle(fontSize: 20),),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: multiData.data!.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      title: Text(multiData.data![index].id.toString()),
                      subtitle: Text(multiData.data![index].name.toString()),
                    ),
                  );
            }),
          )
        ],
      ),
    );
  }
}
