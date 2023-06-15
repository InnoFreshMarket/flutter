import 'dart:convert';

import 'package:fermer/core/auth/server_api.dart';
import 'package:fermer/core/utils/token_api.dart';
import 'package:fermer/data/models/item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SellProductDialog extends StatefulWidget {
  @override
  _SellProductDialogState createState() => _SellProductDialogState();
}

class _SellProductDialogState extends State<SellProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costRetailController = TextEditingController();
  final TextEditingController _numberForWholesaleController = TextEditingController();
  final TextEditingController _costWholesaleController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubscribed = false;
  final TextEditingController _numberForMonthSubscriptionsController = TextEditingController();
  String _category = "Фрукты";
  DateTime? _completedDate;
  DateTime? _willExpiredDate;
  String? _image;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Добавить товар", style: Theme.of(context).textTheme.displayMedium),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Название товара"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Пожалуйста введите название товара";
                  }
                  return null;
                },
                onChanged: (newValue) => setState ((){ 
                  // validate
                  
                }),
                onSaved: (newValue) => setState ((){_nameController.text = newValue!;}),
              ),
              TextFormField(
                controller: _costRetailController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Цена (Розница)"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Пожалуйста введите цену";
                  }
                  double cost = double.tryParse(value)!;
                  if (cost <= 0) {
                    return "Цена должна быть больше 0 рублей";
                  }
                  return null;
                },
                onChanged: (newValue) => setState ((){_costRetailController.text = newValue;}),
              ),
              TextFormField(
                controller: _numberForWholesaleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Минимальное количество для опта"),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    int number = int.tryParse(value)!;
                    if (number <= 0) {
                      return "Количество должно быть больше 0";
                    }
                  }
                  return null;
                },
                onChanged: (newValue) => setState ((){_numberForWholesaleController.text = newValue;}),
              ),
              TextFormField(
                controller: _costWholesaleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Цена (Опт)"),
                enabled: _numberForWholesaleController.text.isNotEmpty,
                validator: (value) {
                  if (_numberForWholesaleController.text.isNotEmpty && value!.isEmpty) {
                    return "Пожалуйста введите цену";
                  }
                  if (value!.isNotEmpty) {
                    double cost = double.tryParse(value)!;
                    if (cost <= 0) {
                      return "Цена должна быть больше 0 рублей";
                    }
                  }
                  return null;
                },
                onChanged: (value) => setState ((){_costWholesaleController.text = value;}),
              ),
              const SizedBox(height: 16),
              const Text("Дата сбора:"),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _completedDate = pickedDate;
                    });
                  }
                },
                child: Text(_completedDate == null ? "Выберите дату" : _completedDate.toString()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Количество в наличии"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Пожалуйста введите количество товара";
                  }
                  double number = double.tryParse(value)!;
                  if (number <= 0) {
                    return "Количество должно быть больше 0";
                  }
                  return null;
                },
                onChanged: (newValue) => setState ((){_numberController.text = newValue;}),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Описание товара"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Пожалуйста введите описание товара";
                  }
                  return null;
                },
                onChanged: (newValue) => setState ((){_descriptionController.text = newValue;}),
              ),
              const SizedBox(height: 16),
              const Text("Просрочится"),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _willExpiredDate = pickedDate;
                    });
                  }
                },
                child: Text(_willExpiredDate == null ? "Выберите когда товар станет непригодным" : _willExpiredDate.toString()),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Доступен для подписки"),
                  Switch(
                    value: _isSubscribed,
                    onChanged: (value) {
                      setState(() {
                        _isSubscribed = value;
                      });
                    },
                  ),
                ],
              ),
              if (_isSubscribed) ...[
                TextFormField(
                  controller: _numberForMonthSubscriptionsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Максимальное доступное количество для подписки"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Пожалуйста введите количество товара";
                    }
                    int number = int.tryParse(value)!;
                    if (number <= 0) {
                      return "Количество должно быть больше 0";
                    }
                    return null;
                  },
                  onChanged: (newValue) => setState ((){_numberForMonthSubscriptionsController.text = newValue;}),
                ),
              ],
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(labelText: "Category"),
                items: ["Фрукты", "Овощи", "Другое"].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                  });
                },
                onSaved: (newValue) => setState ((){_category = newValue ?? "Другое";}),
              ),
              ElevatedButton(onPressed: () async{
                var picked = await FilePicker.platform.pickFiles();
                if (picked != null) {
                  String fileBytes = base64Encode(picked.files.first.bytes!);
                  String fileName = picked.files.first.name;
                  setState(() {
                    _image = "$fileBytes $fileName";
                  });                  
                }
              }, child: Text(_image == null ? "Выберите изображение" : _image!.split(" ")[1])),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _completedDate != null && _willExpiredDate != null && _image != null) {
                    final name = _nameController.text;
                    final costRetail = double.tryParse(_costRetailController.text)!;
                    final numberForWholesale = double.tryParse(_numberForWholesaleController.text);
                    final costWholesale = double.tryParse(_costWholesaleController.text);
                    final number = double.tryParse(_numberController.text)!;
                    final description = _descriptionController.text;
                    final numberForMonthSubscriptions = double.tryParse(_numberForMonthSubscriptionsController.text);
                    final item = Item(
                      name: name,
                      cost_retail: costRetail,
                      cost_wholesale: costWholesale,
                      number_wholesale: numberForWholesale,
                      number: number,
                      description: description,
                      date: _completedDate,
                      expire_date: _willExpiredDate,
                      category: changeCategory[_category] ?? "OT",
                      subscriptable: _isSubscribed,
                      number_for_month: numberForMonthSubscriptions,
                      doc: _image!,

                      
                    );
                    var token = await TokenApi.getAccessToken();
                    print(item.toJson());
                    var response = await ServerApi().post("/users/items/", token, item.toJson());
                    if (response.statusCode == 201 || response.statusCode == 200) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Произошла ошибка при добавлении товара"),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Добавить"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, String> changeCategory = {
  "Фрукты": "FR",
  "Овощи": "VE",
  "Другое": "OT",
};