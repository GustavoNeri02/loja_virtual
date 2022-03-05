import 'package:flutter/material.dart';

class ConfigListTile extends StatelessWidget {
  IconData icon;
  String title;
  VoidCallback? _function;

  ConfigListTile(this.icon, this.title, this._function);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      highlightColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTileTheme(
            contentPadding: EdgeInsets.zero,
            child: ListTile(
              leading: CircleAvatar(
                  child: Icon(icon, color: Theme.of(context).primaryColor,),
                  backgroundColor:
                  Colors.grey.withOpacity(0.08)),
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600,),
              ),
            ),
          ),
        ],
      ),
      onTap: _function,
    );
  }
}
