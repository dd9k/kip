import 'package:check_in_pro_for_visitor/src/widgetUtilities/radioGroupButton/RadioButtonTextPosition.dart';
import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T) onChanged;
  final RadioButtonTextPosition textPosition;

  const RadioButton({
    @required this.description,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
    this.textPosition = RadioButtonTextPosition.right,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          if (this.onChanged != null) {
            this.onChanged(value);
          }
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment:
                this.textPosition == RadioButtonTextPosition.right ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: <Widget>[
              this.textPosition == RadioButtonTextPosition.left
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        this.description,
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Container(),
              Transform.scale(
                scale: 1.5,
                child: Radio<T>(
                  groupValue: groupValue,
                  onChanged: this.onChanged,
                  value: this.value,
                ),
              ),
              this.textPosition == RadioButtonTextPosition.right
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        this.description,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18, height: 1),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
}
