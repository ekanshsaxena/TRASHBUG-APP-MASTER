import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:trashbug/Gmap.dart';
import 'package:trashbug/locations/map_ui.dart';
import 'package:trashbug/models/user.dart';
import 'package:trashbug/ui/login_page.dart';
import 'package:trashbug/ui/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trashbug/ui/wrapper.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/dashboard/dash1.dart";

  @override
  _DashboardOnePageState createState() => _DashboardOnePageState();
}

class _DashboardOnePageState extends State<DashboardOnePage> {
  _launchURL() async {
    String url = 'https://trash-bug.flycricket.io/privacy.html';
    if (await canLaunch(url)) {
      await launch(url);
    }
    // else {
    //   // throw 'Could not launch $url';
    //   _showErrorSnackBar();
    // }
  }

  _launchURL1() async {
    String url = 'https://trash-bug.flycricket.io/terms.html';
    if (await canLaunch(url)) {
      await launch(url);
    }
    // else {
    //   // throw 'Could not launch $url';
    //   _showErrorSnackBar();
    // }
  }

  int count_uploads = 0, count_approved = 0;
  double success_rate = 0;

  void getCount() async {
    var url = "http://165.22.209.211:4040/";
    // Dio dio = new Dio();
    // Response response = await dio.get(url);
    // // final response = await dio.get(url);
    final response = await http.get(Uri.encodeFull(url),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        var count_data = json.decode(response.body);
        count_uploads = count_data["uploads"];
        count_approved = count_data["approved"];
        if (count_uploads != 0) {
          success_rate = (((count_approved * 1.0) / count_uploads) * 100);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCount();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    print("====================================================>");
    print(user.id);
    print("====================================================>");

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
            child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
                )),
                // arrowColor: Colors.black,

                accountName: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 35),
                ),

                accountEmail: Text(
                  "Ayush",
                  // user.name,
                  style: TextStyle(fontSize: 25),
                ),
                // currentAccountPicture: CircleAvatar(
                //   backgroundColor: Colors.black,
                // ),
              ),

              ListTile(
                title: Text("About"),
                trailing: Icon(Icons.help),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('About'),
                      content: Text('An app to detect trash. :-)'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(); // dismisses only the dialog and returns nothing
                          },
                          child: new Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                // leading: CircleAvatar(child: Text("B")),
              ),
              Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
              ListTile(
                title: Text("Terms & Conditions"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Terms & Conditions'),
                      content: Text(
                          'Do you want to be redirected to the Terms and Conditions page?'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(); // dismisses only the dialog and returns nothing
                          },
                          child: new Text('NO'),
                        ),
                        new FlatButton(
                          onPressed: _launchURL1,
                          child: new Text('YES'),
                        ),
                      ],
                    ),
                  );
                },
                // subtitle: miniicon(Icons.security),
                trailing: Icon(Icons.security),
              ),
              //---------------------------

              Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
              ListTile(
                title: Text("Privacy Policy"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Privacy Policy'),
                      content: Text(
                          'Do you want to be redirected to the Privacy Policy page?'),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(); // dismisses only the dialog and returns nothing
                          },
                          child: new Text('NO'),
                        ),
                        new FlatButton(
                          onPressed: _launchURL,
                          child: new Text('YES'),
                        ),
                      ],
                    ),
                  );
                },
                // subtitle: miniicon(Icons.security),
                trailing: Icon(Icons.settings),
              ),

              //-----------
              Divider(
                color: Colors.white,
                thickness: 2.0,
              ),
              ListTile(
                title: Text("Contact Us"),
                trailing: Icon(Icons.contact_mail),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                      title: new Text('Contact Us'),
                      content: SelectableText(
                          'Feel Free to Contact Us at -: \n\nCodebugged Lab - Madan Mohan Malviya University of Technology Codebugged Back Office - G-73A, Opposite Ansal Plaza, Sector 23, Gurugram - 122017 \n\ninfo@codebugged.com '),
                      actions: <Widget>[
                        new FlatButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop(); // dismisses only the dialog and returns nothing
                          },
                          child: new Text('OK'),
                        ),
                      ],
                    ),
                  );
                },

                // leading: CircleAvatar(child: Text("B")),
              ),
              Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
              ListTile(
                title: Text("Log Out"),
                // subtitle: Text("CLoses Window"),
                trailing: Icon(Icons.logout),
                onTap: () async {
                  await _firebaseAuth.signOut();
                  return Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()),
                      (Route<dynamic> route) => false);
                },
              ),
              Divider(
                thickness: 2.0,
                color: Colors.white,
              ),
            ],
          ),
        )),
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[        
        _buildStats(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildTitledContainer("Stats",
                child: Container(
                    height: MediaQuery.of(context).size.width / 2,
                    child: DonutPieChart.withSampleData())),
          ),
        ),
        _buildActivities(context),
      ],
    );
  }

  SliverPadding _buildStats() {
    final TextStyle stats = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white);
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.5,
        crossAxisCount: 3,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  count_uploads.toString(),
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Uploads".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.pink,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  count_approved.toString(),
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Approved".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  success_rate.toStringAsFixed(1),
                  style: stats,
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Success(in %)".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildActivities(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(30.0),
      sliver: SliverToBoxAdapter(
        child: Wrap(
          
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              height: 120.0,
              width: 120.0,
              child: new RaisedButton(
                padding: EdgeInsets.all(0.0),
                //elevation: 100.0,
                color: Colors.white,
                highlightElevation: 0.0,
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Scan()));
                },
                // splashColor: Colors.red,
                // highlightColor: Colors.red,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.camera, size: 40, color: Colors.blue),
                    SizedBox(height: 5),
                    Text(
                      "Scan the trash",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0.0),
              height: 120.0,
              width: 120.0,
              child: new RaisedButton(
                padding: EdgeInsets.all(0.0),
                //elevation: 100.0,
                color: Colors.white,
                highlightElevation: 0.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Gmap()));
                },
                // splashColor: Colors.red,
                // highlightColor: Colors.red,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.black, width: 4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.map, size: 40, color: Colors.blue),
                    SizedBox(height: 5),
                    Text(
                      "Show Map",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SliverPadding _buildActivities(BuildContext context) {
  //   return SliverPadding(
  //     padding: const EdgeInsets.all(16.0),
  //     sliver: SliverToBoxAdapter(
  //       child: _buildTitledContainer(
  //         "Activities",
  //         height: MediaQuery.of(context).size.width / 2.8,
  //         child: Expanded(
  //           child: GridView.count(
  //             physics: NeverScrollableScrollPhysics(),
  //             crossAxisCount: 3,
  //             children: activities
  //                 .map(
  //                   (activity) => Column(
  //                     children: <Widget>[
  //                       GestureDetector(
  //                         onTap: () {
  //                           if (activity.title == "Profile")
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => ProfilePage()));
  //                           else if (activity.title == "Scan")
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => TestImage()));
  //                           else if (activity.title == "Settings")
  //                             Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => TestImage()));
  //                         },
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             if (activity.title == "Scan")
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => Scan()));

  //                             if (activity.title == "Coming soon")
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => Scan()));

  //                             if (activity.title == "Profile")
  //                               Navigator.push(
  //                                   context,
  //                                   MaterialPageRoute(
  //                                       builder: (context) => ProfilePage()));
  //                           },
  //                           child: CircleAvatar(
  //                             radius: 20,
  //                             backgroundColor: Theme.of(context).buttonColor,
  //                             child: activity.icon != null
  //                                 ? Icon(
  //                                     activity.icon,
  //                                     size: 18.0,
  //                                   )
  //                                 : null,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 5.0),
  //                       Text(
  //                         activity.title,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 14.0),
  //                       ),
  //                     ],
  //                   ),
  //                 )
  //                 .toList(),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      titleSpacing: 20,
      elevation: 0.5,
      backgroundColor: Colors.transparent,
      title: Text(
        "TrashBug",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
        textAlign: TextAlign.center,
      ),
      // actions: <Widget>[_buildAvatar(context)],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return IconButton(
      iconSize: 40,
      padding: EdgeInsets.all(0),
      icon: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.black),
      onPressed: () async {
        // await auth.googleSignOut();
        await _firebaseAuth.signOut();
        return Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      },
    );
  }

  Container _buildTitledContainer(String title, {Widget child, double height}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
          ),
          if (child != null) ...[const SizedBox(height: 10.0), child]
        ],
      ),
    );
  }
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createSampleData() {
    final data = [
      new LinearSales("Approved", 100),
      new LinearSales("Bugged", 75),
      new LinearSales("In process", 25),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Stats',
        domainFn: (LinearSales sales, _) => sales.month,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String month;
  final int sales;

  LinearSales(this.month, this.sales);
}

// class Activity {
//   final String title;
//   final IconData icon;
//   Activity({this.title, this.icon});

// }

// final List<Activity> activities = [
//   Activity(title: "Profile", icon: FontAwesomeIcons.personBooth),
//   Activity(title: "Scan", icon: FontAwesomeIcons.cameraRetro),
//   Activity(title: "Coming soon", icon: FontAwesomeIcons.building),
// ];
