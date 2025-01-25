import 'package:flutter/material.dart';
import 'package:musicapp/componets/custom_button.dart';

class SingerSelect extends StatefulWidget {
  const SingerSelect({
    super.key,
  });

  @override
  State<SingerSelect> createState() => _SingerSelectState();
}

class _SingerSelectState extends State<SingerSelect> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  String singerUrl = '';
  String singerName = '';
  static const double radiusValue = 100;

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 197, 46, 129),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Spacer(),
              singerUrl != ""
                  ? CircleAvatar(
                      radius: radiusValue,
                      backgroundImage: NetworkImage(singerUrl),
                    )
                  : const CircleAvatar(
                      radius: radiusValue,
                      backgroundImage: AssetImage("assets/icon.png"),
                    ),
              const SizedBox(
                height: 20,
              ),
              singerName != ""
                  ? Text(
                      singerName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  : const Text(
                      "Singer Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
              const Spacer(),
              TextField(
                autofocus: true,
                controller: urlController,
                decoration: const InputDecoration(
                  hintText: 'Enter singer picture URL',
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                onSubmitted: (String value) {
                  setState(() {
                    singerUrl = urlController.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter singer name',
                  hintStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                controller: nameController,
                onSubmitted: (String value) {
                  setState(() {
                    singerName = nameController.text;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  name: "Submit",
                  function: () {
                    Navigator.pop(context);
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
