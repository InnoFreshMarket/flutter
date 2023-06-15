import 'package:flutter/material.dart';
import 'package:fermer/ui/widgets/admin_statistics.dart';

class AdminProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Имя пользователя',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Email: example@example.com',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Телефон: +7 123 456 789',
                style: TextStyle(fontSize: 16.0),
              ),
              ElevatedButton(
                child: const Text('Посмотреть статистику'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminStatistics()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
