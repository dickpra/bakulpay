import 'package:bakulpay/src/router/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';



class PinSetupScreen extends StatefulWidget {
  @override
  _PinSetupScreenState createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final storage = new FlutterSecureStorage();

  void _savePin() async {
    String pin = _pinController.text;
    if (pin.isNotEmpty) {
      await storage.write(key: 'user_pin', value: pin);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => PinEntryScreen()),
      // );
      Get.to(PinEntryScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set PIN')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(labelText: 'Enter your PIN'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePin,
              child: Text('Save PIN'),
            ),
          ],
        ),
      ),
    );
  }
}

class PinEntryScreen extends StatefulWidget {
  @override
  _PinEntryScreenState createState() => _PinEntryScreenState();
}

class _PinEntryScreenState extends State<PinEntryScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  void _checkPin() async {
    String enteredPin = _pinController.text;
    String? storedPin = await _secureStorage.read(key: 'user_pin');

    if (enteredPin == storedPin) {
      Get.offAndToNamed(dashboard);
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Incorrect PIN'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter PIN'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(labelText: 'Enter your PIN'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPin,
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}


///
///
///


class PinGantiSetup extends StatefulWidget {
  const PinGantiSetup({super.key});

  @override
  State<PinGantiSetup> createState() => _PinGantiSetupState();
}

class _PinGantiSetupState extends State<PinGantiSetup> {
  final TextEditingController _pinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final storage = new FlutterSecureStorage();

  void _savePin() async {
    String pin = _pinController.text;
    if (pin.isNotEmpty) {
      await storage.write(key: 'user_pin', value: pin);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (context) => PinEntryScreen()),
      // );
      Get.offAndToNamed(dashboard);
      Get.snackbar(
        backgroundColor: Colors.blue,
        'Informasi', // Judul SnackBar
        'Pin Selesai diganti', // Isi SnackBar
        snackPosition: SnackPosition.BOTTOM, // Posisi SnackBar
        duration: Duration(milliseconds: 3000), // Durasi tampilan SnackBar
        onTap: (snack) {
          // Aksi yang diambil ketika SnackBar ditekan
          print('SnackBar ditekan');
        },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atur Pin Baru'),
        centerTitle: true,
        // automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(labelText: 'Enter your PIN'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _savePin,
              child: Text('Save PIN'),
            ),
          ],
        ),
      ),
    );
  }
}



class PinEntryGanti extends StatefulWidget {
  @override
  _PinEntryGantiState createState() => _PinEntryGantiState();
}

class _PinEntryGantiState extends State<PinEntryGanti> {
  final TextEditingController _pinController = TextEditingController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  void _checkPin() async {
    String enteredPin = _pinController.text;
    String? storedPin = await _secureStorage.read(key: 'user_pin');

    if (enteredPin == storedPin) {
      Get.off(PinGantiSetup());
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Incorrect PIN'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masukkan Pin Lama'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pinController,
              decoration: InputDecoration(labelText: 'Enter your PIN'),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkPin,
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}

