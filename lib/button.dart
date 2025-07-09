import 'package:flutter/material.dart';

// NO NEED ANYMORE
class CustomCircleButton extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool showtitle;
  final double? font_size;
  final Color color;
  final Color? splashColor;
  final IconData? icondata;
  final double? icon_size;
  final double? height;
  final double? width;
  final double? shape;
  final int? flex;
  final VoidCallback onClick;
  final ButtonCategory category;

  const CustomCircleButton({
    super.key,
    this.title1,
    this.title2,
    this.showtitle = true,
    this.font_size,
    required this.color,
    this.splashColor,
    this.icondata,
    this.icon_size,
    this.height,
    this.width,
    this.shape,
    this.flex,
    required this.onClick,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {

    String displaytitle = (showtitle? title1: title2) ?? title1 ?? "";
    return Expanded(
      flex: flex ?? 1,
      child: Container(
        padding: EdgeInsets.fromLTRB(7, 2, 7, 5),

        decoration: BoxDecoration(
          shape: shape == null ? BoxShape.circle: BoxShape.rectangle,
        ),

        child: SizedBox(
          height: height,
          child: FloatingActionButton(
            onPressed: () {
              onClick.call();
            },

            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(shape ?? 50),
                  ),
            backgroundColor: color,
            splashColor: splashColor ??Colors.grey[400],
            elevation: 10,
            child: icondata == null
                ? Center(
                    // If no icon data, show Text
                    child: Text(
                      displaytitle,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: font_size ?? 25,
                      ),
                    ),
                  )
                : Center(
                    // If icon data exists, show Icon
                    child: IconButton(
                      onPressed: (){
                        onClick.call();
                      },
                      icon: Icon(
                        icondata,
                        size: icon_size ?? 25, // icondata is not null here
                        color: Theme.of(context).primaryColor, // Style your icon
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

enum ButtonCategory{
  primary,
  secondary,
  special,
}
