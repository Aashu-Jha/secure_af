import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_af/models/pass_card.dart';
import 'package:secure_af/screens/pass_card_details.dart';

class PassCardTile extends StatelessWidget {
  final PassCard passCard;
  final Function onDelete;

  PassCardTile(this.passCard, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Padding(
        padding:
        const EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Container(
          color: Colors.red,
          alignment: AlignmentDirectional.centerStart,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                23, 0, 0, 0),
            child: Icon(Icons.delete_sweep,
                color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
      ),
      onDismissed: (direction)  {
        onDelete();
      },
      confirmDismiss: (direction) async {
        return await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Are you sure'),
              content: Text('Do you want to delete this password'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop(false);
                }, child: Text('No')),
                TextButton(onPressed: () {
                  Navigator.of(context).pop(true);
                }, child: Text('Yes')),
              ],
            ));
      },
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, PassCardDetails.id, arguments: passCard.id);
          },
          onLongPress: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(
                'TO Delete: Slide from left to right',
              ))
            );
          },
          leading: Icon(Icons.lock, color: Colors.blue, size: 35,),
          title: Text(passCard.title),
          subtitle: Text(passCard.username.length == 0 ? passCard.accountID : passCard.username),
          trailing: PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) =>
            [
              PopupMenuItem(value: 0, child: TextButton(
                child: Text('Copy Password', style: Theme.of(context).textTheme.bodyText1,),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: passCard.password));
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied!'), duration: Duration(seconds: 2),)
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
