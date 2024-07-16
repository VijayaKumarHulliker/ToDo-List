// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';
// //import '../viewmodels/task_viewmodel.dart';
// import 'task_detail_screen.dart';

// class TaskListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ToDo List')),
//       body: Consumer<TaskViewModel>(
//         builder: (context, taskViewModel, child) {
//           return ListView.builder(
//             itemCount: taskViewModel.tasks.length,
//             itemBuilder: (context, index) {
//               var task = taskViewModel.tasks[index];
//               return ListTile(
//                 title: Text(task.title),
//                 subtitle: Text(task.description),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TaskDetailScreen(task: task),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TaskDetailScreen(),
//           ),
//         ),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/models/task.dart';
//import 'package:todo_list_app/viewmodels/task_viewmodel.dart';
//import 'package:todo_list_app/views/task_detail_screen.dart';
import 'package:todo_list_app/services/notification_service.dart';
import 'package:todo_list_app/views/task_detail.dart';
import 'package:todo_list_app/viewsmodels/task_viewmodel.dart';

// class TaskListScreen extends StatelessWidget {
//   final NotificationService notificationService;

//   TaskListScreen({required this.notificationService});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ToDo List')),
//       body: Consumer<TaskViewModel>(
//         builder: (context, taskViewModel, child) {
//           return ListView.builder(
//             itemCount: taskViewModel.tasks.length,
//             itemBuilder: (context, index) {
//               var task = taskViewModel.tasks[index];
//               return ListTile(
//                 title: Text(task.title),
//                 subtitle: Text(task.description),
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => TaskDetailScreen(task: task, notificationService: notificationService),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TaskDetailScreen(notificationService: notificationService),
//           ),
//         ),
//         child: Icon(Icons.add),
//       ),
//     );
//   }  
// }



class TaskListScreen extends StatefulWidget {
  final NotificationService notificationService;

  TaskListScreen({required this.notificationService});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('ToDo-List',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_task,color: Colors.black,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                    notificationService: widget.notificationService,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Consumer<TaskViewModel>(
              builder: (context, taskViewModel, child) {
                List<Task> tasks = taskViewModel.searchTasks(_searchQuery);
                return 
                ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children:[ 
                          
                          ListTile(
                         
                          tileColor: Colors.blue[100],
                          title: Text(task.title),
                         subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description: ${task.description}'),
                                Text('Priority: ${task.priority}'),
                              ],
                            ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              taskViewModel.deleteTask(task.id);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskDetailScreen(
                                  task: task,
                                  notificationService: widget.notificationService,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10,)
                        ]
                      ),
                    );
                    
                  },
                );
              },
            ),
          ),
           
         
        ],
      ),
    );
  }
}