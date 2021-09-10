import 'package:flutter/material.dart';

class DrawerTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          widget.controller.jumpToPage(widget.page);

        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 32,
                color: widget.page == widget.controller.page!.round()?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(width: 32),
              Text(widget.text,
              style: TextStyle(
                fontSize: 16,
                color: widget.page == widget.controller.page!.round()?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              )
            ],
          ),
        ),
      ),
    );

  }
}
