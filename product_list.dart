import 'package:flutter/material.dart';
import 'package:flutter_1/modules/product.dart';
import 'package:flutter_1/get_api/response.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  String? id;

  List<ProductItem>? _productInfo;

  @override
  void didChangeDependencies() async {
    final idCateg = ModalRoute.of(context)?.settings.arguments;
    assert(idCateg != null && idCateg is String, 'error');
    id = idCateg as String;
    super.didChangeDependencies();
    _productInfo = await ResponseCategory().getRespons(id.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id ?? '...'),
      ),
      body: (_productInfo == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              // separatorBuilder: (context, index) => const Divider(),
              itemCount: _productInfo!.length,
              itemBuilder: (context, index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(_productInfo![index].title),
                        subtitle: Text(
                          _productInfo![index].articl,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          '${_productInfo![index].price} руб. / 1м',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Image.network(_productInfo![index].picture)
                    ],
                  ),
                );
              },
            ),
    );
  }
}
