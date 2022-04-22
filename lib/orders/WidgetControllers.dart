import 'package:between/orders/DynamicItem.dart';

class WidgetControllers {
  int i = 0;
  List<Map<String, dynamic>> Items = [];
  late String InputNotEmpty;
  List<int> ItemID = [];


    List dataMaker(
      List<DynamicItem> DynamicList,
      List<String> data,
    ) {
      if (DynamicList.length >= 1) {
        DynamicList.forEach((widget) {
          InputNotEmpty = "";
          if (widget.controllerTitle.text.isNotEmpty &&
              widget.controllerQuan.text.isNotEmpty) {
            Items.add({
              "id": i,
              "item": [
                widget.controllerTitle.text,
                widget.controllerQuan.text,
                widget.controllerNote.text,
              ]
            });

            InputNotEmpty = "true";
          }

          ItemID.add(i);
          i++;

        });
      }

      return [InputNotEmpty, ItemID,Items];
    }
}
