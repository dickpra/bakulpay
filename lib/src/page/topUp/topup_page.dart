import 'package:bakulpay/src/page/topUp/pembayaran.dart';
import 'package:bakulpay/src/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// class topupPaypal extends StatefulWidget {
//   @override
//   _topupPaypalState createState() => _topupPaypalState();
// }

class TopupPaypal extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();


  TextEditingController emailController = TextEditingController();
  TextEditingController dollarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Top up Paypal'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(),
                  //   child:
                  //   const Align(
                  //     child: Text(
                  //       'Top Up Paypal',
                  //       style: TextStyle(
                  //           fontSize: 25,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 150,
                      width: MediaQuery.sizeOf(context).width,
                      child: Image.asset('assets/images/paypal.png')
                  ),
                  SizedBox(height: 30),
                  textForm(emailController,"Masukkan E-Mail Paypal",[FilteringTextInputFormatter.deny(RegExp(' '))],TextInputType.text, 'Masukkan email','@',false),
                  SizedBox(height: 16),
                  textForm(dollarController,"Masukkan Jumlah \$",[FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],TextInputType.number, 'Masukkan jumlah','',false),
                  SizedBox(height: 50),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CupertinoColors.activeBlue, // warna latar belakang
                        ),
                        onPressed: () {

                          _confirmWithdraw(context);
                        },
                        child: Text(style: TextStyle(
                            color: Colors.white
                        ),'Selanjutnya'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmWithdraw(context) {
    if (_formKey.currentState!.validate()) {
      // Do something with the confirmed values
      print('Jumlah: ${dollarController.text}');
      print('Nomor Rekening: ${dollarController.text}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pembayaranPaypal(
            email: emailController.text,
            amount: int.parse(dollarController.text),
          ),
        ),
      );
    }
  }
}
