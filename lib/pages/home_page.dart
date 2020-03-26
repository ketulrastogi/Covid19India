import 'package:covid19india/services/api_data_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ApiDataService apiDataService = Provider.of<ApiDataService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Covid-19 India',
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.blueGrey.shade900, fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.refresh,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: apiDataService.getLatestStateWiseData(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    DashboardWidget(
                      dashboardData: snapshot.data[0],
                    ),
                    StateListHeadingWidget(),
                    ...<Widget>[
                      ...snapshot.data
                          .sublist(1, snapshot.data.length - 1)
                          .map((data) {
                        return StateListCardWidget(
                          name: data['state'],
                          confirmed: data['confirmed'].toString(),
                          active: data['active'].toString(),
                          recovered: data['recovered'].toString(),
                          death: data['deaths'].toString(),
                        );
                      }).toList()
                    ],
                  ],
                );
              } else {
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: <Widget>[
                    DashboardWidget(
                      dashboardData: null,
                    ),
                    StateListHeadingWidget(),
                    Container(
                      height: 200.0,
                      child: Center(
                        child: Container(
                          height: 20.0,
                          width: 20.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            // valueColor:
                            //     AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  final Map<String, dynamic> dashboardData;

  const DashboardWidget({Key key, this.dashboardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DataCardWidget(
                  title: 'CONFIRMED',
                  backgroundColor: Colors.indigo,
                  dataWidget: (dashboardData == null)
                      ? Center(
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : DataWidget(
                          total: dashboardData['confirmed'].toString(),
                          update:
                              dashboardData['delta']['confirmed'].toString(),
                        ),
                ),
                DataCardWidget(
                  title: 'ACTIVE',
                  backgroundColor: Colors.red,
                  dataWidget: (dashboardData == null)
                      ? Center(
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : DataWidget(
                          total: dashboardData['active'].toString(),
                          update: dashboardData['delta']['active'].toString(),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DataCardWidget(
                  title: 'RECOVERED',
                  backgroundColor: Colors.green,
                  dataWidget: (dashboardData == null)
                      ? Center(
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : DataWidget(
                          total: dashboardData['recovered'].toString(),
                          update:
                              dashboardData['delta']['recovered'].toString(),
                        ),
                ),
                DataCardWidget(
                  title: 'DEATH',
                  backgroundColor: Colors.grey.shade700,
                  dataWidget: (dashboardData == null)
                      ? Center(
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      : DataWidget(
                          total: dashboardData['deaths'].toString(),
                          update: dashboardData['delta']['deaths'].toString(),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  final String total;
  final String update;

  const DataWidget({Key key, this.total, this.update}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            total,
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        SizedBox(
          width: 8.0,
        ),
        Container(
          child: Text(
            '(+$update)',
            style: GoogleFonts.nunito(
              textStyle: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class DataCardWidget extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Widget dataWidget;

  const DataCardWidget({
    Key key,
    this.title,
    this.backgroundColor,
    this.dataWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 16,
      height: 96.0,
      child: Card(
        color: backgroundColor,
        child: Container(
          // padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: GoogleFonts.nunito(
                    textStyle: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 16.0,
              // ),
              dataWidget,
            ],
          ),
        ),
      ),
    );
  }
}

class StateListHeadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12.0,
        top: 24.0,
        bottom: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Text(
              'STATE/UT',
              style: GoogleFonts.nunito(
                textStyle: Theme.of(context).textTheme.subhead.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: Colors.white70,
                    ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Container(
                  height: 16.0,
                  width: 16.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 4.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StateListCardWidget extends StatelessWidget {
  final String name;
  final String confirmed;
  final String active;
  final String recovered;
  final String death;

  const StateListCardWidget(
      {Key key,
      this.name,
      this.confirmed,
      this.active,
      this.recovered,
      this.death})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 12.0),
      padding: EdgeInsets.only(
        left: 12.0,
        right: 8.0,
        top: 12.0,
        bottom: 12.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: GoogleFonts.nunito(
                  textStyle: Theme.of(context).textTheme.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                        // color: Colors.white70,
                      ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    confirmed,
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    active,
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    recovered,
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    death,
                    style: GoogleFonts.nunito(
                      textStyle: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
