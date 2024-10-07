import 'package:get/get.dart';

import '../../main.dart';
import '../modules/AccountPage/bindings/account_page_binding.dart';
import '../modules/AccountPage/views/account_page_view.dart';
import '../modules/CartPage/bindings/cart_page_binding.dart';
import '../modules/CartPage/views/cart_page_view.dart';
import '../modules/CategoryPage/bindings/category_page_binding.dart';
import '../modules/CategoryPage/views/category_page_view.dart';
import '../modules/FavouritePage/bindings/favourite_page_binding.dart';
import '../modules/FavouritePage/views/favourite_page_view.dart';
import '../modules/HomePage/bindings/home_page_binding.dart';
import '../modules/HomePage/views/home_page_view.dart';
import '../modules/PhonePePayment/bindings/phone_pe_payment_binding.dart';
import '../modules/PhonePePayment/views/phone_pe_payment_view.dart';
import '../modules/Return_refund/bindings/return_refund_binding.dart';
import '../modules/Return_refund/views/return_refund_view.dart';
import '../modules/SubCategoryPage/bindings/sub_category_page_binding.dart';
import '../modules/SubCategoryPage/views/sub_category_page_view.dart';
import '../modules/aboutUs/bindings/about_us_binding.dart';
import '../modules/aboutUs/views/about_us_view.dart';
import '../modules/address/bindings/address_binding.dart';
import '../modules/address/views/address_view.dart';
import '../modules/buttomBar/bindings/buttom_bar_binding.dart';
import '../modules/buttomBar/views/buttom_bar_view.dart';
import '../modules/checkOutPage/bindings/check_out_page_binding.dart';
import '../modules/checkOutPage/views/check_out_page_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/editProfilePage/bindings/edit_profile_page_binding.dart';
import '../modules/editProfilePage/views/edit_profile_page_view.dart';
import '../modules/google_map/bindings/google_map_binding.dart';
import '../modules/google_map/views/google_map_view.dart';
import '../modules/help_center/bindings/help_center_binding.dart';
import '../modules/help_center/views/help_center_view.dart';
import '../modules/introductionScreen/bindings/introduction_screen_binding.dart';
import '../modules/introductionScreen/views/introduction_screen_view.dart';
import '../modules/loginScreen/bindings/login_screen_binding.dart';
import '../modules/loginScreen/views/login_screen_view.dart';
import '../modules/myOrderPage/bindings/my_order_page_binding.dart';
import '../modules/myOrderPage/views/my_order_page_view.dart';
import '../modules/myfavourite/bindings/myfavourite_binding.dart';
import '../modules/myfavourite/views/myfavourite_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/private_policy/bindings/private_policy_binding.dart';
import '../modules/private_policy/views/private_policy_view.dart';
import '../modules/productDescriptionPage/bindings/product_description_page_binding.dart';
import '../modules/productDescriptionPage/views/product_description_page_view.dart';
import '../modules/productPage/bindings/product_page_binding.dart';
import '../modules/productPage/views/product_page_view.dart';
import '../modules/registationCompleteScreen/bindings/registation_complete_screen_binding.dart';
import '../modules/registationCompleteScreen/views/registation_complete_screen_view.dart';
import '../modules/return/bindings/return_binding.dart';
import '../modules/return/views/return_view.dart';
import '../modules/search_page/bindings/search_page_binding.dart';
import '../modules/search_page/views/search_page_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/signUpScreen/bindings/sign_up_screen_binding.dart';
import '../modules/signUpScreen/views/sign_up_screen_view.dart';
import '../modules/term_and_condition/bindings/term_and_condition_binding.dart';
import '../modules/term_and_condition/views/term_and_condition_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.INTRODUCTION_SCREEN;
  static Future<String> _getInitialRoute() async {
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    return isLoggedIn ? Routes.BUTTOM_BAR : Routes.INTRODUCTION_SCREEN;
  }

  static final routes = [
    GetPage(
      name: _Paths.INTRODUCTION_SCREEN,
      page: () => const IntroductionScreenView(),
      binding: IntroductionScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_SCREEN,
      page: () => LoginScreenView(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_SCREEN,
      page: () => SignUpScreenView(),
      binding: SignUpScreenBinding(),
    ),
    GetPage(
      name: _Paths.REGISTATION_COMPLETE_SCREEN,
      page: () => const RegistationCompleteScreenView(),
      binding: RegistationCompleteScreenBinding(),
    ),
    GetPage(
      name: _Paths.BUTTOM_BAR,
      page: () => ButtomBarView(),
      bindings: [
        ButtomBarBinding(),
        HomePageBinding(),
        CategoryPageBinding(),
        CartPageBinding(),
        FavouritePageBinding(),
        AccountPageBinding()
      ],
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.CART_PAGE,
      page: () => CartPageView(),
      binding: CartPageBinding(),
    ),
    GetPage(
      name: _Paths.FAVOURITE_PAGE,
      page: () => FavouritePageView(),
      binding: FavouritePageBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_PAGE,
      page: () => const AccountPageView(),
      binding: AccountPageBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_PAGE,
      page: () => CategoryPageView(
        name: '',
      ),
      binding: CategoryPageBinding(),
    ),
    GetPage(
      name: _Paths.SUB_CATEGORY_PAGE,
      page: () => SubCategoryPageView(
        name: '',
      ),
      binding: SubCategoryPageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_PAGE,
      page: () => ProductPageView(),
      binding: ProductPageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DESCRIPTION_PAGE,
      page: () => ProductDescriptionPageView(),
      binding: ProductDescriptionPageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE_PAGE,
      page: () => const EditProfilePageView(),
      binding: EditProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDER_PAGE,
      page: () => const MyOrderPageView(),
      binding: MyOrderPageBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_OUT_PAGE,
      page: () => const CheckOutPageView(),
      binding: CheckOutPageBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_US,
      page: () => const AboutUsView(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => const AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.RETURN,
      page: () => const ReturnView(),
      binding: ReturnBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.HELP_CENTER,
      page: () => const HelpCenterView(),
      binding: HelpCenterBinding(),
    ),
    GetPage(
      name: _Paths.TERM_AND_CONDITION,
      page: () => const TermAndConditionView(),
      binding: TermAndConditionBinding(),
    ),
    GetPage(
      name: _Paths.RETURN_REFUND,
      page: () => const ReturnRefundView(),
      binding: ReturnRefundBinding(),
    ),
    GetPage(
      name: _Paths.PRIVATE_POLICY,
      page: () => const PrivatePolicyView(),
      binding: PrivatePolicyBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.PHONE_PE_PAYMENT,
      page: () => PhonePePaymentView(),
      binding: PhonePePaymentBinding(),
    ),
    GetPage(
      name: _Paths.MYFAVOURITE,
      page: () => const MyfavouriteView(),
      binding: MyfavouriteBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PAGE,
      page: () => SearchPageView(),
      binding: SearchPageBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_MAP,
      page: () => const GoogleMapView(),
      binding: GoogleMapBinding(),
    ),
  ];

  static final Future<String> initialRoute = _getInitialRoute();
}
