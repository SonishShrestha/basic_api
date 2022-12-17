import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(AboutPage());
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // String? stringResponse;
  //   List? listResponse;
    Map? mapResponse;
    List? listOfFacts;
  // Future fetchData() async{
  //
  //   http.Response response = await http.get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=4'));
  //
  //   if(response.statusCode==200){
  //     setState(() {
  //       stringResponse = response.body;
  //     });
  //   }
  // }
  Future fetchData() async{
    http.Response response =await http.get(Uri.parse('https://thegrowingdeveloper.org/apiview?id=2'));
        if(response.statusCode==200){
          setState(() {
            mapResponse = json.decode(response.body);
            listOfFacts = mapResponse?["facts"];


          });
        }
  }
   @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Fetcing Api'),
            centerTitle: true,
          ),
          body: ListView.builder(


            shrinkWrap: true,
              itemCount: listOfFacts?.length,
              itemBuilder: (context, index) {
                return Container(


                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Text(mapResponse!["category"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                      Image.network(listOfFacts?[index]['image_url']),

                      Text(
                        listOfFacts![index]["title"].toString(),
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      Text(
                        listOfFacts![index]["description"].toString(),
                        style: TextStyle(fontSize: 20),
                      ),

                    ],
                  ),
                );
              })),
    );
  }
}
