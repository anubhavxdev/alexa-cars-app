// Screens/car_list_screen.dart
import 'package:flutter/material.dart';

class CarListScreen extends StatelessWidget {
  final List<Map<String, String>> cars = [
    {
      'name': 'Toyota Fortuner',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/4/42/2017_Toyota_Fortuner_CRYSTAL.jpg',
    },
    {
      'name': 'Hyundai Creta',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/9/91/2020_Hyundai_Creta_1.6.jpg',
    },
    {
      'name': 'Honda City',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/7/75/2020_Honda_City_RS.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Cars')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 4,
            child: Column(
              children: [
                Image.network(car['image']!, height: 180, fit: BoxFit.cover),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(car['name']!, style: TextStyle(fontSize: 18)),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Booking for ${car['name']}')));
                        },
                        child: Text('Book'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
