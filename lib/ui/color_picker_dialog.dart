import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class ColorDialog extends StatefulWidget {
  const ColorDialog({Key? key}) : super(key: key);

  @override
  _ColorDialogState createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Color pickedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 530,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ColorPicker(
                        // Use the screenPickerColor as start color.
                        pickersEnabled: const <ColorPickerType, bool>{
                          ColorPickerType.both: true,
                          ColorPickerType.accent: false,
                          ColorPickerType.primary: false,
                          ColorPickerType.bw: false,
                          ColorPickerType.wheel: false,
                        },
                        color: pickedColor,
                        // Update the screenPickerColor using the callback.
                        onColorChanged: (Color color) {
                          pickedColor = color;
                          var hex = pickedColor.value;
                          print(color);
                          print(hex);
                          print(Color(hex));
                        },

                        width: 44,
                        height: 44,
                        borderRadius: 22,
                        heading: Text(
                          'Select color',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subheading: Text(
                          'Select color shade',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                                onTap: () {
                                  theme.setMainColor(pickedColor);
                                  setState(() {});
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const VideoDownloaderMain()));
                                },
                                child: Container(
                                    width: 70,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: theme.myAppMainColor,
                                        )),
                                    child: const Center(child: Text("Save")))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
