import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecomerceapp/models/Order.dart';
import 'package:ecomerceapp/models/OrderItem.dart';
import 'package:ecomerceapp/providers/BannerProvider.dart';
import 'package:ecomerceapp/providers/CategoriesProvider.dart';
import 'package:ecomerceapp/providers/LoadingProvider.dart';
import 'package:ecomerceapp/providers/ProductProvider.dart';
import 'package:ecomerceapp/providers/UserProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/Banner.dart';
import '../models/CartItem.dart';
import '../models/Category.dart';
import '../models/Product.dart';
import '../models/User.dart';
import '../providers/CartProvider.dart';
import '../providers/OrderProvider.dart';
import '../providers/WishListProvider.dart';

var dio = Dio(BaseOptions(baseUrl: "http://new.tiffanyflowers.ae/api"));
// http://new.tiffanyflowers.ae/api
getCategories(CategoriesProvider categoriesProvider) async {
  Response response = await dio.get('/categories',
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));

  List<Category> categories = [];

  response.data['data'].forEach((cat) {
    Category category = Category.fromJson(cat);

    categories.add(category);
  });

  categoriesProvider.categories = categories;
}

getProductsByCatgory(int catId, ProductProvider productProvider) async {
  Response response = await dio.get('/categories/${catId}');
  List<Product> products = [];
  response.data['data']['products'].forEach((pro) {
    Product product = Product.fromJson(pro);

    products.add(product);
  });

  productProvider.categoryproducts = products;
}

getProductById(int productId, ProductProvider productProvider) async {
  Response response = await dio.get('/products/${productId}');
  Product product = Product.fromJson(response.data['data']);

  productProvider.selectedProduct = product;
}

getBanners(BannerProvider bannerProvider) async {
  Response response = await dio.get('/banners');

  List<Banner> banners = [];
  response.data['data'].forEach((ban) {
    Banner banner = Banner.fromJson(ban);

    banners.add(banner);
  });

  bannerProvider.banners = banners;
}

getProducts(ProductProvider productProvider) async {
  Response response = await dio.get('/products');

  List<Product> products = [];
  response.data['data'].forEach((pro) {
    Product product = Product.fromJson(pro);
    products.add(product);
  });

  productProvider.products = products;
}

getProductByIds(List<int> productsId, WishListProvider wlProvider) async {
  List<Product> products = [];
  for (int i = 0; i < productsId.length; i++) {
    Response response = await dio.get('/products/${productsId[i]}');
    Product product = Product.fromJson(response.data['data']);

    products.add(product);
  }

  wlProvider.wishListProducts = products;
}

getProductByID(int productId) async {
  Response response = await dio.get('/products/${productId}');
  Product product = Product.fromJson(response.data['data']);

  return product.images[0];
}

getUserImage(String phone, UserProvider userProvider) async {
  Response response = await dio.get('/user/image/${phone}');
  
//   print(response);
//   print("xxxxx");
//  print(response.data);

if(response.data.runtimeType!=String){
  
List<dynamic> list = response.data['data'];
  if (list.isNotEmpty) {
    userProvider.userImage = response.data['data'][0];
  }
}
  
}

getOrders(int userId, OrderProvider orderProvider) async {
  Response response = await dio.get('/order/user/${userId}',
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));

// print(response.data);
  List<Order> orders = [];
  // print(response.data);
  response.data.forEach((order) {
    Order ord = Order.fromJson(order);
    orders.add(ord);
  });

  orderProvider.orders = orders;
}

getOrderItems(int orderId) async {
  Response response = await dio.get('/order/${orderId}',
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));

// print(response.data);
  List<OrderItem> items = [];

  response.data.forEach((order) {
    OrderItem ord = OrderItem.fromJson(order);
    items.add(ord);
  });

  return items;
}

