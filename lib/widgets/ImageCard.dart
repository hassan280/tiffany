import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class ImageCard extends StatelessWidget {
  final String image;
  final String? title;
  ImageCard({Key? key, required this.image, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: CachedNetworkImage(
        imageUrl: image,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                Container(

                  height: 9.h,
                  width: 9.h,
                  child: Center(
                    child: CircularProgressIndicator(
                      
                      color: Color(0xff73BFBD),
                      value: downloadProgress.progress),
                  ),
                ),
        errorWidget: (context, url, error) => Container(
          height: 9.h,
          width: 20.h,
          child: Icon(Icons.error)),
     )
            //  Image.network(
            //  loadingBuilder: (BuildContext context, Widget child,
            //       ImageChunkEvent? loadingProgress) {
            //     if (loadingProgress == null) return child;
            //     return Container(
            //       height: 8.h,
            //       width: 8.h,
            //       child: Center(
            //         child: CircularProgressIndicator(
            //           value: loadingProgress.expectedTotalBytes != null
            //               ? loadingProgress.cumulativeBytesLoaded /
            //                   loadingProgress.expectedTotalBytes!
            //               : null,
            //         ),
            //       ),
            //     );
            //   },
            //  image,
            //   fit: BoxFit.fill,
            // ),
           , shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // elevation: 1,
            margin: EdgeInsets.only(left: 8.sp, right: 8.sp, bottom: 3.sp),
          ),
        ),
        title != null
            ? Container(
                // color: Colors.red,

                margin: EdgeInsets.only(top: 0.3.h),
                child: Center(
                  child: Text(title!.toLowerCase(),
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: Color(0xffD8AA6B),
                      )),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
