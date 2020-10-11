import 'package:flutter/material.dart';
import 'package:petcare/src/models/provider_model.dart';
import 'package:petcare/src/services/provider_service.dart';

class HomePersonProfilePage extends StatefulWidget {
  @override
  _MainPersonProfilePageState createState() => _MainPersonProfilePageState();
}

class _MainPersonProfilePageState extends State<HomePersonProfilePage> {
  final providerService = ProviderService();
  /* List<ProviderModel> providers = new List<ProviderModel>(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: _createListing(),
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
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          /*   businessProfileService.deleteProduct(product.id); */
        },
        child: Card(
          child: Column(
            children: <Widget>[
              (product.photo == null)
                  ? Image(image: AssetImage('assets/no-image.png'))
                  : FadeInImage(
                      placeholder: AssetImage('assets/jar-loading.gif'),
                      image: NetworkImage(/* product.photo */'assets/no-image.png'),
                      height: 300.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              ListTile(
                title: Text(product.businessName),
                subtitle: Text(product.address),
                onTap: () =>
                    Navigator.pushNamed(context, 'detail_provider', arguments: product),
              ),
            ],
          ),
        ));
  }
}

/*  businessProfileService.getAllBusiness()
      .then((value) => businessProfiles = value);
      print(businessProfiles); */
