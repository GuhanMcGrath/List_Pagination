import 'package:flutter/material.dart';
import 'package:list_pagination/card.dart';
import 'package:list_pagination/data/data.dart';
import 'package:list_pagination/data/datamodel.dart';

class WheelScroll extends StatefulWidget {
  const WheelScroll({Key? key}) : super(key: key);

  @override
  _WheelScrollState createState() => _WheelScrollState();
}

class _WheelScrollState extends State<WheelScroll> {
  final ScrollController _scrollController = ScrollController();
  bool loading = false;
  bool loaded = false;
  List<DataModel> items = [];
  getData(total, start) async {
    var data = await GetData().getDetails(total, start);
    if (data == null) {
      loaded = true;
      setState(() {
        loading = false;
      });
      return;
    }
    items.addAll(data);
    setState(() {
      loading = false;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wheel Scroll List"),
      ),
      body: Stack(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints boxConstraints) {
            if (items.length == 0) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListWheelScrollView(
                itemExtent: 410,
                physics: ClampingScrollPhysics(),
                controller: _scrollController,
                children: List.generate(
                    items.length, (index) => Card1(datas: items[index])),
              );
            }
          }),
          if (loading) ...[
            Positioned(
                left: MediaQuery.of(context).size.width / 2,
                bottom: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ))
          ]
        ],
      ),
    );
  }
}
