import 'package:flutter/material.dart';

// widget to show normal textfield to choose
class NormalTextField extends StatelessWidget {
  const NormalTextField(
      {Key? key,
      required this.textEditingController,
      required this.title,
      required this.hint,
      required this.textInputType,
      this.maxLines,
      this.prefixIcon})
      : super(key: key);
  final TextEditingController textEditingController;
  final String title, hint;
  final TextInputType textInputType;
  final int? maxLines;
  final String? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(title, style: Theme.of(context).textTheme.headline4
              // TextStyle(
              //     fontWeight: FontWeight.bold,
              //     color: Colors.black,
              //     fontSize: 16)

              ),
        ),
        TextField(
          controller: textEditingController,
          style: TextStyle(
            color: Colors.black,
          ),
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: prefixIcon != null
              ? InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade200),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),

                  prefixIcon: Padding(
                      padding: EdgeInsets.all(13),
                      child: Image.asset(
                        prefixIcon!,
                        height: 1,
                        width: 1,
                      )),
                  // filled: true,
                  // fillColor: Colors.blue,
                  hintStyle:
                      new TextStyle(color: Colors.black.withOpacity(0.5)),
                  hintText: hint,

                  contentPadding: const EdgeInsets.only(
                      bottom: 0, top: 20, left: 15, right: 15),
                )
              : InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.shade200),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                  hintStyle:
                      new TextStyle(color: Colors.black.withOpacity(0.5)),
                  hintText: hint,
                  contentPadding: const EdgeInsets.only(
                      bottom: 0, top: 20, left: 15, right: 15),
                ),
        ),
      ],
    );
  }
}
