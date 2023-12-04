import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_listapp/app/domain/models/task.dart';
import 'package:todo_listapp/app/presentation/widgets/toasts.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<Task> tasks = state.tasks;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: const Text("To Do Application"),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          body: Container(
            child: (tasks.isEmpty)
                ? const Center(
                    child: Text(
                      "Klik ➕ untuk menambahkan tasks",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          context
                              .read<HomeBloc>()
                              .add(RemoveTaskEvent(task: task));

                          if (Platform.isAndroid) {
                            showToast("Removed task");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: (index == 0) ? 50 : 5,
                            bottom: 5,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 75,
                          width: double.maxFinite,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<HomeBloc>()
                                      .add(MarkDoneEvent(index: index));
                                },
                                color: Colors.black,
                                icon: (task.isCompleted!)
                                    ? const Icon(Icons.check_box)
                                    : const Icon(Icons.check_box_outline_blank),
                              ),
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _resuableText(task.name,
                                        task.isCompleted ?? false, "title"),
                                    _resuableText(task.desc ?? '',
                                        task.isCompleted ?? false, "subtitle"),
                                    _resuableText(checkDate(task.completeBy),
                                        task.isCompleted ?? false, "time")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<HomeBloc>(context).add(
                  NavigateToAddTasksPage(context: context),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      "Tambah Task Baru",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String checkDate(DateTime time) {
    if (compare(time)) {
      return "Today";
    } else {
      return DateFormat('yMMMMd').format(time).toString();
    }
  }

  bool compare(DateTime time) {
    DateTime now = DateTime.now();
    return (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year);
  }

  Widget _resuableText(String text, bool isCompleted, String type) {
    return Text(
      (text.length > 25) ? '${text.substring(0, 25)}...' : text,
      overflow: TextOverflow.fade,
      style: TextStyle(
        color: Colors.black,
        fontWeight: (type == 'title') ? FontWeight.bold : FontWeight.normal,
        fontSize: (type == 'title') ? 18 : 12,
        decorationThickness: 2.0,
        decorationColor: Colors.black,
        decoration:
            (isCompleted) ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
