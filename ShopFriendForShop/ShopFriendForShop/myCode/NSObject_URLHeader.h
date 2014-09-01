//
//  NSObject_URLHeader.h
//  ShopFriendForShop
//
//  Created by Beautilut on 14-1-25.
//  Copyright (c) 2014年 beautilut design. All rights reserved.
//
#define kXMPPmyJID @"kXMPPmyJID"
#define kXMPPmyPassword @"kXMPPmyPassword"
#define shopLogoKey [NSString stringWithFormat:@"shopLogo%@",[[NSUserDefaults standardUserDefaults]objectForKey:kXMPPmyJID]]
#define SHOP_LOGO(_SHOP_) [NSString stringWithFormat:@"http://www.beautilut.com/shopFriendDatabase/shopDatabase/%@/shopLogo.jpg",_SHOP_]
#define getMyShopInfo @"http://www.beautilut.com/shopFriend/shopMethod/shopInfo.php"
#define getAllShopCategory @"http://www.beautilut.com/shopFriend/shopMethod/ShopCategory.php"
//
#define enterURL @"http://www.beautilut.com/shopFriend/shopMethod/shopEnter.php"
#define registerURL @"http://www.beautilut.com/shopFriend/shopMethod/shopRegister.php"
#define TalkImage @"http://www.beautilut.com/shopFriend/TalkImage.php"
#define GetTalkInfo @"http://www.beautilut.com/shopFriend/XMPPMethod/InfoGet.php"
//invitation
#define webInvitationGet @"http://www.beautilut.com/shopFriend/other/getInvitation.php"//Y
#define invitation @"http://www.beautilut.com/shopFriend/other/invitation.php" //y
//
#define USER_IMAGE_URL(_USERID_) [NSString stringWithFormat:@"http://www.beautilut.com/shopFriendDatabase/userDatabase/%@/userImage.jpg",_USERID_]
#define GET_CHAT_IMAGE(_PHOTO_) [NSString stringWithFormat:@"http://www.beautilut.com/res/%@",_PHOTO_]
//token
#define tokenUp @""
#define tokenRegister @""
//menu
#define menuGetURL @"http://www.beautilut.com/shopFriend/menuMethods/menuGet.php"
#define menuImageURL @"http://www.beautilut.com/shopFriendDatabase/shopDatabase/"
#define menuDeleteURL @"http://www.beautilut.com/shopFriend/menuMethods/menuDelete.php"
#define menuInsertURL @"http://www.beautilut.com/shopFriend/menuMethods/menuInput.php" //y
#define menuChangeURL @"http://www.beautilut.com/shopFriend/menuMethods/menuChange.php" //y
#define menuRankURL @"http://www.beautilut.com/shopFriend/menuMethods/menuRank.php"
//category
#define categoryInsertURL @"http://www.beautilut.com/shopFriend/menuMethods/categoryInput.php"
#define categoryChangeURL @"http://www.beautilut.com/shopFriend/menuMethods/categoryChange.php"
#define categoryDeleteURL @"http://www.beautilut.com/shopFriend/menuMethods/categoryDelete.php"
#define categoryRankURL @"http://www.beautilut.com/shopFriend/menuMethods/categoryRank.php"
//shopInfoChange
#define shopInfoChangeURL @"http://www.beautilut.com/shopFriend/shopMethod/shopInfoChange.php"
#define shopLogoChangeURL @"http://www.beautilut.com/shopFriend/shopMethod/shopImageChange.php"
#define shopFriendFeedBack @"http://www.beautilut.com/shopFriend/other/feedBack.php"
#define SHOP_WINDOW(shop,number) [NSString stringWithFormat:@"http://www.beautilut.com/shopFriendDatabase/shopDatabase/%@/shopWindow/shopWindow%d",shop,number]
#define shopWindowImageChange @"http://www.beautilut.com/shopFriend/shopMethod/shopWindowChange.php"
#define shopWindowImageDelete   @"http://www.beautilut.com/shopFriend/shopMethod/shopWindowDelete.php"
#define getShopActivity @"http://www.beautilut.com/shopFriend/shopMethod/shopActivityInfo.php"
#define changeShopActivity @"http://www.beautilut.com/shopFriend/shopMethod/shopActivityChange.php"
//userFans
#define getUserFnas @"http://www.beautilut.com/shopFriend/relationMethods/getUserFansList.php"
#define GetShopWindowImage @"http://www.beautilut.com/shopFriend/shopMethod/shopWindowImage.php"//1
#define SHOP_MENU_PICK(_PICK_) [NSString stringWithFormat:@"http://www.beautilut.com/shopFriendDatabase/shopDatabase/%@",_PICK_]//1

//Order
#define insertOrderURL @""
#define getAllOrderURL @"http://www.beautilut.com/shopFriend/OrderMethods/getAllOrders.php" //y
#define updateOrderURL @"http://www.beautilut.com/shopFriend/OrderMethods/updateOrder.php" //y
#define getOrderURL @"http://www.beautilut.com/shopFriend/OrderMethods/getOrder.php" //y
//coupon
#define couponModelGetURL @"http://www.beautilut.com/shopFriend/couponMethods/shopCouponGet.php" //x
#define couponModelInsertURL @"http://www.beautilut.com/shopFriend/couponMethods/newCouponModel.php" //x
#define couponModelChangeURL @""
#define sendCouponURL @""

//server
#define serverGetURL @"http://www.beautilut.com/shopFriend/ServerMethods/getServerList.php" //y
#define getMyServer @"http://www.beautilut.com/shopFriend/ServerMethods/showMyServer.php" //y
#define serverInfoChange @"http://www.beautilut.com/shopFriend/ServerMethods/changeServerInfo.php" //y
#define registerServerURL @"http://www.beautilut.com/shopFriend/ServerMethods/registerServer.php" //y
#define getGoodServerURL @"http://www.beautilut.com/shopFriend/ServerMethods/serverMenu.php" //y

//report
#define reportURL @"http://www.beautilut.com/shopFriend/other/report.php"