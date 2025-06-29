import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final String? title;
  final double? font_size;
  final Color color;
  final Color? splashColor;
  final IconData? icondata;
  final double? icon_size;
  final double? height;
  final double? width;
  final double? shape;
  final int? flex;
  final VoidCallback? onClick;

  const CustomCircleButton({
    super.key,
    this.title,
    this.font_size,
    required this.color,
    this.splashColor,
    this.icondata,
    this.icon_size,
    this.height,
    this.width,
    this.shape,
    this.flex,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        margin: EdgeInsets.fromLTRB(2, 2, 1, 7),

        decoration: BoxDecoration(
          shape: shape == null ? BoxShape.circle: BoxShape.rectangle,
          // border: Border.all(color: this.color, width: 5),
        ),

        child: SizedBox(
          height: height ?? 74,
          width: width ?? 74,
          child: FloatingActionButton(
            onPressed: () {

              onClick?.call();
            },

            shape: shape == null
                ? CircleBorder()
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(shape ?? 10),
                  ),
            backgroundColor: color,
            splashColor: splashColor ??Colors.grey[400],
            elevation: 10,
            child: icondata == null
                ? Center(
                    // If no icon data, show Text
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: font_size == null ? 25 : font_size,
                      ),
                    ),
                  )
                : Center(
                    // If icon data exists, show Icon
                    child: IconButton(
                      onPressed: (){
                        onClick?.call();
                      },
                      icon: Icon(
                        icondata,
                        size: icon_size == null
                            ? 25
                            : icon_size, // icondata is not null here
                        color: Colors.white, // Style your icon
                      ),
                    ),
                  ),
          ),
        ),
      ),
      // ),
    );
  }
}
