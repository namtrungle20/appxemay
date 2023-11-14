import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý cửa hàng xe máy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MotorcycleStore(),
    );
  }
}

class Motorcycle {
  int id;
  String name;
  String brand;
  double price;

  Motorcycle({required this.id, required this.name, required this.brand, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
    };
  }

  factory Motorcycle.fromMap(Map<String, dynamic> map) {
    return Motorcycle(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      price: map['price'],
    );
  }
  
}


class MotorcycleStore extends StatefulWidget {
  @override
  _MotorcycleStoreState createState() => _MotorcycleStoreState();
}

class _MotorcycleStoreState extends State<MotorcycleStore> {
  List<Motorcycle> motorcycles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý cửa hàng xe máy'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: motorcycles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(motorcycles[index].name),
                  subtitle: Text('${motorcycles[index].brand} - \$${motorcycles[index].price.toStringAsFixed(2)}'),
                  onTap: () {
                    // Gọi hàm để hiển thị chi tiết xe máy hoặc thực hiện các hành động khác
                    // ở đây bạn có thể chuyển đến trang chi tiết xe máy
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Gọi hàm để thêm xe máy mới
                _showAddMotorcycleDialog();
              },
              child: Text('Thêm xe máy'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMotorcycleDialog() {
    TextEditingController idController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController brandController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm xe máy mới'),
          content: Column(
            children: [
              TextField(
               controller: idController,
                keyboardType: TextInputType.number, // Đặt kiểu bàn phím để chỉ chấp nhận số
                decoration: const InputDecoration(labelText: 'ID'),
            ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Tên xe máy'),
              ),
              TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'Hãng xe'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Giá'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                // Thêm xe máy mới vào danh sách
                setState(() {
                  motorcycles.add(
                    Motorcycle(
                      id : int.tryParse(idController.text) ?? 0,
                      name: nameController.text,
                      brand: brandController.text,
                      price: double.tryParse(priceController.text) ?? 0.0,
                    ),
                  );
                });
                Navigator.pop(context);
              },
              child: const Text('Thêm'),
            ),
          ],
        );
      },
    );
  }
}