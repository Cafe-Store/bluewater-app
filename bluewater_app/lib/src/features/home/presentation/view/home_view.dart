import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../../../location/presentation/widget/location_appbar_widget.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              children: [
                const Flexible(
                  flex: 3,
                  child: LocationAppbarWidget(),
                ),
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () =>
              //TODO 네트워크 타서 데이터 갱신
              Future.delayed(const Duration(seconds: 3), () => true),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverAppBar(
                pinned: false,
                expandedHeight: 50.0,
                // flexibleSpace: FlexibleSpaceBar(
                //   title: Text('골라먹는 맛집'),
                // ),
                flexibleSpace: Center(
                  child: Text('골라먹는 맛집'),
                ),
              ),
              const SliverAppBar(
                pinned: true,
                expandedHeight: 50.0,
                // flexibleSpace: FlexibleSpaceBar(
                //   title: Text('골라먹는 맛집'),
                // ),
                flexibleSpace: Center(
                  child: Text('골라먹는 맛집'),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('Grid Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('List Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
