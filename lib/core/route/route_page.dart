import 'package:seller/modules/chat/screen/page_chat.dart';
import 'package:seller/modules/chat/screen/page_list_chat.dart';
import 'package:seller/modules/home/screen/page_home.dart';
import 'package:seller/modules/login/screen/page_login.dart';
import 'package:seller/modules/order/screen/page_order.dart';
import 'package:seller/modules/pond/screen/page_pond.dart';
import 'package:seller/modules/pool/screen/page_list_pool.dart';
import 'package:seller/modules/pool/screen/page_pool.dart';
import 'package:seller/modules/profile/screen/page_profile.dart';
import 'package:seller/modules/register/screen/page_register.dart';
import 'package:flutter/material.dart';
import 'package:seller/modules/submission/screen/page_submission.dart';

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

class RouteEditProfile extends RoutePage {
  RouteEditProfile()
      : super(
          const MaterialPage(child: EditProfilePage()),
          'edit-profile',
        );
}

class RouteFormSubmission extends RoutePage {
  RouteFormSubmission()
      : super(
          const MaterialPage(child: SubmissionPage()),
          'form-submission',
        );
}

class RouteProductSetting extends RoutePage {
  RouteProductSetting()
      : super(
          const MaterialPage(child: ProductSettingPage()),
          'product-setting',
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

class RouteListPool extends RoutePage {
  RouteListPool()
      : super(
          const MaterialPage(child: ListPoolPage()),
          'list-pool',
        );
}

class RoutePool extends RoutePage {
  RoutePool()
      : super(
          const MaterialPage(child: PoolPage()),
          'pool',
        );
}
