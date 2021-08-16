import 'package:flutter/material.dart';
import 'package:list_pagination/card.dart';
import 'package:list_pagination/data/data.dart';

class Animatedlists extends StatefulWidget {
  const Animatedlists({Key? key}) : super(key: key);

  @override
  _AnimatedlistsState createState() => _AnimatedlistsState();
}

class _AnimatedlistsState extends State<Animatedlists>
    with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  List<AnimationController> animationController = [];
  List items = [];
  var data = [];
  bool loading = false;
  bool loaded = false;
  Widget slide(context, index, begins, ends) {
    return SlideTransition(
        position: Tween<Offset>(begin: begins, end: ends)
            .animate(animationController[index]),
        child: items[index]);
  }

  getData(total, start) async {
    var data = await GetData().getDetails(total, start);
    if (data == null) {
      loaded = true;
      setState(() {
        loading = false;
      });
      return;
    }
    for (final value in data) {
      setState(() {
        loading = false;
        animationController.add(
            AnimationController(vsync: this, duration: Duration(seconds: 1)));
        items.add(Card1(datas: value));
      });
      await Future.delayed(Duration(milliseconds: 800));
      animationController[animationController.length - 1].forward();
      await Future.delayed(Duration(milliseconds: 700));
    }
  }

  @override
  void initState() {
    super.initState();
    getData(2, 0);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        if (!loaded) {
          setState(() {
            loading = true;
          });
          getData(items.length + 2, items.length);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    animationController.forEach((element) {
      element.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated List"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (items.length == 0) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return slide(
                            context, index, Offset(-1, 0), Offset(0, 0));
                      });
                }
              },
            ),
            if (loading) ...[
              Positioned(
                  left: MediaQuery.of(context).size.width / 2,
                  bottom: 0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
            ]
          ],
        ),
      ),
    );
  }
}
