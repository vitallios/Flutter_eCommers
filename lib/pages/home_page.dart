import 'package:flutter/material.dart';
import 'package:flutter_1/pages/products_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Список категорий с кодами для ссылок
final List<Map<String, Object>> catItem = [
  {'id': 'x06', 'name': 'Атлас'},
  {'id': 'bc4', 'name': 'Бархат'},
  {'id': 'sholk', 'name': 'Шёлк'},
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const CategoryList(),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // разделители между категорий
      separatorBuilder: (context, index) => const Divider(),
      itemCount: catItem.length,
      itemBuilder: (context, i) {
        // Вывод списка категорий и кнопок для перехода
        return ListTile(
          title: Text('${catItem[i]['name']}'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductList(
                  data: '${catItem[i]['id']}',
                  title: '${catItem[i]['name']}',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
