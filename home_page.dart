import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Список категорий с кодами для ссылок
final List<Map<String, Object>> catItem = [
  {'id': 1, 'name': 'Атлас', 'idCateg': 'x06'},
  {'id': 2, 'name': 'Бархат', 'idCateg': 'bc4'},
  {'id': 3, 'name': 'Шёлк', 'idCateg': 'sholk'},
];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.separated(
        // разделители между категорий
        separatorBuilder: (context, index) => const Divider(),
        itemCount: catItem.length,
        itemBuilder: (context, i) {
          // Вывод списка категорий и кнопок для перехода
          return ListTile(
            title: Text('${catItem[i]['name']}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/category',
                // передаем значение выбранной категории
                arguments: '${catItem[i]['idCateg']}',
              );
            },
          );
        },
      ),
    );
  }
}
