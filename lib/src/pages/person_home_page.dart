import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/models/provider_model.dart';
import 'package:petcare/src/services/person_profile_service.dart';
import 'package:petcare/src/services/provider_service.dart';

class HomePersonProfilePage extends StatefulWidget {
  @override
  _MainPersonProfilePageState createState() => _MainPersonProfilePageState();
}

class _MainPersonProfilePageState extends State<HomePersonProfilePage> {
  final providerService = ProviderService();
  final personProfileService = PersonProfileService();
  PersonProfileModel personProfile = PersonProfileModel();

  @override
  void initState() {
    personProfileService
        .getPersonProfileById(1)
        .then((value) => {personProfile = value});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          /* color: colorPetCare, */
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/huellas.jpg'),
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
                        top: 110,
                        left: 30,
                        right: 0,
                        child: Container(
                          child: Row(
                            children: [
                              personProfile.name != null
                                  ? Text(
                                      personProfile.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    )
                                  : Text(""),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 85,
                        right: 40,
                        child: Container(
                          child: CircleAvatar(
                            backgroundImage: personProfile.photo != null
                                ? NetworkImage(personProfile.photo)
                                : AssetImage('assets/no-image.png'),
                            radius: 25.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: _createListing(),
                ),
              ],
            ),
            Positioned(
              top: 150,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 54,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: colorPetCare,
                    )
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Buscar",
                      hintStyle: TextStyle(color: colorPetCare),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createListing() {
    return FutureBuilder(
        future: providerService.getAllProviders(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProviderModel>> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data;
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    _createItem(products[index], context));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createItem(ProviderModel product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        elevation: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: Column(
            children: <Widget>[
              (product.photo == null)
                  ? Image(
                      image: AssetImage('assets/no-image.png'),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/jar-loading.gif'),
                        image: NetworkImage(product.photo),
                        height: 300.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.businessName),
                    Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: colorPetCare,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(product.address),
                onTap: () => Navigator.pushNamed(
                  context,
                  'detail_provider',
                  arguments: product,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAvatarPhoto(PersonProfileModel personProfileModel) async {
    await personProfileService
        .getPersonProfileById(1)
        .then((value) => {personProfileModel = value});

    return Positioned(
      top: 75,
      right: 40,
      child: Container(
        child: CircleAvatar(
          backgroundImage: personProfileModel.photo != null
              ? NetworkImage(personProfileModel.photo)
              : AssetImage('assets/no-image.png'),
          radius: 30.0,
        ),
      ),
    );
  }
}
