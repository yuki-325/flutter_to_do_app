import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/ui/theme.dart';
import 'package:flutter_to_do_app/ui/widget/input_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final DateTime _nowDateTime = DateTime.now();
  final dateFormat = DateFormat('yyyy年M月dd日');
  final timeFormat = DateFormat('HH:mm');
  late DateTime _selectedDate = DateTime.now();
  late String _startTime;
  late String _endTime;

  @override
  void initState() {
    super.initState();

    // 初期値を設定
    _selectedDate = _nowDateTime;
    _startTime = timeFormat.format(_nowDateTime);
    _endTime = timeFormat.format(_nowDateTime.add(const Duration(hours: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              const InputField(
                title: 'Title',
                hint: 'Enter your title',
              ),
              const InputField(
                title: 'Note',
                hint: 'Enter your note',
              ),
              InputField(
                title: 'Date',
                hint: dateFormat.format(_selectedDate),
                widget: IconButton(
                  onPressed: _getDateFromUser,
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Date',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Date',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: false),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        // TODO ここ表示するか迷い中 表示するならAuthも作らないと・・・
        CircleAvatar(
          // backgroundImage: AssetImage('images/profile.png'),
          backgroundColor: Colors.amberAccent,
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2122),
    );

    if (pickerDate != null) {
      setState(() => _selectedDate = pickerDate);
      print(_selectedDate);
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String? formatedTime = pickedTime?.format(context);
    if (pickedTime == null) {
      print('Time canceld');
      return;
    }

    if (isStartTime) {
      setState(() => _startTime = formatedTime!);
    } else if (!isStartTime) {
      setState(() => _endTime = formatedTime!);
    }
  }

  Future<TimeOfDay?> _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 10),
    );
  }
}