register(String phone, String email, String firsName, String lastName) async {
  Response response = await dio.post('/register',
      data: {
        "phone_number": phone,
        "first_name": firsName,
        "last_name": lastName,
        "email": email
      },
      options: Options(
        // headers: {
        //   HttpHeaders.acceptHeader: "json/application/json",

        // },
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}

login(String phone) async {
  Response response = await dio.post('/signin',
      data: {
        "phone_number": phone,
      },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}

Future<Response> verifyPhone(
  String phone,
  int otp,
) async {
  Response response = await dio.post('/verify-phone-number',
      data: {"phone_number": phone, "otp": otp},
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}
Future<Response> sendOTPToNewNumber(
  String phone,
  String newPhone,
) async {
  Response response = await dio.post('/send-otp',
      data: {"phone_number": phone, "new_phone_number": newPhone},
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}

Future<Response> updateUserName(
 String phone,
  String firstName,
   String lastName,
   
) async {
  Response response = await dio.post('/user/update-name',
      data: {"phone": phone, "first_name": firstName,"last_name": lastName},
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}
Future<Response> updateUserEmail(
 String phone,
  String email,
  
) async {
  Response response = await dio.post('/user/update-email',
      data: {"phone": phone, "email": email },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}
Future<Response> updateUserPhone(
 String phone,
  String newPhone,
  
) async {
  Response response = await dio.post('/user/update-phone',
      data: {"phone": phone, "new_phone": newPhone },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}
Future<Response> uploadImage(
  String phone,
  File image,
) async {
  // print(image);
  // print(phone);
  // print(image.path);
  

  

  // String name = image.path.split('/').last;
  var data =  FormData.fromMap({
    "phone": phone,
    "image": await MultipartFile.fromFile(
      image.path,
      
    ),
  });

  Response response = await dio.post('/user/image-upload',
      data: data,
      // {"image": image,  "phone":phone,},
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}

Future<Response> deleteAccount(
  String phone,
) async {
  Response response = await dio.delete('/user/${phone}',
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  return response;
}

openWhatsap() async {
  var whatsapp = "+971557971021";
  String whatsappURLAndroid = "whatsapp://send?phone=$whatsapp&text=hello";
  String whatsappURLIOS = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  if (Platform.isIOS) {
    try {
      await launchUrl(Uri.parse(whatsappURLIOS));
    } catch (error) {
      print("~~~~~~~~~~");
      print(error.toString());
    }
  } else if (Platform.isAndroid) {
    try {
      await launchUrl(Uri.parse(whatsappURLAndroid));
    } catch (error) {
      print("~~~~~~~~~~");
      print(error.toString());
    }
  }
}

addOrder(
    User user,
    int subTotal,
    int itemCount,
    int shipping,
    String receiverAddr,
    String userPhoneNumber,
    String receiverPhoneNumber,
    String addtAddr,
    String selectedMsg,
    String phrase,
    List<dynamic> items,
    String city,
    LoadingProvider loadingProvider) async {
  Response response = await dio.post('/order',
      data: {
        "user_id": user.id,
        "sub_total": subTotal,
        "item_count": itemCount,
        "shipping": shipping,
        "receiver_addr": receiverAddr,
        "user_phone_number": userPhoneNumber,
        "receiver_phone_number": receiverPhoneNumber,
        "addt_addr": addtAddr,
        "selected_msg": selectedMsg,
        "phrase": phrase,
        "city": city,
        "order_img": items[0].image,
        "items": items.map((item) {
          return {
            "product_id": item.productId,
            "quantity": item.count,
            "price": item.price,
            "name": item.name,
            "item_img": item.image,
            "size_price": item.sizePrice,
            "size": item.size,
            "color": item.color,
          };
        }).toList()
      },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ));
  if (response.statusCode == 201) {
    Response response2 = await dio.post('/order/checkout',
        data: {
          "orderId": response.data['order_id'],
          "amount": subTotal + subTotal * 0.05 + shipping,
          "totals": {
            "subtotal": subTotal,
            "tax": 5,
            "shipping": shipping,
            "skipTotalsValidation": true
          },
          "items": items.map((item) {
            return {
              "name": item.name,
              "unitprice": item.price,
              "quantity": item.count,
              "linetotal": item.count * item.price
            };
          }).toList(),
          "customer": {
            "id": user.id,
            "firstName": user.firstName,
            "lastName": user.lastName,
            "email": user.email,
            "phone": user.phone,
          },
          "billingAddress": {
            "name": receiverAddr,
            "address1": receiverAddr,
            "address2": addtAddr,
            "city": city,
            "country": "AE"
          },
          "returnUrl": "http://new.tiffanyflowers.ae/api/order/redirectUrl",
          "branchId": 0,
          "allowedPaymentMethods": ["CARD"]
        },
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));

    return response2;
  }
}
