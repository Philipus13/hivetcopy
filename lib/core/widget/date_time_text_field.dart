import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeTextField extends StatefulWidget {
  DateTimeTextField({
    Key? key,
    required this.dateController,
    required this.title,
  }) : super(key: key);
  final TextEditingController dateController;
  final String title;

  @override
  State<DateTimeTextField> createState() => _DateTimeTextFieldState();
}

class _DateTimeTextFieldState extends State<DateTimeTextField> {
  @override
  Widget build(BuildContext context) {
    String? dateServer;
    if (widget.dateController.text != '') {
      var dateSplit = widget.dateController.text.split('-');
      dateServer = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16)),
        ),
        GestureDetector(
          onTap: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              context: context,
              builder: (BuildContext builder) {
                return Container(
                  height: MediaQuery.of(context).copyWith().size.height / 3,
                  child: CupertinoDatePicker(
                    initialDateTime: dateServer != null
                        ? DateTime.parse(dateServer)
                        : DateTime.now(),
                    onDateTimeChanged: (DateTime newdate) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy', 'en_US').format(newdate);
                      ;
                      //  dateOfBirth =
                      //       DateFormat('yyyy-MM-dd', 'en_US').format(newdate);
                      //   ;
                      // datePickerBloc.add(DatePicker(formattedDate));
                      setState(() {
                        widget.dateController.text = formattedDate;
                      });
                    },
                    use24hFormat: false,

                    // maximumDate: new DateTime(2018, 12, 30),
                    minimumYear: 1900,
                    maximumYear: 2300,
                    // minuteInterval: 1,
                    mode: CupertinoDatePickerMode.date,
                  ),
                );
              }),
          child: AbsorbPointer(
            child: TextField(
              controller: widget.dateController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade200),
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
                // filled: true,
                // fillColor: Colors.white,
                hintStyle: new TextStyle(color: Colors.black.withOpacity(0.5)),
                hintText: 'dd-mm-yyyy',
                suffixIcon: Icon(
                  Icons.date_range,
                  color: Colors.amber,
                ),
                contentPadding: const EdgeInsets.only(
                    bottom: 0, top: 0, left: 15, right: 0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
