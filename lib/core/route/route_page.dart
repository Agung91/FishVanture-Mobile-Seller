import 'package:seller/modules/chat/screen/page_chat.dart';
import 'package:seller/modules/chat/screen/page_list_chat.dart';
import 'package:seller/modules/home/screen/page_home.dart';
import 'package:seller/modules/login/screen/page_login.dart';
import 'package:seller/modules/order/screen/page_order.dart';
import 'package:seller/modules/pond/screen/page_pond.dart';
import 'package:seller/modules/profile/screen/page_profile.dart';
import 'package:seller/modules/register/screen/page_register.dart';
import 'package:flutter/material.dart';

abstract class RoutePage {
  final MaterialPage page;
  final bool isProtected;
  final String name;
  RoutePage(this.page, this.name, {this.isProtected = false});
}

// class RouteUiPage extends RoutePage {
//   RouteUiPage()
//       : super(
//           const MaterialPage(child: UiPage()),
//           'UI PAGE',
//         );
// }

class RouteLogin extends RoutePage {
  RouteLogin()
      : super(
          const MaterialPage(child: LoginPage()),
          'login',
        );
}

class RouteRegister extends RoutePage {
  RouteRegister()
      : super(
          const MaterialPage(child: RegisterPage()),
          'register',
        );
}

class RouteHome extends RoutePage {
  RouteHome()
      : super(
          const MaterialPage(child: HomePage()),
          'home',
        );
}

class RouteProfile extends RoutePage {
  RouteProfile()
      : super(
          const MaterialPage(child: ProfilePage()),
          'profile',
        );
}

class RoutePond extends RoutePage {
  RoutePond()
      : super(
          const MaterialPage(child: PondPage()),
          'pond',
        );
}

class RouteListChat extends RoutePage {
  RouteListChat()
      : super(
          const MaterialPage(child: ListChatPage()),
          'list-chat',
        );
}

class RouteChat extends RoutePage {
  RouteChat()
      : super(
          const MaterialPage(child: ChatPage()),
          'chat',
        );
}

class RouteOrder extends RoutePage {
  RouteOrder()
      : super(
          const MaterialPage(child: OrderPage()),
          'order',
        );
}
