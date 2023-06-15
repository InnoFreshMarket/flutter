import 'package:flutter/material.dart';
import 'package:fermer/ui/widgets/admin_info.dart';

class AdminStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminProfilePage()),
            );
          },
        ),
        title: Text('Статистика'),
      ),
      body: Center(
        child: Text('Здесь отображается статистика'),
      ),
    );
  }
}