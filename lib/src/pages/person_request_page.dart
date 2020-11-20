import 'package:flutter/material.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/person_request_service.dart';

class PersonRequestPage extends StatefulWidget {
  @override
  _PersonRequestPageState createState() => _PersonRequestPageState();
}

class _PersonRequestPageState extends State<PersonRequestPage> {
  final requestService = new RequestService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _requestList(),
      ),
    );
  }

  Widget _requestList() {
    return FutureBuilder(
        future: requestService.getAllRequestByPersonId(1),
        builder:
            (BuildContext context, AsyncSnapshot<List<RequestModel>> snapshot) {
          if (snapshot.hasData) {
            final requests = snapshot.data;
            print(requests.length);
            return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) =>
                    _requestCard(context, requests[index]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _requestCard(BuildContext context, RequestModel request) {
    if (request.status == 0) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: _itemCard(request, Colors.yellowAccent));
    }
    if (request.status == 1) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: _itemCard(request, Colors.greenAccent));
    }
    if (request.status == 2) {
      return Container(
          padding: EdgeInsets.all(5.0),
          child: _itemCard(request, Colors.redAccent));
    }
  }

  _itemCard(RequestModel request, Color color) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: color,
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  child: ListTile(
                    leading: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/jar-loading.gif'),
                          image: NetworkImage(request.petPhoto),
                          fadeInDuration: Duration(milliseconds: 200),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    subtitle: Column(
                      children: [
                        Text(''),
                        Text(request.veterinaryName),
                        Text(request.productName),
                        Text(''),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: ListTile(
                    subtitle: Column(
                      children: [
                        Text(request.dateReservation),
                        Text(request.startTime),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
