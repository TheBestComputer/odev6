import 'package:flutter/material.dart';

// Uygulamanın giriş noktası
void main() {
  runApp(MyApp());
}

// Ana uygulama widget'ı
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Örneği', // Uygulamanın başlığı
      theme: ThemeData(
        primarySwatch: Colors.blue, // Uygulamanın tema rengi
      ),
      home: RegistrationForm(), // Ana ekran olarak Kayıt Formu widget'ını ayarla
    );
  }
}

// Kayıt formu widget'ı
class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState(); // State nesnesini oluştur
}

// Kayıt formunun durumu (state)
class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>(); // Form durumunu yönetmek için GlobalKey
  String? _name, _email, _password; // Kullanıcıdan alınacak veriler için değişkenler

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt Form'), // Uygulama çubuğundaki başlık
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Formun etrafında boşluk bırak
        child: Form(
          key: _formKey, // Formun durumunu yönetecek key
          child: Column(
            children: <Widget>[
              // Ad girme alanı
              TextFormField(
                decoration: InputDecoration(labelText: 'Adınız'), // Alanın etiket metni
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Adınızı Giriniz!'; // Hata mesajı
                  }
                  return null; // Hata yoksa null döner
                },
                onSaved: (value) {
                  _name = value; // Geçerli olduğunda değeri kaydet
                },
              ),
              // E-posta girme alanı
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'), // Alanın etiket metni
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen Email adresinizi giriniz!'; // Hata mesajı
                  }
                  // Geçerli bir e-posta adresi kontrolü
                  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                  RegExp regex = RegExp(pattern); // Düzenli ifade nesnesi
                  if (!regex.hasMatch(value)) {
                    return 'Geçerli bir email adresi giriniz'; // Hata mesajı
                  }
                  return null; // Hata yoksa null döner
                },
                onSaved: (value) {
                  _email = value; // Geçerli olduğunda değeri kaydet
                },
              ),
              // Şifre girme alanı
              TextFormField(
                decoration: InputDecoration(labelText: 'Şifre'), // Alanın etiket metni
                obscureText: true, // Şifrenin gizlenmesini sağlar
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır'; // Hata mesajı
                  }
                  return null; // Hata yoksa null döner
                },
                onSaved: (value) {
                  _password = value; // Geçerli olduğunda değeri kaydet
                },
              ),
              SizedBox(height: 20), // Düğme ile form alanları arasında boşluk
              // Formu gönderme butonu
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) { // Form geçerli mi?
                    // Form geçerliyse, verileri kaydet
                    _formKey.currentState!.save();
                    // SnackBar ile kullanıcıya geri bildirim
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('İşlem verileri: $_name, $_email')),
                    );
                  }
                },
                child: Text('Gönder'), // Buton metni
              ),
            ],
          ),
        ),
      ),
    );
  }
}
