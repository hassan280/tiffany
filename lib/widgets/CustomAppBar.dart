import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../providers/CartProvider.dart';
import '../providers/IndexProvider.dart';
import '../providers/WishListProvider.dart';
import '../screens/HomeScreen.dart';
import '../screens/WishListScreen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);
    WishListProvider wlProvider = Provider.of<WishListProvider>(context);
    return Container(
      height: 18.h,
      width: 100.w,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            height: 20.h,
            width: 100.w,
            child: Image.asset(
              'assets/images/appbarback.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top:2.sp,
            
            child: Padding(
              padding: EdgeInsets.only(top: 1.h, left: 5.w),
              child: Row(
                children: [
                  Badge(
                    showBadge: cartProvider.count > 0 ? true : false,
                    position: BadgePosition.topEnd(top: -3, end: -15),
                    toAnimate: false,
                    elevation: 0,
                    shape: BadgeShape.circle,
                    badgeColor: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    badgeContent: Padding(
                      padding: const EdgeInsets.all(0.5),
                      child: Text(
                        cartProvider.count.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                      ),
                    ),
                    child: Container(
                      height: 8.w,
                      width: 8.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xff73BFBD)),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart_outlined, size: 4.w),
                          onPressed: () {
                            cartScreen.currentState!
                                .popUntil((route) => route.isFirst);
                            indexProvider.setCurrentIndex(4);
                          },
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.w, right: 7.w),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff73BFBD),
                      radius: 4.w,
                      child: IconButton(
                        icon:
                            Icon(Icons.search_sharp, size: 4.w, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 4.h, top: 2.h),
                      height: 20.h,
                      width: 35.w,
                      child: Image.asset("assets/images/Logo.png")),
                  SizedBox(
                    width: 15.w,
                  ),
                  InkWell(
                    onTap: () {
                      mainScreen.currentState!.push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => (WishListScreen()),
                        ),
                      );
                    },
                    child: Badge(
                      position: BadgePosition.topEnd(top: -8, end: -16),
                      toAnimate: false,
                      showBadge: wlProvider.count > 0 ? true : false,
                      shape: BadgeShape.circle,
                      badgeColor: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Text(
                          wlProvider.count.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 8.sp),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width: 5.w,
                        height: 5.w,
                        child: Icon(
                          Icons.favorite, size: 7.w, color: Color(0xff73BFBD),
                          // onPressed: () {
                          // print("tap");
                          //        mainScreen.currentState!.push(
          
                          //     MaterialPageRoute(
                          //       builder: (BuildContext context) =>
                          //           (WishListScreen(
          
                          //       )),
                          //     ),
                          // );
          
                          // }
                          // ,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(width:7.w),
                  // Badge(
                  //   position: BadgePosition.topEnd(top: 5, end: -18),
                  //   toAnimate: false,
                  //   shape: BadgeShape.circle,
                  //   badgeColor: Colors.red,
                  //   borderRadius: BorderRadius.circular(8),
                  //   badgeContent: Text(
                  //     "0",
                  //     style: TextStyle(color: Colors.white, fontSize: 4.sp),
                  //   ),
                  //    child: Container(
                  //     margin: EdgeInsets.only(bottom:20),
                  //         width:5.w,height:5.w,
                  //         child: IconButton(
                  //           icon:
                  //               Icon(Icons.notifications,size: 5.5.w,color: Color(0xff73BFBD)),
                  //           onPressed: () {},
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
