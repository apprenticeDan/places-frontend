import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:places/data/api_service.dart';
import 'package:places/ui/widgets/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto para preservar el estado ingresado
  final _nombresController = TextEditingController();
  final _apellido1Controller = TextEditingController();
  final _apellido2Controller = TextEditingController();
  final _ciController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telFijoController = TextEditingController();
  final _celularController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Combobox values
  String _complemento = 'LP';
  final List<String> _complementos = ['LP', 'CB', 'TJ', 'PT', 'OR', 'SC', 'PN', 'CH'];

  String _genero = 'M';
  final List<String> _generos = ['M', 'F', 'Otro'];

  bool _isLoading = false;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nombresController.dispose();
    _apellido1Controller.dispose();
    _apellido2Controller.dispose();
    _ciController.dispose();
    _fechaNacController.dispose();
    _direccionController.dispose();
    _telFijoController.dispose();
    _celularController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Selección de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF574ACF),
              onPrimary: Colors.white,
              surface: Color(0xFF1E1E38),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF13132B),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _fechaNacController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final userData = {
      "nombres": _nombresController.text.trim(),
      "primer_apellido": _apellido1Controller.text.trim(),
      "segundo_apellido": _apellido2Controller.text.trim(),
      "ci": int.tryParse(_ciController.text.trim()) ?? 0,
      "complemento": _complemento,
      "fecha_nacimiento": _fechaNacController.text.trim(),
      "genero": _genero,
      "direccion": _direccionController.text.trim(),
      "telefono_fijo": int.tryParse(_telFijoController.text.trim()) ?? 0,
      "celular": int.tryParse(_celularController.text.trim()) ?? 0,
      "email": _emailController.text.trim(),
      "contrasena": _passwordController.text
    };

    final result = await ApiService.register(userData);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.greenAccent),
              SizedBox(width: 12),
              Text(
                'Registro exitoso. Ya puedes iniciar sesión.',
                style: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF1E1E38),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(20),
          duration: const Duration(seconds: 4),
        ),
      );
      Navigator.pop(context); // Volver al login
    } else {
      setState(() {
        _errorMessage = result.errorMessage;
      });
    }
  }

  // Expresiones regulares para validaciones
  final RegExp _nameRegex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70, fontFamily: 'Lato', fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.white70, size: 20),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent, fontFamily: 'Lato', fontSize: 11),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo Premium
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF13132B),
                  Color(0xFF2C3E50),
                  Color(0xFF4268D3),
                  Color(0xFF574ACF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          
          // Ornamentos de fondo para realzar el efecto glassmorphism
          Positioned(
            top: -50,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE91E63).withOpacity(0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00BCD4).withOpacity(0.15),
              ),
            ),
          ),

          // Formulario en Tarjeta Glassmorphic
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 32.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(24.0),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: -5,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Cabecera con botón de retroceso
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Registro de Usuario',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Lato',
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 48), // Balance para centrar el título
                                ],
                              ),
                              const SizedBox(height: 32),

                              // Mensaje de Error
                              if (_errorMessage != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.error_outline, color: Colors.redAccent),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          _errorMessage!,
                                          style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'Lato'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],

                              // --- SECCIÓN: DATOS PERSONALES ---
                              const Text('Datos Personales', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(color: Colors.white30),
                              const SizedBox(height: 12),

                              TextFormField(
                                controller: _nombresController,
                                style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                decoration: _buildInputDecoration('Nombres', Icons.person_outline),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) return 'Requerido';
                                  if (!_nameRegex.hasMatch(value)) return 'No se permiten números ni símbolos';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _apellido1Controller,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Primer Apellido', Icons.person_outline),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) return 'Requerido';
                                        if (!_nameRegex.hasMatch(value)) return 'No se permiten números';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _apellido2Controller,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Segundo Apellido', Icons.person_outline),
                                      validator: (value) {
                                        if (value != null && value.isNotEmpty && !_nameRegex.hasMatch(value)) {
                                          return 'No se permiten números';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _ciController,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Carnet Identidad', Icons.badge_outlined),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) return 'Requerido';
                                        if (int.tryParse(value) == null) return 'Solo números';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: _complemento,
                                      dropdownColor: const Color(0xFF2C3E50),
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Ext', Icons.location_on_outlined),
                                      items: _complementos.map((String ext) {
                                        return DropdownMenuItem<String>(
                                          value: ext,
                                          child: Text(ext),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue != null) _complemento = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      controller: _fechaNacController,
                                      readOnly: true,
                                      onTap: () => _selectDate(context),
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Fecha Nac.', Icons.calendar_today_outlined),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Requerido';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: _genero,
                                      dropdownColor: const Color(0xFF2C3E50),
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Género', Icons.people_outline),
                                      items: _generos.map((String gen) {
                                        return DropdownMenuItem<String>(
                                          value: gen,
                                          child: Text(gen),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue != null) _genero = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              TextFormField(
                                controller: _direccionController,
                                style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                decoration: _buildInputDecoration('Dirección', Icons.home_outlined),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) return 'Requerido';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _telFijoController,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Tel. Fijo (Opcional)', Icons.phone_outlined),
                                      validator: (value) {
                                        if (value != null && value.isNotEmpty && int.tryParse(value) == null) {
                                          return 'Solo números';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _celularController,
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Celular', Icons.smartphone_outlined),
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) return 'Requerido';
                                        if (int.tryParse(value) == null) return 'Solo números';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),

                              // --- SECCIÓN: AUTENTICACIÓN ---
                              const Text('Datos de Acceso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              const Divider(color: Colors.white30),
                              const SizedBox(height: 12),

                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                decoration: _buildInputDecoration('Correo Electrónico', Icons.email_outlined),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) return 'Requerido';
                                  if (!value.contains('@') || value.trim().length <= 5) return 'Formato de correo no válido';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Contraseña', Icons.lock_outline).copyWith(
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white70, size: 20),
                                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) return 'Requerido';
                                        if (value.length < 6) return 'Mín. 6 caracteres';
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: _obscureConfirmPassword,
                                      style: const TextStyle(color: Colors.white, fontFamily: 'Lato'),
                                      decoration: _buildInputDecoration('Confirmar', Icons.lock_outline).copyWith(
                                        suffixIcon: IconButton(
                                          icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.white70, size: 20),
                                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value != _passwordController.text) return 'No coinciden';
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),

                              // Botón de Registro
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                                    )
                                  : RoundedButton("Registrarse", onPressed: _handleRegister),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
