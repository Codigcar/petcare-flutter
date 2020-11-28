import 'package:flutter/material.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/business_request_service.dart';
import 'package:petcare/src/services/person_profile_service.dart';

import '../../constants.dart';

class BusinessCustomersPage extends StatefulWidget {
  @override
  _BusinessCustomersPageState createState() => _BusinessCustomersPageState();
}

class _BusinessCustomersPageState extends State<BusinessCustomersPage> {
  final businessRequestService = new BusinessRequestService();
  final personProfileService = new PersonProfileService();
  var personProfile = new PersonProfileModel();
  List<RequestModel> listRequest = new List<RequestModel>();
  @override
  Widget build(BuildContext context) {
    personProfileService
        .getPersonProfileById(1)
        .then((value) => {personProfile = value});

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Mis Clientes'),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _createList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: businessRequestService.getAllRequestByProviderId(1),
      builder:
          (BuildContext context, AsyncSnapshot<List<RequestModel>> snapshot) {
        if (snapshot.hasData) {
          final getRequests = snapshot.data;
          return Expanded(
            child: GridView.builder(
              itemCount: getRequests.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.90),
              itemBuilder: (context, index) {
                if (index > 0) {
                  if (getRequests[index].status == 1) {
                    if (getRequests[index].personPhone !=
                        getRequests[index].personPhone)
                      return _createItem(context, getRequests[index]);
                  }
                } else {
                  if (getRequests[index].status == 1) {
                    return _createItem(context, getRequests[0]);
                  }
                }
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, RequestModel request) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'business_customer_pet',
            arguments: personProfile),
        child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: CircleAvatar(
                        backgroundColor: colorPetCare,
                        radius: 110,
                        child: CircleAvatar(
                          radius: 73,
                          backgroundImage: NetworkImage(personProfile.photo),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      personProfile.document,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
