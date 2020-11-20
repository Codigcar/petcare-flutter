import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
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
      /* appBar: AppBar(
        title: Text('data'),
      ), */
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: colorPetCare,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
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
                            blurRadius: 50,
                            color: colorPetCare)
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
          Expanded(
            flex: 4,
            child: _createListing(),
          ),
        ],
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
      padding: const EdgeInsets.all(14.0),
      child: Card(
        child: Column(
          children: <Widget>[
            (product.photo == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    image: NetworkImage(product.photo),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text(product.businessName),
              subtitle: Text(product.address),
              onTap: () => Navigator.pushNamed(context, 'detail_provider',
                  arguments: product),
            ),
          ],
        ),
      ),
    );
  }
}
