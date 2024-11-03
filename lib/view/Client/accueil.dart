import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myparaconnect/view/Client/drawerClient.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<dynamic> produitClients = [];
  List<dynamic> filteredProducts = []; // Liste filtrée pour la recherche
  Map<dynamic, int> cartProducts = {}; // Products with quantities
  double totalPrice = 0.0; // Total price of products in the cart
  String searchQuery = ''; // Requête de recherche
  String? selectedCategory; // Catégorie sélectionnée

  @override
  void initState() {
    super.initState();
    _loadProduitClientData();
  }

  Future<void> _loadProduitClientData() async {
    String jsonString =
    await rootBundle.loadString('assets/produitclient.json');
    setState(() {
      produitClients = json.decode(jsonString);
      filteredProducts = produitClients; // Initialement, tous les produits sont affichés
    });
  }

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query;
      _updateFilteredProducts();
    });
  }

  void _filterByCategory(String? category) {
    setState(() {
      selectedCategory = category;
      _updateFilteredProducts();
    });
  }

  void _updateFilteredProducts() {
    filteredProducts = produitClients.where((produit) {
      final matchesQuery = produit['Designation']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          produit['SansPromo']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase());

      final matchesCategory = selectedCategory == null ||
          produit['categorie'] == selectedCategory;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  void _resetFilters() {
    setState(() {
      selectedCategory = null; // Réinitialiser la catégorie sélectionnée
      filteredProducts = produitClients; // Afficher tous les produits
      searchQuery = ''; // Réinitialiser la requête de recherche
    });
  }

  void _addToCart(dynamic product) {
    setState(() {
      if (cartProducts.containsKey(product)) {
        cartProducts[product] = cartProducts[product]! + 1; // Increment quantity
      } else {
        cartProducts[product] = 1; // Add product with quantity 1
      }
      totalPrice += product['Prix']; // Ajouter le prix du produit au total
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['Designation']} ajouté au panier')),
    );
  }

  void _removeFromCart(dynamic product) {
    setState(() {
      if (cartProducts.containsKey(product)) {
        cartProducts[product] = cartProducts[product]! - 1;
        totalPrice -= product['Prix']; // Soustraire le prix du produit du total
        if (cartProducts[product] == 0) {
          cartProducts.remove(product); // Remove product if quantity is 0
        }
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product['Designation']} retiré du panier')),
    );
  }

  void _showCart() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Produits dans le panier'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              children: [
                if (cartProducts.isEmpty)
                  Text('Aucun produit dans le panier.'),
                if (cartProducts.isNotEmpty)
                  Column(
                    children: cartProducts.entries.map((entry) {
                      final produit = entry.key;
                      final quantity = entry.value;
                      return ListTile(
                        title: Text(produit['Designation']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Sans Promo: ${produit['SansPromo']}'),
                            Text('Prix unitaire: ${produit['Prix']} TND'),
                            Text('Quantité: $quantity'), // Afficher la quantité
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => _removeFromCart(produit),
                              tooltip: 'Retirer du panier',
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () => _addToCart(produit),
                              tooltip: 'Ajouter plus',
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                Divider(),
                Text(
                  'Total: ${totalPrice.toStringAsFixed(2)} TND',
                  style: TextStyle(fontWeight: FontWeight.bold), // Afficher le prix total
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double width = screenWidth;
    double height = screenHeight;

    // Récupération des catégories uniques
    final uniqueCategories = produitClients
        .map((produit) => produit['categorie'])
        .toSet()
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Row(
          children: [
            Container(
              height: height * 0.05,
              width: width * 0.48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green.shade800,
              ),
              child: Center(
                child: Text(
                  "Responsable Général ",
                  style: TextStyle(
                    fontSize: width * 0.042,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart,color: Color(0xFF1D1169)),
            onPressed: _showCart,
            tooltip: 'Voir le panier',
          ),
        ],
      ),
      drawer: Drawer(child: MyDrawerClient()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: 'Rechercher un produit',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // Affichage des catégories avec l'option pour tout afficher
          Container(
            padding: EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                // Bouton pour réinitialiser le filtre
                ChoiceChip(
                  label: Text('Tout afficher'),
                  selected: selectedCategory == null,
                  onSelected: (selected) {
                    if (selected) _resetFilters();
                  },
                ),
                // Affichage des catégories uniques
                ...uniqueCategories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (selected) {
                      _filterByCategory(selected ? category : null);
                    },
                  );
                }).toList(),
              ],
            ),
          ),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final produit = filteredProducts[index];
                return Card(
                  color: Colors.grey.shade100,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: Image(
                      image:AssetImage( produit['produit']), // Assuming imageUrl exists in JSON
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      produit['Designation'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sans Promo: ${produit['SansPromo']}'),
                        Text('Promo: ${produit['Promo']}'),
                        Text('Prix: ${produit['Prix']} TND'), // Afficher le prix
                      ],
                    ),
                    trailing: Container(
                      width: width*0.18,
                      height: height*0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xFF1D1169),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.add_shopping_cart,size: width*0.08,color: Colors.white,),
                        onPressed: () => _addToCart(produit),
                        tooltip: 'Ajouter au panier',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
