// lib/screens/diagnostic_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Reports.dart';
import 'home_screen.dart';

class DiagnosticScreen extends StatefulWidget {
  final Report report;

  const DiagnosticScreen({super.key, required this.report});

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isCompleted = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submitDiagnosis() async {
    if (_formKey.currentState!.validate()) {
      final description = _descriptionController.text;
      final completed = _isCompleted;
      final folio = widget.report.folio;
      final images = ["imagen2.jpg"];

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8000/api/diagnostics/post'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'folio': folio,
            'description': description,
            'images': images,
            'completed': completed,
          }),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Diagnóstico enviado exitosamente')),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al enviar el diagnóstico')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de red: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Diagnóstico'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Folio: ${widget.report.folio}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      focusNode: _descriptionFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una descripción';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text('¿Terminado?'),
                      value: _isCompleted,
                      onChanged: (value) {
                        setState(() {
                          _isCompleted = value!;
                        });
                      },
                      activeColor: Colors.green,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitDiagnosis,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Aquí se usa backgroundColor
                          padding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text('Enviar Diagnóstico'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
