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
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
            child: _requestList()
          )
       
    );
  }

  Widget _requestList() {
    return FutureBuilder(
      future: requestService.getAllRequestByPersonId(1),
      builder: (BuildContext context,
        AsyncSnapshot<List<RequestModel>> snapshot) {
          if ( snapshot.hasData ){
            final requests = snapshot.data;
            print(requests.length);
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) =>
                _requestCard(context, requests[index])
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

    Widget _requestCard(BuildContext context, RequestModel request) {
    return 
    Container(
      padding: EdgeInsets.all(5.0),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.white, /* Color.fromRGBO(253, 67, 27, 0.9), */
        child: Column(
          children: <Widget>[
            Row(
              children: [
               Expanded(
                 child: Container(
                        /* color: Colors.black, */
                        child: ListTile(
                          leading: Icon(Icons.photo, color: Colors.blue),
                          title: Text(request.veterinaryName/* , style: TextStyle(color: Colors.white) */),
                          subtitle: Text(request.petName/* , style: TextStyle(color: Colors.white54) */),
                        ),
                    ),
               ),
               if(request.status == 0 ) Expanded(
                 child: Align(
                   alignment: Alignment.bottomRight,
                   child: Container(
                          child: Expanded(
                            child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.yellowAccent,
                                        borderRadius: BorderRadius.circular(30.0) 
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 30.0),
                                      child: Text('data', style: TextStyle(color: Colors.yellowAccent)),
                                    )
                          )
                   )
                  ),
                ),
                if(request.status == 1 ) Expanded(
                 child: Align(
                   alignment: Alignment.bottomRight,
                   child: Container(
                          child: Expanded(
                            child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(30.0) 
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 30.0),
                                      child: Text('data', style: TextStyle(color: Colors.green)),
                                    )
                          )
                   )
                  ),
                 ),
                 if(request.status == 2 ) Expanded(
                 child: Align(
                   alignment: Alignment.bottomRight,
                   child: Container(
                          child: Expanded(
                            child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(30.0) 
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 30.0),
                                      child: Text('data', style: TextStyle(color: Colors.red)),
                                    )
                          )
                   )
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


