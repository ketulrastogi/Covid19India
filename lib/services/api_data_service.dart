import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ApiDataService with ChangeNotifier {
  Map<String, dynamic> stateData = {};
  List<Map<String, dynamic>> stateWiseData = [];

  List<Map<String, dynamic>> rawData = [];

  Map<String, dynamic> latestTotalData = {};
  List<Map<String, dynamic>> latestAllData = [];
  List<Map<String, dynamic>> latestStateWiseData = [];

  Map<String, dynamic> dashBoardData = {
    'confirmed': 0,
    'confirmedNew': 0,
    'active': 0,
    'activeNew': 0,
    'recovered': 0,
    'recoveredNew': 0,
    'death': 0,
    'deathNew': 0
  };

  ApiDataService.instance() {
    fetchRawData();
    fetchStateWiseData();
    getLatestStateWiseData();
  }

  // New Api Data
  Future<List<Map<String, dynamic>>> getLatestStateWiseData() async {
    latestTotalData = {};
    latestAllData = [];
    latestStateWiseData = [];

    http.Response response = await http.get(
      'https://api.covid19india.org/data.json',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    // print(body);
    latestAllData = [...body['statewise']];

    latestTotalData = latestAllData.sublist(0, 1)[0];
    latestStateWiseData = latestAllData.sublist(1, latestAllData.length - 1);

    return latestAllData;

    // print(latestTotalData);
  }

  Map<String, dynamic> get getLatestTotalData => latestTotalData;
  // List<Map<String, dynamic>> get getLatestStateWiseData => latestStateWiseData;

  List<Map<String, dynamic>> get getStateWiseData => stateWiseData;
  Map<String, dynamic> get getDashboardData => dashBoardData;

  Future<void> fetchStateWiseData() async {
    http.Response response = await http.get(
      'https://api.covid19india.org/state_district_wise.json',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    stateData = body;
    // return body['Data'];
    setStateWiseData();
  }

  void setStateWiseData() {
    Map<String, dynamic> statedata = {
      'name': '',
      'confirmed': 0,
      'active': 0,
      'recovered': 0,
      'death': 0,
      'districts': [],
    };

    Map<String, dynamic> districtData = {
      'name': '',
      'confirmed': 0,
      'active': 0,
      'recovered': 0,
      'death': 0,
    };

    List<Map<String, dynamic>> allDistrictData = [];

    int confirmed = 0;
    int active = 0;
    int recovered = 0;
    int death = 0;

    stateData.keys.forEach((stateKey) {
      // print(stateKey);
      statedata['name'] = stateKey.toString();
      // print(statedata['name']);
      stateData[stateKey]['districtData'].keys.forEach((districtKey) {
        // print('$stateKey - $districtKey');
        // print('$stateKey - $districtKey');
        districtData['name'] = districtKey.toString();
        // print(districtData['name']);
        statedata['confirmed'] = statedata['confirmed'] +
            stateData[stateKey]['districtData'][districtKey]['confirmed'];
        statedata['active'] = statedata['active'] +
            stateData[stateKey]['districtData'][districtKey]['active'];
        statedata['recovered'] = statedata['recovered'] +
            stateData[stateKey]['districtData'][districtKey]['recovered'];
        statedata['death'] = statedata['death'] +
            stateData[stateKey]['districtData'][districtKey]['deaths'];

        districtData['confirmed'] = districtData['confirmed'] +
            stateData[stateKey]['districtData'][districtKey]['confirmed'];
        districtData['active'] = districtData['active'] +
            stateData[stateKey]['districtData'][districtKey]['active'];
        districtData['recovered'] = districtData['recovered'] +
            stateData[stateKey]['districtData'][districtKey]['recovered'];
        districtData['death'] = districtData['death'] +
            stateData[stateKey]['districtData'][districtKey]['deaths'];

        confirmed = confirmed +
            stateData[stateKey]['districtData'][districtKey]['confirmed'];
        active =
            active + stateData[stateKey]['districtData'][districtKey]['active'];
        recovered = recovered +
            stateData[stateKey]['districtData'][districtKey]['recovered'];
        death =
            death + stateData[stateKey]['districtData'][districtKey]['deaths'];

        // print(districtData);
        statedata['districts'].add(districtData);
        // allDistrictData.add(districtData);
        districtData = {
          'name': '',
          'confirmed': 0,
          'active': 0,
          'recovered': 0,
          'death': 0,
        };
      });

      // print(allDistrictData);

      stateWiseData.add(statedata);
      statedata = {
        'name': '',
        'confirmed': 0,
        'active': 0,
        'recovered': 0,
        'death': 0,
        'districts': [],
      };
    });
    // print('StateWiseData : $stateWiseData');
    notifyListeners();
    // return stateData;
  }

  Future<List<Map<String, dynamic>>> fetchRawData() async {
    DateTime now = DateTime.now();
    String currentDate = DateFormat('dd/MM/yyyy').format(now).toString();

    http.Response response = await http.get(
      'https://api.covid19india.org/raw_data.json',
    );

    Map<String, dynamic> body = await json.decode(response.body);
    // print('Body length : ${body['raw_data'].length}');
    rawData = [...body['raw_data']];
    // print('Raw data length : ${rawData.length}');
    dashBoardData['confirmed'] = rawData.length;
    // print('Dashboard data length : ${dashBoardData['confirmed']}');
    // int sum = 0;
    // print(currentDate);

    int confirmed = rawData.length;
    int active = 0;
    int recovered = 0;
    int death = 0;

    rawData.forEach((data) {
      // dashBoardData['confirmedNew'] = rawData
      //     .where((item) => (item['statuschangedate'] == currentDate))
      //     .toList()
      //     .length;

      // print(dashBoardData['confirmedNew']);
      if (data['statuschangedate'] == currentDate) {
        dashBoardData['confirmedNew'] = dashBoardData['confirmedNew'] + 1;
      }
      if (data['currentstatus'] == 'Recovered') {
        dashBoardData['recovered'] = dashBoardData['recovered'] + 1;
        recovered = recovered + 1;
        if (data['statuschangedate'] == currentDate) {
          dashBoardData['activeNew'] = dashBoardData['activeNew'] - 1;
          dashBoardData['recoveredNew'] = dashBoardData['recoveredNew'] + 1;
        }
      } else if (data['currentstatus'] == 'Hospitalized') {
        dashBoardData['active'] = dashBoardData['active'] + 1;
        active = active + 1;
        if (data['statuschangedate'] == currentDate) {
          dashBoardData['activeNew'] = dashBoardData['activeNew'] + 1;
        }
      } else if (data['currentstatus'] == 'Deceased') {
        dashBoardData['death'] = dashBoardData['death'] + 1;
        death = death + 1;
        dashBoardData['activeNew'] = dashBoardData['activeNew'] - 1;
        if (data['statuschangedate'] == currentDate) {
          dashBoardData['deathNew'] = dashBoardData['deathNew'] + 1;
        }
      }
    });
    // print(
    //     '2. Confirmed: $confirmed, Active: $active, Recovered: $recovered, Death: $death, UpdateActive: ${confirmed - recovered - death}');
    notifyListeners();
  }

  List<Map<String, dynamic>> getRawData() {
    return rawData;
  }

  Map<String, dynamic> getDashBoardData() {
    return dashBoardData;
  }
}
