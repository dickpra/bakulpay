import 'dart:ffi';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:bakulpay/src/model/rate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class topupButton extends StatelessWidget {
  final String ImagePath;
  final String jdulText;
  final VoidCallback onClick;

  topupButton(this.ImagePath, this.jdulText, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Warna bayangan
                  spreadRadius: 2, // Seberapa luas bayangan menyebar
                  blurRadius: 5, // Seberapa kabur bayangan
                  offset: Offset(0,
                      3), // Perpindahan bayangan secara horizontal dan vertikal
                ),
              ],
            ),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  // Warna latar belakang lingkaran
                  child: Image(
                    image: AssetImage(ImagePath),
                  ),
                ),
                SizedBox(height: 1), // Jarak antara ikon dan teks
              ],
            ),
          ),
          Text(
            jdulText,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight:
                    FontWeight.bold), // Sesuaikan ukuran teks sesuai keinginan
          ),
        ],
      ),
    );
  }

  //bekup

//InkWell(
//                       onTap: () {
//                         // TODO: Implement PayPal payment logic
//                       },
//                       child: Column(
//                         // mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CircleAvatar(
//                             radius: 40,
//                             backgroundColor: Colors.white, // Warna latar belakang lingkaran
//                             child: Image(
//                               image: AssetImage('assets/images/payp.png'),
//                             ),
//                           ),
//                           SizedBox(height: 5.0), // Jarak antara ikon dan teks
//                           Text(
//                             'PayPal',
//                             style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold), // Sesuaikan ukuran teks sesuai keinginan
//                           ),
//                         ],
//                       ),
//                     ),
}

class textForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType hurufAngka;
  final List<TextInputFormatter> formattext;
  final String warningText;
  final String emailWarning;
  final bool hintPass;

  textForm(this.controller, this.labelText, this.formattext, this.hurufAngka,
      this.warningText, this.emailWarning, this.hintPass);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        // labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
            // color: Colors.blue,
            ),
      ),
      keyboardType: hurufAngka,
      inputFormatters: formattext,
      obscureText: hintPass,
      validator: (value) {
        if (value!.isEmpty) {
          return warningText;
        } else if (!value.contains(emailWarning)) {
          return 'Masukkan email yang benar!!';
        }
        return null;
      },
    );
  }
}

class textForm2 extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType hurufAngka;
  final List<TextInputFormatter> formattext;
  final String warningText;
  final String emailWarning;
  final bool hintPass;

  textForm2(this.controller, this.labelText, this.formattext, this.hurufAngka,
      this.warningText, this.emailWarning, this.hintPass);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        // labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
            // color: Colors.blue,
            ),
      ),
      keyboardType: hurufAngka,
      inputFormatters: formattext,
      obscureText: hintPass,
      validator: (value) {
        if (value!.isEmpty) {
          return warningText;
        } else if (!value.contains(emailWarning)) {
          return 'Masukkan email yang benar!!';
        }
        return null;
      },
    );
  }
}

Widget TextRate(RxList<rate_model> data, index) {
  final currencyFormat = NumberFormat.decimalPattern('en_US');
  final myInt = int.parse(data[index].price);
  return Text(style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,),'${data[index].price}');
}
