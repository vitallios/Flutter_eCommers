import 'package:flutter/material.dart';
import 'package:gtc/modules/product_item.dart';
import 'package:gtc/pages/product_details.dart';

import '../api/api.dart';

class ProductList extends StatefulWidget {
  final String data;
  final String title;

  const ProductList({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late String _data;
  late String _title;

  List<ProductItem>? _productInfo;

  @override
  void didChangeDependencies() async {
    _data = widget.data;
    _title = widget.title;

    super.didChangeDependencies();
    _productInfo = await ResponseCategory().getRespons(_data.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(title: _title),
      body: RefreshIndicator(
        onRefresh: () async {
          _productInfo = await ResponseCategory().getRespons(_data.toString());
          // print('Refresh');
        },
        child: (_productInfo == null)
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // количество рядов
                  crossAxisCount: 2,
                  // Размер карточек
                  mainAxisExtent: 370,
                  // mainAxisSpacing: 7,
                ),
                itemCount: _productInfo!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          // Заголовок
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text(
                                _productInfo![index].title,
                                maxLines: 2,
                              ),
                              subtitle: Text(
                                _productInfo![index].articl,
                              ),
                            ),
                          ),
                          // картинка
                          Expanded(
                            flex: 2,
                            child: Image.network(
                              _productInfo![index].picture,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          // Описание товара
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        _productInfo![index].paramColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_productInfo![index].price}руб./1м.',
                                      ),
                                      Text('${_productInfo![index].count}')
                                    ],
                                  ),
                                  Couner(
                                    item: _productInfo![index].count,
                                    min: 0.5,
                                    max: _productInfo![index].count,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductDetails(),
                          settings: RouteSettings(
                            arguments: _productInfo![index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

//

//

class Couner extends StatefulWidget {
  final double min;
  final double max;
  final double item;
  const Couner({
    super.key,
    required this.min,
    required this.max,
    required this.item,
  });

  @override
  State<Couner> createState() => _CounerState();
}

class _CounerState extends State<Couner> {
  double value = 0.5;
  String countKol = '0.5';

  void add() {
    setState(() {
      if (value >= 0.5) {
        value = value + 0.1;
        countKol = value.toStringAsFixed(1);
      } else {
        value = 0.5;
      }
    });
  }

  void remove() {
    setState(() {
      if (value <= 0.5) {
        value = 0.5;
      } else {
        value = value - 0.1;
        countKol = value.toStringAsFixed(1);
      }
      // value = value - 0.1;
      // countKol = value.toStringAsFixed(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SizedBox(
          width: 10,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              add();
            },
            child: const Icon(Icons.add),
          ),
        )),
        //
        Expanded(
          child: Center(child: Text(countKol)),
        ),
        //
        Expanded(
            child: SizedBox(
          width: 10,
          height: 40,
          child: FloatingActionButton(
            onPressed: () {
              remove();
            },
            child: const Icon(Icons.remove),
          ),
        )),
      ],
    );
  }
}

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBars({
    super.key,
    required this.title,
  }) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
