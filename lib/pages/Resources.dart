import 'package:flutter/material.dart';
import 'package:releave_app/lib.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesMain extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReLeave',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Resource(title: 'Resources'),
    );
  }
}

class Resource extends StatefulWidget {
  Resource ({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ResourcesState createState() => _ResourcesState();
}

class _ResourcesState extends State<Resource> {
  // Future<void> _showWarning() async{
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context){
  //         return AlertDialog(
  //           title: Text("Warning"),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //                 Text('If you are having a medical emergency'),
  //                 Text('Dial 911 immediately')
  //               ],
  //             ),
  //           ),
  //           actions: <Widget> [
  //             TextButton(
  //               child: Text("I understand"),
  //               onPressed: (){
  //                 Navigator.of(context).pop();
  //               }
  //             )
  //           ],
  //         );
  //       });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          SobrietyCounter(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Resources', style: TextStyle(fontSize: 30)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[
                  Container(
                    height: 150,
                    color: Color.fromARGB(255, 216, 222, 233),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Text('Suicide Hotline Website', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                              onTap: () => launch('https://suicidepreventionlifeline.org/')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('24/7, free and confidential support for people in distress, prevention and crisis resources.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    color: Color.fromARGB(255, 236, 239, 244),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Text('SAMHSA Helpline Website', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                              onTap: () => launch('https://www.samhsa.gov/find-help/national-helpline')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('SAMHSA’s National Helpline is a free, confidential, 24/7, 365-day-a-year treatment referral and information service (in English and Spanish) for individuals and families facing mental and/or substance use disorders.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    color: Color.fromARGB(255, 216, 222, 233),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                child: Text('Marijuana Anonymous', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                                onTap: () => launch('https://marijuana-anonymous.org/')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Marijuana Anonymous is a fellowship of people who share our experience, strength, and hope with each other that we may solve our common problem and help others to recover from marijuana addiction.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    color: Color.fromARGB(255, 236, 239, 244),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                child: Text('CDC Marijuana FAQs', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                                onTap: () => launch('https://www.cdc.gov/marijuana/faqs.htm')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Answers some common questions about marijuana including questions concerning its effects, addictive potential, and how to know if you are addicted.'),
                          ),
                        ),
                      ],
                    ),

                  ),
                  Container(
                    height: 170,
                    color: Color.fromARGB(255, 216, 222, 233),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                child: Text('Marijuana Addiction Help & Resources | SMART Recovery', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                                onTap: () => launch('https://www.smartrecovery.org/marijuana-addiction/')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('SMART Recovery is an abstinence-oriented, not-for-profit organization for individuals with addictive problems.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    color: Color.fromARGB(255, 236, 239, 244),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                child: Text('American Addiction Centers', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                                onTap: () => launch('https://americanaddictioncenters.org/marijuana-rehab')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('American Addiction Centers runs a network of addiction rehab centers around the country.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    color: Color.fromARGB(255, 216, 222, 233),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                child: Text('National Institute on Drug Abuse', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 94, 129, 172))),
                                onTap: () => launch('https://www.drugabuse.gov/publications/research-reports/marijuana/available-treatments-marijuana-use-disorders')
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('This site provides information on available treatments for marijuana use disorders.'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}
