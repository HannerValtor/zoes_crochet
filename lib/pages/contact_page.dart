import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_header.dart';
import '../widgets/section_title.dart';
import '../widgets/app_footer.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  // Email de destino (configurable)
  static const String destinationEmail = 'zoevpcrochet@gmail.com';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Método para enviar mensaje vía mailto
  // NOTA: Este método puede reemplazarse fácilmente con Firebase en el futuro
  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      // Construir el cuerpo del mensaje
      final String body = '''
Nombre: ${_nameController.text}
Email: ${_emailController.text}

Mensaje:
${_messageController.text}
''';

      // Construir la URL mailto
      final Uri mailtoUri = Uri(
        scheme: 'mailto',
        path: destinationEmail,
        query: _encodeQueryParameters({
          'subject': 'Mensaje desde Zoe\'s Crochet',
          'body': body,
        }),
      );

      // Intentar abrir el cliente de correo
      try {
        if (await canLaunchUrl(mailtoUri)) {
          await launchUrl(mailtoUri, mode: LaunchMode.externalApplication);
          
          // Mostrar mensaje de éxito
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Abriendo cliente de correo...',
                  style: TextStyle(letterSpacing: 1),
                ),
                backgroundColor: const Color(0xFF8B7355),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );

            // Limpiar campos después de un breve delay
            Future.delayed(const Duration(seconds: 1), () {
              _nameController.clear();
              _emailController.clear();
              _messageController.clear();
            });
          }
        } else {
          throw 'No se puede abrir el cliente de correo';
        }
      } catch (e) {
        // Mostrar mensaje de error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: No se pudo abrir el cliente de correo',
                style: const TextStyle(letterSpacing: 1),
              ),
              backgroundColor: const Color(0xFFD4756B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      }
    }
  }

  // Método auxiliar para codificar parámetros de query
  String _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: const AppHeader(),
      drawer: isWeb ? null : const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                padding: EdgeInsets.all(isWeb ? 60 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    const SectionTitle(
                      title: 'Contáctanos',
                      isLarge: true,
                    ),
                    const SizedBox(height: 20),
                    
                    // Texto introductorio
                    Text(
                      '¿Tienes alguna pregunta o deseas un bolso personalizado?\nEscríbenos y te responderemos lo antes posible.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isWeb ? 18 : 16,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFFA89080),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 50),
                    
                    // Formulario
                    _buildContactForm(isWeb),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            const AppFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm(bool isWeb) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(isWeb ? 40 : 24),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EDE4),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Envíanos un mensaje',
              style: TextStyle(
                fontSize: isWeb ? 24 : 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.5,
                color: const Color(0xFF8B7355),
              ),
            ),
            const SizedBox(height: 30),
            
            // Campo Nombre
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: const TextStyle(
                  color: Color(0xFFA89080),
                  fontWeight: FontWeight.w300,
                ),
                filled: true,
                fillColor: const Color(0xFFFAF8F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B7355),
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Campo Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Color(0xFFA89080),
                  fontWeight: FontWeight.w300,
                ),
                filled: true,
                fillColor: const Color(0xFFFAF8F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B7355),
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa tu email';
                }
                if (!value.contains('@')) {
                  return 'Por favor ingresa un email válido';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Campo Mensaje
            TextFormField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Mensaje',
                labelStyle: const TextStyle(
                  color: Color(0xFFA89080),
                  fontWeight: FontWeight.w300,
                ),
                filled: true,
                fillColor: const Color(0xFFFAF8F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF8B7355),
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFFD4756B),
                    width: 1,
                  ),
                ),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor ingresa tu mensaje';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 30),
            
            // Botón Enviar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B7355),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Enviar mensaje',
                  style: TextStyle(
                    fontSize: isWeb ? 18 : 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
