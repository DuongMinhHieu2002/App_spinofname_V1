import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  String newItem = '';
  final TextEditingController _addEditingController = TextEditingController();
  final selected = BehaviorSubject<int>();
  String selectedItem = '';
  List<String> items = [];
  List<Color> myColorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  List<String> reSult = [];

  Color getRandomColor() {
    Random random = Random();
    final index = random.nextInt(myColorList.length);
    return myColorList[index];
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selected.stream.listen((int selectedIndex) {
      setState(() {
        selectedItem = items[selectedIndex];
      });
      print('Selected item: $selectedItem');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (items.length < 2) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                Text('Please add name to spin!'),
                SizedBox(
                  height: 90,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.sort();
                          });
                        },
                        child: Text("Sort a-z")),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            items.shuffle();
                          });
                        },
                        child: Text("Shuffle")),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Results"),
                            content: reSult.isEmpty
                                ? Text("No results found.")
                                : ListView.builder(
                              itemCount: reSult.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(reSult[index]),
                                );
                              },
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: Text('clear results'),
                                onPressed: () {
                                  setState(() {
                                    reSult = [];
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],

                          );
                        },
                      );
                    }, child: Text("Results"),
                    ),
                  ],
                ),
                Container(
                    width: 300, // Chiều dài của Container
                    height: 250.0, // Chiều cao của Container
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        TextEditingController controller =
                            TextEditingController(text: items[index]);

                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  onChanged: (newValue) {
                                    items[index] = newValue;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    items.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String ItemAdd = '';
                  return AlertDialog(
                    title: Text("Add Item"),
                    content: TextField(
                      onChanged: (value) {
                        ItemAdd = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ElevatedButton(
                        child: Text('Add'),
                        onPressed: () {
                          if (ItemAdd.isNotEmpty) {
                            setState(() {
                              items.add(ItemAdd);
                            });
                          }
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
            // Xử lý sự kiện khi FloatingActionButton được nhấn
          },
          child: Icon(Icons.add),
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      FortuneWheel(
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          for (int index = 0;
                              index < items.length;
                              index++) ...[
                            FortuneItem(
                              child: Text(
                                items[index].length > 6
                                    ? items[index].substring(0, 6) + "..."
                                    : items[index],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              style: FortuneItemStyle(
                                color: myColorList[index],
                                borderColor: Colors.white,
                              ),
                              onTap: () {
                                if (items.length >= 2) {
                                  setState(() {
                                    selected.add(
                                        Fortune.randomInt(0, items.length));
                                  });
                                } else {}
                              },
                            ),
                          ],
                        ],
                        onAnimationEnd: () {
                          reSult.add(selectedItem);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("We have a Winner!"),
                                  content: Text(
                                    selectedItem,
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: Text(
                                        'Cancel',
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text('Remove'),
                                      onPressed: () {
                                        setState(() {
                                          items.remove(selectedItem);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items.sort();
                        });
                      },
                      child: Text("Sort a-z")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          items.shuffle();
                        });
                      },
                      child: Text("Shuffle")),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Results"),
                          content: reSult.isEmpty
                              ? Text("No results found.")
                              : ListView.builder(
                            itemCount: reSult.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(reSult[index]),
                              );
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('clear results'),
                              onPressed: () {
                                setState(() {
                                  reSult = [];
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],

                        );
                      },
                    );
                  }, child: Text("Results"),
                  ),
                ],
              ),
              Container(
                  width: 300, // Chiều dài của Container
                  height: 250.0, // Chiều cao của Container
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      TextEditingController controller =
                          TextEditingController(text: items[index]);

                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller,
                                onChanged: (newValue) {
                                  items[index] = newValue;
                                },
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  items.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                String ItemAdd = '';
                return AlertDialog(
                  title: Text("Add Item"),
                  content: TextField(
                    onChanged: (value) {
                      ItemAdd = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text('Add'),
                      onPressed: () {
                        if (ItemAdd.isNotEmpty) {
                          setState(() {
                            items.add(ItemAdd);
                          });
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          // Xử lý sự kiện khi FloatingActionButton được nhấn
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
