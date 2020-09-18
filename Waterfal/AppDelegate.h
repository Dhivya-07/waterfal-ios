
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <GoogleMaps/GoogleMaps.h>



#define BASEURL @"https://fatneedle.com/waterfal_mobile/public/"

#define REGISTER @"register" // POST
#define VERIFYMOBILE @"verifymobile" //POST mobile
#define VERIFYOTP @"verifyotp" //POST mobile
#define DASHBOARD @"dashboard" // GET
#define ALLPRODUCTS @"products" // GET
#define CATAGORYLIST @"categories_list" //GET
#define SERIESLIST @"series_list" //GEt
#define PRODUCT @"product" // POST id
#define DOWNLOAD @"estimate_download" // POST
#define SHARE @"share_estimate" // POST
#define SEARCHPRODUCT @"search_product" // POST name
#define REGISTER @"register" // GET name,email,password,mobile,user_type,address,area,city,state,pincode,landmark,website
#define STATES @"state_list" //POST States
#define USERPROFILE @"userprofile" // POST id
#define ALLOFFER @"all_offer" // GET
#define GETDEALERS @"get_dealers" //GET
#define FAVOURITELIST @"favourite_list" // POST user_id
#define REMOVEFAVOURITE @"remove_favourite" // POST id
#define CART @"cart" // POST user_id,product_id,product_name,order_amount,status
#define GETCART @"getcart" // GET user_id
#define CREATEORDER @"createorder" // POST user_id
#define CREATEPAYMENT @"createpayment" // POST user_id
#define GETORDER @"getorder" // GET order_id
#define STATEMENTS @"statement_of_account" //GET
#define REORDER @"reorder" //GET
#define PURCHASEHISTORY @"history_purchase" // POST user_id
#define ORDERINFODETAILS @"order_info_details" // POST user_id
#define PAYMENTSUCCESS @"paymentsuccess"
#define PAYMENTFAILURE @"paymentfailure"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

