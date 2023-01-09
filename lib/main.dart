import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp( 
  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Player()),
      ],
      child:  MyApp(),
    ),);  
  
class MyApp extends StatelessWidget {  
  // This widget is the root of your application.  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'Hello World Flutter Application',  
      theme: ThemeData(  
        // This is the theme of your application.  
        primarySwatch: Colors.blue,  
      ),  
      home:const MyHomePage(),  
    );  
  }  
}  
 
class MyHomePage extends StatefulWidget {


  const MyHomePage({Key? key}):super(key: key);
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title:const Text('List')),
        drawer: Drawer(   
        child: ListView(   
        children: const <Widget>[   
        SizedBox(
          height:200,
       child:DrawerHeader(   
             
            decoration: BoxDecoration(   
            color: Color.fromARGB(255, 255, 255, 255),   
            ),   
            child: Text(   
            'Welcome to Flutter',   
            style: TextStyle(   
                color: Color.fromARGB(255, 11, 17, 191),   
                fontSize: 30,
               
            ),  textAlign:TextAlign.center,  
              ),   
        ),
        ) , 
           
        ListTile(  
            title:Text('All Mail Inboxes'),  
            trailing: Icon(Icons.mail),  
        ),  
        Divider(  
            height: 10,  
        ),  
        ListTile(  
            title: Text("Primary"),  
        ),  
        ListTile(  
            title: Text("Social"),  
        ),  
        ListTile(  
            title: Text("Promotions"),  
        ),   
        ],   
         ),   
  ),  

   bottomNavigationBar: BottomAppBar(  
        shape: const CircularNotchedRectangle(),  
        child: Container(  
          padding: EdgeInsets.all(7),
          height: 50.0, 
          color: Colors.blue, 
          child:Text('Lower Bar',style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,), 
        ),
         
      ),  
      floatingActionButton: FloatingActionButton(onPressed: (){},
      child:Icon(Icons.add),tooltip: 'Increment Counters',),
      body: ListView.builder(
        itemCount: context.watch<Player>().len,
        itemBuilder: (BuildContext context, int index) {
          List<ProductModel> playerList=context.read<Player>().prodlst;

          return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 30,bottom: 20),
            
            child: Row(
              
              children: [
               InkWell(
                onTap: (){
                 // print("Tapped");
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PlayerDetail()));
              
                context.read<Player>().tappedPlayer('${playerList[index].name}');
                print(context.read<Player>()._selectedPlayer);
                },
                child:ClipRRect(
              borderRadius: BorderRadius.circular(10),
              
              child: Consumer<Player>(builder: (context,player,child){
                return Image.asset('${player.prodlst[index].image}',height: 300,width: 200,fit: BoxFit.cover,);},),
              
               ),  
               ),
               Container(
                width: MediaQuery.of(context).size.width-220,
               
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     margin: EdgeInsets.only(left:15),  
                   child: Consumer<Player>(builder: (context,player,child){
                return Text('${player.prodlst[index].name}',style: TextStyle(fontSize: 30),textAlign: TextAlign.right);},),
                           
                  ),
                //  IconButton(onPressed: (){
                //   setState(() {
                //     // productList[index].selected=!productList[index].selected;
                //     ;
                //   });
                //   print("Index is $index");
                  
                //   },
                //  icon: Iconselected==true? Icons.play_arrow_rounded:Icons.pause_circle_filled_outlined )
                //  )
                ],),
              )
               
              ],
            ),
          );
        },
      ),
    );

  }
}

class PlayerDetail extends StatelessWidget{

  const PlayerDetail({Key? key}):super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Column(
        
        children: [
          Image.asset(context.read<Player>()._selectedPlayer!.image),
          Container(
            margin: EdgeInsets.all(15),
            child:Text(context.read<Player>()._selectedPlayer!.name,style: TextStyle(fontSize: 30,color: Colors.blue),), 
          ),
          
          Container(    
              child: ElevatedButton(onPressed: (){
               //   print(context.read<Player>()._selectedPlayer!.name);
               context.read<Player>().eliminate(context.read<Player>()._selectedPlayer!.name);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
              
                
              }, child: Text("Remove"))
            ),  
        ],
      ),
    );
  }
}


class ProductModel{
 final  String image;
 final String name;
 

 ProductModel({required this.image,required this.name});

}

class Player with ChangeNotifier{
  bool selected=true;
  String playerName="";
  ProductModel? selectedPlayer;
  ProductModel? toberemovedplayer;


  List<ProductModel> productList=[
ProductModel(image: 'assets/messi.jpg', name: "Messi"),
ProductModel(image: "assets/ronaldo.jpg", name: "Ronaldo "),
ProductModel(image: "assets/neymar.jpg", name: "Neymar "),
ProductModel(image: "assets/halland.jpg", name: "Halland"),
ProductModel(image: "assets/robben.jpg", name: "Robben"),
ProductModel(image: "assets/ramos.jpg", name: "Ramos"),
ProductModel(image: "assets/benzema.jpg", name: "Benzema"),
ProductModel(image: "assets/mane.jpg", name: "Mane")


];
int get len=>productList.length;
String get _playerName=>playerName;
ProductModel? get _selectedPlayer=>selectedPlayer;
ProductModel? get _toberemovedplayer=>toberemovedplayer;
List<ProductModel> get prodlst=>productList;


void tappedPlayer(String name){
 ProductModel data= productList.firstWhere((element) => element.name==name);
 print(name);
 selectedPlayer=data;
 notifyListeners();
 
}

void eliminate(String name)
{
  ProductModel dname= prodlst.firstWhere((element) => element.name==name);
  toberemovedplayer=dname;
  print("Delete $dname");
  prodlst.removeWhere((element) => element.name==name);
  notifyListeners();
}


}