import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/rendering.dart';

class FilterableMultiSelect<T> extends StatefulWidget {
  const FilterableMultiSelect({
    super.key,
    required this.items,
    required this.onItemChanged,
  });

  final List<({T data, bool selected})> items;
  final Function(T data, bool selected) onItemChanged;

  @override
  State<FilterableMultiSelect<T>> createState() {
    return _FilterableMultiSelectState<T>();
  }
}

class _FilterableMultiSelectState<T> extends State<FilterableMultiSelect<T>> {
  var isOpen = false;
  var controller = OverlayPortalController();
  final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TapRegion(
      onTapOutside: (tap) {
        //controller.hide();
      },
      child: OverlayPortal(
        controller: controller,
        overlayChildBuilder: (context) {
          return Positioned(
            width: layerLink.leaderSize?.width,
            height: 100,
            child: CompositedTransformFollower(
              link: layerLink,
              targetAnchor: Alignment.bottomLeft,
              child: Container(
                color: Colors.blue,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final item in widget.items)
                        CheckboxListTile(
                          value: item.selected,
                          title: Text(item.toString()),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 26,
                            vertical: 0,
                          ),
                          onChanged: (value) {
                            widget.onItemChanged(item.data, value ?? false);
                          },
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: GestureDetector(
          onTap: () {
            controller.toggle();
          },
          child: CompositedTransformTarget(
            link: layerLink,
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(color: Colors.blue),
              width: double.infinity,
              child: Text("data"),
            ),
          ),
        ),
      ),
    );
  }
}
