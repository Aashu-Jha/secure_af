import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:secure_af/models/pass_card_list.dart';
import 'package:secure_af/screens/add_password.dart';
import 'package:secure_af/widgets/app_drawer.dart';
import 'package:secure_af/widgets/pass_card_tile.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    getInitData();

    super.initState();
  }

  Future<void> getInitData() async {
    await Provider.of<PassCardList>(context, listen: false).getCard();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPassword.id);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Password',
        elevation: 5.0,
      ),
      body: _isLoading == true ? Center(child: CircularProgressIndicator()) : CustomScrollView(slivers: [
        SliverAppBar(
        pinned: true,
        floating: true,
        title: Text('Secure_AF'),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {
            SystemNavigator.pop();
          })
        ],
        expandedHeight: MediaQuery.of(context).size.height / 3,
        flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/bg.jpg'),
                    ),
          collapseMode: CollapseMode.parallax,
        ),
      ),
      Consumer<PassCardList>(
        builder: (ctx, cardData, child) =>
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (ctx, i) {
              return PassCardTile(cardData.cardList[i], () {
                cardData.deleteCard(cardData.cardList[i].id);
                setState(() {
                });
              });
            },
            childCount: cardData.cardList.length,
          ),
        ),
      ),
    ]
      )
    );
  }
}
