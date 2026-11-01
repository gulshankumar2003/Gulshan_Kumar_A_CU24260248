import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  Future<List> getProducts() async {
    var res = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (res.statusCode != 200) throw Exception('Request failed');
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Store")),
      body: FutureBuilder<List>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          }
          return GridView.builder(
            padding: EdgeInsets.all(8),
            itemCount: snapshot.data!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, i) {
              var p = snapshot.data![i];
              return Card(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Detail(product: p),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            p['image'],
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.image_not_supported),
                          ),
                        ),
                        Text(p['title'], maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        Text("\$${p['price']}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final Map product;

  Detail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              product['image'],
              height: 200,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.image_not_supported),
            ),
            SizedBox(height: 16),
            Text(product['title']),
            Text("Price: \$${product['price']}"),
            Text(product['description']),
          ],
        ),
      ),
    );
  }
}
