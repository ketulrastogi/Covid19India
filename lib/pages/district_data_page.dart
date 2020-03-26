import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DistrictDataPage extends StatefulWidget {
  final Map<String, dynamic> stateData;

  const DistrictDataPage({Key key, this.stateData}) : super(key: key);
  @override
  _DistrictDataPageState createState() => _DistrictDataPageState();
}

class _DistrictDataPageState extends State<DistrictDataPage> {
  @override
  Widget build(BuildContext context) {
    // print(widget.stateData);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.stateData['name'],
            style: GoogleFonts.roboto(
              textStyle: Theme.of(context).textTheme.headline.copyWith(
                  color: Colors.blueGrey.shade900, fontWeight: FontWeight.bold),
            ),
          ),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.insert_chart,
          //     ),
          //     onPressed: () {
          //       setState(() {});
          //     },
          //   ),
          // ],
          // automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          // leading: IconButton(
          //   icon: Icon(Icons.help),
          //   onPressed: () {},
          // ),
        ),
        body: ListView(
          children: <Widget>[
            DistrictListHeadingWidget(),
            ...<Widget>[
              ...widget.stateData['districts'].map((data) {
                // print(data);
                return DistrictListCardWidget(
                  name: data['name'],
                  confirmed: data['confirmed'].toString(),
                  active: data['active'].toString(),
                  recovered: data['recovered'].toString(),
                  death: data['death'].toString(),
                );
              }).toList()
            ],
          ],
        ),
      ),
    );
  }
}

class DistrictListHeadingWidget extends StatelessWidget {
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
              'DISTRICT',
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

class DistrictListCardWidget extends StatelessWidget {
  final String name;
  final String confirmed;
  final String active;
  final String recovered;
  final String death;

  const DistrictListCardWidget(
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
