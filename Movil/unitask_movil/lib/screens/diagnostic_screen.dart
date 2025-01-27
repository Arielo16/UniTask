// lib/screens/diagnostic_screen.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';

class DiagnosticScreen extends StatefulWidget {
  final Report report;

  DiagnosticScreen({required this.report});

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diagnóstico'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              CheckboxListTile(
                title: Text('¿Terminado?'),
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Lógica para enviar el diagnóstico
                  }
                },
                child: Text('Enviar Diagnóstico'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}