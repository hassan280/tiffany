import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsAppBar extends StatelessWidget {
  String title;
  void Function() myfc;
   DetailsAppBar({
    required this.myfc,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 100.w,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          // Container(
          //   // color: Colors.blue,
          //   //  height: 15.h,
          //   width: 100.w,
          //   child: Image.asset(
          //     'assets/images/appbarback.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
          AppBar(
            title: InkWell(
              onTap: myfc,
              child: Text(
                
                title,
                style: TextStyle(color: Color(0xff73BFBD),fontSize:12.sp),
                
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xff73BFBD),
              ),
              onPressed: myfc,
            ),
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Color.fromARGB(0, 250, 249, 249),
            actions: [
              Badge(
                  position: BadgePosition.topEnd(top: 9, end: -17),
                  toAnimate: false,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  badgeContent: Text(
                    "12",
                    style: TextStyle(color: Colors.white, fontSize: 4.sp),
                  ),
                  
                      child: Container(
                        margin: EdgeInsets.only(bottom:20),
                        width:5.w,height:5.w,
                        child: IconButton(
                          icon:
                              Icon(Icons.notifications,size: 15.sp,color: Color(0xff73BFBD)),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ),
                   
                  
                ),
                SizedBox(width: 8.w,),
                
                Badge(
                  position: BadgePosition.topEnd(top: 7, end: -16),
                  toAnimate: false,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                  badgeContent: Text(
                    "12",
                    style: TextStyle(color: Colors.white, fontSize: 4.sp),
                  ),
                   child: Container(
                    margin: EdgeInsets.only(bottom:20),
                        width:5.w,height:5.w,
                        child: IconButton(
                          icon:
                              Icon(Icons.shopping_cart_outlined,size: 15.sp,color: Color(0xff73BFBD)),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ),
                ),
                SizedBox(width: 10.w,)
            ],
          )
        ],
      ),
    );
  }
}