import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_listapp/app/presentation/views/addtasks/bloc/addtasks_bloc.dart';
import 'package:todo_listapp/app/presentation/views/home/bloc/home_bloc.dart';
import 'package:todo_listapp/app/presentation/widgets/toasts.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<AddtasksBloc, AddtasksState>(
          builder: (context, state) {
            // DateTime now = DateTime.now();
            return Center(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.all(15),
                      child: const Text(
                        "Add a new Task ......",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Name: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 225,
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<AddtasksBloc>()
                                  .add(GetTaskNameEvent(name: value));
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter task name....",
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Description: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 225,
                          child: TextField(
                            onChanged: (value) {
                              context
                                  .read<AddtasksBloc>()
                                  .add(GetDescriptionEvent(desc: value));
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter description....",
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Complete By: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            // height: 100,
                            alignment: Alignment.center,
                            child: _dateWidget(
                              "${state.completeBy.day}",
                              DateFormat('MMM').format(state.completeBy),
                              "${state.completeBy.year}",
                              DateFormat('EEEE').format(state.completeBy),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          AddTaskEvent(
                            task: state.name,
                            completeBy: state.completeBy,
                            desc: state.desc,
                          ),
                        );
                        if (!(Platform.isWindows ||
                            Platform.isLinux ||
                            Platform.isMacOS)) {
                          showToast("Task added Successfully");
                        }
                        BlocProvider.of<AddtasksBloc>(context)
                            .add(NavigateToHomePageEvent(context));
                      },
                      child: Container(
                        width: 325,
                        height: 60,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Center(
                          child: Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _dateWidget(String day, String month, String year, String weekday) {
    return Row(
      children: [
        Container(
          width: 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(right: 6.0),
          decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.black,
              borderRadius: BorderRadius.circular(5)),
          child: Text(
            "$day-$month-$year $weekday",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
              context: context,
              builder: (context, child) {
                return DatePickerDialog(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
            ).then(
              (value) => {
                context.read<AddtasksBloc>().add(
                    GetCompleteByEvent(completeBy: value ?? DateTime.now()))
              },
            );
          },
          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
