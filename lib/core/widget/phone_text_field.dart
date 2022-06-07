import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

// widget to show normal textfield to choose
class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {Key? key,
      required this.textEditingController,
      required this.title,
      required this.hint,
      required this.textInputType,
      this.initialSelect,
      required this.countryCodeController})
      : super(key: key);
  final TextEditingController textEditingController, countryCodeController;
  final String title, hint;
  final TextInputType textInputType;
  final String? initialSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16)),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: CountryCodePicker(
                onChanged: (value) {
                  countryCodeController.text = value.dialCode!;
                },
                onInit: (value) {
                  String countryCode = value?.dialCode ?? '+62';
                  countryCodeController.text = countryCode;
                },
                showFlag: true,
                showFlagDialog: true,
                // showDropDownButton: true,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: initialSelect ?? '+62',
                favorite: ['+62', 'ID'],
                // optional. Shows only country name and flag
                showCountryOnly: true,
                flagWidth: 15,
                textStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 15),
                padding: const EdgeInsets.all(0),

                showDropDownButton: true,

                // optional. Shows only country name and flag when popup is closed.
                // showOnlyCountryWhenClosed: true,
                // optional. aligns the flag and the Text left
                // alignLeft: true,
              ),
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                style: TextStyle(color: Colors.black),
                keyboardType: textInputType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade200),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                  // filled: true,
                  // fillColor: Colors.blue,
                  hintStyle:
                      new TextStyle(color: Colors.black.withOpacity(0.5)),
                  hintText: hint,

                  contentPadding: const EdgeInsets.only(
                      bottom: 0, top: 0, left: 15, right: 0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
