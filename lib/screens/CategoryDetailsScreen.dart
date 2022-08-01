import 'package:ecomerceapp/widgets/CategoryAppBar.dart';
import 'package:ecomerceapp/widgets/CategoryDetailCard.dart';
import 'package:ecomerceapp/widgets/ImageCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';

import '../models/Category.dart';

import '../widgets/CategoryDetailCardTwo.dart';
import 'DetailsScreen.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final List<Category> categories;
  String? title;
  CategoryDetailsScreen({Key? key, this.title, required this.categories})
      : super(key: key);

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  Color active_color = Color(0xff73BFBD);
  Color in_active_color = Color(0xffB9B9B9);
  bool active = true;
  void setActive() {
    setState(() {
      active = !active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        height: 6.h,
        width: 6.h,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {},
          child: Icon(
            Icons.whatsapp,
            size: 25.sp,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CategoryAppBar(
            myfc: (){
              Navigator.of(context).pop();
            },
            title: widget.title.toString(),
          ),
          // SizedBox(
          //   height: 2.h,
          // ),
          Flexible(
            child: active
                ? StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.sp,
                    mainAxisSpacing: 15.sp,
                    itemCount: widget.categories.length + 1,
                    itemBuilder: (BuildContext context, int index) => index == 0
                        ? Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    active = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.grid_view_outlined,
                                  size: 14.sp,
                                  color:
                                      active ? active_color : in_active_color,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    active = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.list,
                                  size: 22.sp,
                                  color:
                                      !active ? active_color : in_active_color,
                                )),
                          ])
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      (DetailsScreen()),
                                ),
                              );
                            },
                            child: CategoryDetailCard(
                              image: widget.categories[index - 1].image,
                              // title: widget.categories[index-1].title
                              // .toString()
                            ),
                          ),
                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        index == 0 ? 2 : 1, index == 0 ? 0.21 : 1.45),
                  )
                : StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.sp,
                    mainAxisSpacing: 15.sp,
                    itemCount: widget.categories.length + 1,
                    itemBuilder: (BuildContext context, int index) => index == 0
                        ? Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    active = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.grid_view_outlined,
                                  size: 14.sp,
                                  color:
                                      active ? active_color : in_active_color,
                                )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    active = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.list,
                                  size: 22.sp,
                                  color:
                                      !active ? active_color : in_active_color,
                                )),
                          ])
                        : InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      (DetailsScreen()),
                                ),
                              );
                            },
                            child: CategoryDetailCardTwo(
                              image: widget.categories[index - 1].image,
                            ),
                          ),
                    staggeredTileBuilder: (int index) => StaggeredTile.count(
                        index == 0 ? 2 : 2, index == 0 ? 0.21 : 0.8),
                  ),
          ),
        ],
      ),
    );
  }
}