import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/models/provider_model.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/business_request_service.dart';
import 'package:petcare/src/services/person_profile_service.dart';
import 'package:petcare/src/services/provider_service.dart';

class HomeBusinessPage extends StatefulWidget {
  @override
  _HomeBusinessPageState createState() => _HomeBusinessPageState();
}

class _HomeBusinessPageState extends State<HomeBusinessPage> {
  final businessRequestService = new BusinessRequestService();

  final providerService = ProviderService();
  ProviderModel providerModel = ProviderModel();

  @override
  void initState() {
    providerService
        .getAllProviderByProviderId(1, 1)
        .then((value) => {providerModel = value});

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                        image: DecorationImage(
                          image: AssetImage('assets/huellas3.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 140,
                      right: 0,
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              'PETCARE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.pets,
                              size: 30,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      left: 30,
                      right: 0,
                      child: Container(
                        child: Row(
                          children: [
                            providerModel.businessName != null
                                ? Text(
                                    providerModel.businessName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  )
                                : Text(""),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      right: 40,
                      child: Container(
                        child: CircleAvatar(
                          backgroundImage: providerModel.photo != null
                              ? NetworkImage(providerModel.photo)
                              : AssetImage('assets/no-image.png'),
                          radius: 25.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  child: _requestList(),
                  /* decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/huellas2.jpg'),
                        fit: BoxFit.cover),
                  ), */
                ),
              ),
            ],
          ),
          _exitButton(context)
        ],
      ),
    );
  }

  Widget _background() {
    final totalSize = MediaQuery.of(context).size;

    return Container(
      height: totalSize.height * 0.6,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(100.0),
        ),
        image: DecorationImage(
          image: AssetImage('assets/huellas3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _requestItem(BuildContext context, RequestModel request) {
    return request.status == 0
        ? Container(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text(request.productName)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(request.personName),
                                Text(request.petName),
                                Text(request.dateReservation.toString()),
                                Text(request.startTime),
                                Text(request.personPhone)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  color: colorPetCare,
                                  child: FadeInImage(
                                    placeholder:
                                        AssetImage('assets/jar-loading.gif'),
                                    image: NetworkImage(request.petPhoto),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Icon(
                                Icons.call,
                                color: Colors.greenAccent,
                                size: 40.0,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: FlatButton(
                          onPressed: () {},
                          child: Text(
                            'Rechazar',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              businessRequestService.updateRequest(
                                  1, request.id, 1);
                            });
                          },
                          child: Text(
                            'Aceptar',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _requestList() {
    return FutureBuilder(
        future: businessRequestService.getAllRequestByProviderId(1),
        builder:
            (BuildContext context, AsyncSnapshot<List<RequestModel>> snapshot) {
          if (snapshot.hasData) {
            final requests = snapshot.data;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) =>
                  _requestItem(context, requests[index]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  _exitButton(BuildContext context) {
    return Positioned(
      top: 30,
      right: 15,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'login'),
        child: Container(
          child: Icon(
            Icons.cancel,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }
}
