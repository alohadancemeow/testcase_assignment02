import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(appTitle,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    )),
          ),
          backgroundColor: Colors.blue[500],
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final yourname = TextEditingController();
  final studentid = TextEditingController();
  final youremail = TextEditingController();

  @override
  void dispose() {
    yourname.dispose();
    studentid.dispose();
    youremail.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final nameRegex = RegExp(r"^[a-zA-Z]");
  final digitRegex = RegExp(r"^[0-9]*$");
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageSection(
                  image: 'images/tak.jpg',
                ),
                const ButtonSection(),
                TextFormField(
                  controller: yourname,
                  decoration: const InputDecoration(labelText: "Enter Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Correct Name';
                    } else if (!nameRegex.hasMatch(value)) {
                      return "Enter Correct Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: studentid,
                  decoration:
                      const InputDecoration(labelText: "Enter Phone Number"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Correct Phone Number';
                    } else if (value.length != 9 && value.length != 10) {
                      return "Enter Correct Phone Number";
                    } else if (!digitRegex.hasMatch(value)) {
                      return "Enter Correct Phone Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: youremail,
                  decoration: const InputDecoration(labelText: "Enter Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Correct Email Address';
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Enter Correct Email Address";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If true do
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                children: [
                                  Text(yourname.text),
                                  Text(studentid.text),
                                  Text(youremail.text),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    //tooltip: 'Show me the value!',
                    child: const Text('Submit Data')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                  size: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                child: Icon(
                  Icons.audiotrack,
                  color: Colors.green,
                  size: 30.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                child: Icon(
                  Icons.beach_access,
                  color: Colors.blue,
                  size: 36.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
