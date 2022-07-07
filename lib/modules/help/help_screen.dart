
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  var selected='USA';

  var Lselected;
  var groub;

  Future<void>openLink(String link)async{
    var urlink=link;
    if(await canLaunch((urlink))){
      await launch (urlink);
    }
    else{
      await launch (urlink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.wb_incandescent_rounded
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          'help',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.indigoAccent[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Connect with admin cross',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigoAccent[400],
                ),
                child: MaterialButton(
                  onPressed: (){
                    openLink('https://www.facebook.com/profile.php?id=100006963885860');
                  },
                  child: Center(
                    child:Text(
                        'facebook',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color:Colors.white
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child:  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green,
                ),
                child: MaterialButton(
                  onPressed: (){
                    openLink('https://wa.me/+2001113312766');
                  },
                  child: Center(
                    child:Text(
                        'Whats app',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color:Colors.white
                        )
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'About Yora',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12
              ),
            ),
            Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                    'Yora Services'
                  ),
                  trailing:Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                    'Frequently asked questions'
                  ),
                  trailing:Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                    'Terms'
                  ),
                  trailing:Icon(
                    Icons.arrow_forward_ios
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Settings',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                      'Country'
                  ),
                  trailing:DropdownButton(
                    onChanged: (val){
                      setState(() {
                        selected=val;
                      });
                    },
                    value:selected ,
                    items: ['USA','UAE','SY','EGY','SR'].map((e) =>DropdownMenuItem(child: Text('$e'),value: e,)).toList(),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                      'Female'
                  ),
                  trailing:Radio(
                    value: 2,
                    groupValue:groub,
                    onChanged: (p){
                      setState(() {
                        groub=p;
                      });
                    },
                    activeColor: Colors.indigoAccent[400],
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  leading:Text(
                      'Male'
                  ),
                  trailing:Radio(
                    value: 1,
                    groupValue:groub,
                    onChanged: (v){
                      setState(() {
                        groub=v;
                      });
                    },
                    activeColor: Colors.indigoAccent[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
