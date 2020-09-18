<?php
    
date_default_timezone_set('Asia/Kolkata');

include_once '../rpay/vendor/autoload.php';
use Razorpay\Api\Api;

class DbHandler{

    private $conn;

    function __construct(){
        require_once dirname(__FILE__) . '/DbConnect.php';
        $db = new DbConnect; 
        $this->conn = $db->connect(); 

        // Waterfal Razorpay test mode key & secret
        $api_key = "rzp_test_o3qYAFWWz9fhiP";
        $api_secret = "yTn964MTPuTb6eCZZ5m4wiBx";
        
        $this->api = new Api($api_key, $api_secret);
    }

/*------------------------------------/* Watefal Api /*------------------------------------*/
    
    
    
    
/** [10] GET CART **/
function getcart($user_id) {
    
    $tax = 10;
    
    $total = 0;
    $tax_total = 0;

    $r=array();

    $k = array('cart.product_id','cart.quantity','products.name','products.description','products.price');
    $where = "WHERE cart.user_id = '$user_id' AND products.id = cart.product_id AND cart.status = '1' AND cart.is_active = '1' AND cart.quantity !='0' ";
    $sql = "SELECT ". implode(',' , $k) ." FROM cart, products $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $rows = $stmt->fetchAll();

    if(count($rows)>0) {
        
        
        foreach($rows as $row) {
        
           $total = $total + $row['price'] * $row['quantity'];
           $tax_total = $tax_total + ($row['price']*($tax/100));
            
        }
        
        
        
        
        

        $r['status'] = 1;
        $r['message'] = "success";
        $r['data'] = $rows;
        $r['gross_total'] = $total;
        $r['tax_total'] = $tax_total;

    }else{
        $r['status'] = 0;
        $r['message'] = "Cart not found";
    }
    
    
    
return $r;
}

    
    
    

/** [9] CREATE PAYMENT **/
function createpayment($user_id, $order_id) {
    
    
    
    
}
    
    

/** [8] CREATE ORDER **/
function createorder($user_id) {
    
    $total = 0;
    
    $k = array('cart.product_id','cart.quantity','products.name','products.description','products.price');
    $where = "WHERE cart.user_id = '$user_id' AND products.id = cart.product_id AND cart.status = '1' AND cart.is_active = '1' AND cart.quantity !='0' ";
    $sql = "SELECT ". implode(',' , $k) ." FROM cart, products $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $rows = $stmt->fetchAll();
    
    if(count($rows)>0){

        $insertdata = array(
                        "dealer_id" => $user_id,
                        "order_date" => date('Y-m-d H:i:s')
                        );
        
            
         $order_id = $this->insertInTable("dealer_orders", $insertdata); // insert order
        
        
        foreach($rows as $row) {
    
            $total = $total + $row['price'] * $row['quantity'];
            
            $insertOrderDetailsdata = array(
                                            "user_id" => $user_id,
                                            "product_id" => $row['product_id'],
                                            "quantity" => $row['quantity'],
                                            "order_id" => $order_id,
                                            "product_name" => $row['name'],
                                            "product_description" => $row['description'],
                                            "price" => $row['price'],
                                            "order_status" => 1,
                                            "payment_status" => 1,
                                            "status" => 1,
                                            "is_active" => 1,
                                            "cdate" => date('Y-m-d H:i:s')
                                            );
            
            $this->insertInTable("order_details", $insertOrderDetailsdata); // insert order details
           
        }// end foreach
        
        $update_order_array = array(
                                    "order_amount" => $total,
                                    "order_id" => "WTR" . $order_id
                                    );
        
        
        $where = "id=" . $order_id;
        $this->updateTable("dealer_orders", $update_order_array, $where);
        

        $r['status'] = 1;
        $r['order_id'] = $order_id;
        $r['message'] = "Order created";

        
    }else {
        
        $r['status'] = 0;
        $r['message'] = "Cart is empty";

        
    }
    
    return $r;
}

/** [7] PRODUCT **/
function product($id) {
    
    $r=array();
    $k = array('id','name','description','product_title','product_code','price','quantity','display_image as image');
    $where ="WHERE id='$id' LIMIT 1";
    $sql = "SELECT ". implode(',' , $k) ." FROM products $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetch();

    if($row)
    {
        $r['status'] = 1;
        $r['message'] = "success";
        $r['data'] = $row;
    }
    else{
      $r['status'] = 0;
      $r['message'] = "Product not found";
    }

    return $r;
}
 
    
/** [6] PRODUCTS **/
function products($cat_id) {
    $r = array();
    $k = array('id','name','description','product_title','product_code','price','quantity','display_image as image');
    $where = "WHERE category_id = '$cat_id'";
    $sql = "SELECT ". implode(',' , $k) ." FROM products $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $rows = $stmt->fetchAll();
    
    if(count($rows)>0)
    {
        $r['status'] = 1;
        $r['message'] = "success";
        $r['data'] = $rows;
        
    }else {
        
        $r['status'] = 0;
        $r['message'] = "No Products";
        
    }
    
   return $r;
}

    
 /** [5] CART **/
function cart($d){

    $r = array();
    
    $table_name = 'cart';
    
    $d['is_active'] = 1;
    $d['status'] = 1;
    $d['cby'] = 1;
    $d['cdate'] = date('Y-m-d H:i:s');
    
    $user_id = $d['user_id'];
    $product_id = $d['product_id'];
    $quantity = $d['quantity'];
    
    
    $qk = array('id');
    $where ="user_id = '$user_id' AND product_id = '$product_id' AND status='1' AND is_active='1'";
    $sql = "SELECT ". implode(',' , $qk) ." FROM $table_name $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetch();
    
    
    if($row) {// Update Cart
            
            $d['mdate'] = date('Y-m-d H:i:s');
            if(quantity ==0){
                $d['is_active'] = 0;
                $d['status'] = 0;
                
            }
            
            $update_data = array(
                                "quantity" => $quantity
                                );

            $cols= array(); foreach($update_data as $key=>$val) { $cols[] = "$key = '$val'"; }
            $where2= "user_id = '$user_id' AND product_id = '$product_id' AND status='1' AND is_active='1' LIMIT 1";
            $sql2= "UPDATE $table_name SET " . implode(', ', $cols) . " WHERE $where2 LIMIT 1";
            $stmt2= $this->conn->prepare($sql2);
            $stmt2->execute();
            
            if($stmt2){
                
                $r['status'] = 1;
                $r['message'] = "Cart updated";
                if(quantity ==0){
                   $r['message'] = "Cart removed";
                }

                return $r;
            }
   
    }else {// add cart
        
            $k = array_keys($d); $v = array_values($d);
            $sql3= "INSERT INTO $table_name ( ". implode(',' , $k) .") VALUES('". implode("','" , $v) ."')";
            $stmt3= $this->conn->prepare($sql3);
            $stmt3->execute();
        
            if($stmt3){
                $r['status'] = 1;
                $r['message'] = "Added to cart";
            }
        
    }
    
  return $r;
}

    
/** [4] USER PROFILE **/
function userprofile($user_id){
        
        $r=array();
    
        $k = array('id','name','company_name','mobile','address','area','city','state','pincode','landmark','website');
        $where = "WHERE id=$user_id AND status=1 AND is_active=1";
        $sql = "SELECT ". implode(',' , $k) ." FROM users $where";
        $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
        $stmt->execute();
        $row = $stmt->fetch();
        
        if($row) {

            $r['status'] = 1;
            $r['message'] = "success";
            $r['data'] = $row;

        }else{
            $r['status'] = 0;
            $r['message'] = "User not found";
        }
    
    return $r;
}

    
/** [3] VERIFY OTP **/
function verifyotp($otp,$mobile) {
    
    $r=array();
    $table = "sms_log";
    $key = array('id');
    $where = "WHERE mobile='{$mobile}' AND otp ='{$otp}' AND status='1'";
    $sql = "SELECT ". implode(',' , $key) ." FROM $table $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetch();
    if($row){
        
        $updateData = array(
                            "status" => 0,
                            "mdate" => date('Y-m-d H:i:s')
                            );
        
        $where = "id=" . $row['id'];
        $this->updateTable("sms_log", $updateData, $where);
        
        $r['status']=1;
        $r['message'] = 'OTP verified successfully';
        
    }else {
        
        $r['status']=0;
        $r['message'] = 'Invalid OTP!';
        
    }
    
    return $r;
}

/** [2] VERIFY MOBILE **/
function verifymobile($mobile){
    
    $r=array();
    $key = array('id');
    $where ="WHERE status=1 AND mobile='$mobile'";
    $sql = "SELECT ". implode(',' , $key) ." FROM users $where";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetch();

    if ($row) {
        
        $otp = mt_rand(1000, 9999);
        $message = "Your OTP for Waterfal login  is ".$otp;
        //$smsResponse = $this->sendSmsByTextLocal(array("+91".$mobile), $message);
        $smsResponse = "";
        
        $insertdata = array(
                      "mobile" => $mobile,
                      "otp" => $otp,
                      "response" => $smsResponse,
                      "status" => 1,
                      "message" => urlencode($message),
                      "cdate" => date('Y-m-d H:i:s')
                      );
        

        $logId = $this->insertInTable("sms_log", $insertdata);
        
        $r['status']=1;
        $r['user_id'] = $row['id'];
        $r['log_id'] = $logId;
        $r['otp'] = $otp;
          
    }
    else
    {
        $r['status']=0;
        $r['message'] = 'Entered Mobile is invalid!';
    }
    
    return $r;
}
    
    

/** [1] REGISTER **/
function register($d) {
        $r = array();
        $uploadFilePath = "uploads/";
    
        $d['status'] = 1;
        $d['is_active'] = 1;
        $d['dealer_name'] = $d['name'];
        $d['cdate'] = date('Y-m-d H:i:s');
        $d['gstin_filename'] = "";
        $d['pan_filename'] = "";
    
        $email = $d['email']; $mobile = $d['mobile'];

        //user array
        $user_array = array('company_name','name','email','mobile','password','user_type','address','area',
               'city','state','pincode','landmark','website','status','is_active','cdate');
        $d_user = array_intersect_key($d, array_flip($user_array));

        //dealer array
        $dealer_array = array('dealer_name', 'email', 'mobile','website','firm_type','pan_number',
              'year_of_incorporation','no_employee','annual_turnover','status','is_active','cdate');
        $d_dealer= array_intersect_key($d, array_flip($dealer_array));

        //dealer_details
        $details_array = array('dealer_id', 'shop_area','warehouse_area','annual_turnover','dealing_brands','cdate');
        $d_details= array_intersect_key($d, array_flip($details_array));

        //dealer documents
        $documents_array = array('dealer_id', 'gstin_number','pan_number','gstin_filename','pan_filename','cdate');
        $d_documents= array_intersect_key($d, array_flip($documents_array));
    
        if (empty($_FILES['gst_file'])){
            $r['status'] = 0; $r['message'] = "Gst file missing !";
            return $r; // return error
         }else if(empty($_FILES['pan_file'])){
            $r['status'] = 0; $r['message'] = "Pan file missing !";
            return $r;// return error
         }//if($_FILES['gst_file']['type'] != "application/pdf") {}

    
        $q2 = $this->conn->query("SELECT * FROM users WHERE mobile = '$mobile'", PDO::FETCH_ASSOC); $q2->execute(); $result = $q2->fetch();
        if($result) {
            $r['status'] = 0; $r['message'] = "Phone already exists !";
            return $r;// return error
        }else {
                /* -- files upload */
                if (!empty($_FILES['gst_file'])){//GST FILE UPLOAD
                     $gst_path = $_FILES['gst_file']['name'];
                     $gst_ext = pathinfo($gst_path, PATHINFO_EXTENSION);
                     $gstfilename = "GST_" . strtotime("now") .  "." . $gst_ext;
                     $gstpath = $uploadFilePath . $gstfilename;
                     if(move_uploaded_file($_FILES['gst_file']['tmp_name'], $gstpath)){
                         $d['gstin_filename'] = $gstfilename;
                     }
                }
            
                if (!empty($_FILES['pan_file'])){//PAN FILE UPLOAD
                      $pan_path = $_FILES['pan_file']['name'];
                      $pan_ext = pathinfo($pan_path, PATHINFO_EXTENSION);
                      $panfilename = "PAN_" . strtotime("now") .  "." . $pan_ext;
                      $panpath = $uploadFilePath . $panfilename;
                     if(move_uploaded_file($_FILES['pan_file']['tmp_name'], $panpath)){
                          $d['pan_filename'] = $panfilename;
                     }
                 }
                        

            /*-----------------*\ users insert *\---------------*/
            $key = array_keys($d_user); $value = array_values($d_user);
            $sql2= "INSERT INTO users ( ". implode(',' , $key) .") VALUES('". implode("','" , $value) ."')";
            $stmt2= $this->conn->prepare($sql2); $stmt2->execute();
            
        
            $d['dealer_id'] =  $this->insertInTable("dealer", $d_dealer); // dealer insert
            $this->insertInTable("dealer_details", $d_details);// dealer details insert
            $this->insertInTable("dealer_documents", $d_documents);//documents insert


            if($stmt2) {
                $r['status'] = 1; $r['message'] = "Registered Successfully";
                
            }else {
                $r['status'] = 0; $r['message'] = "Data insert error !";
                 
            }
        
        }

       return $r;
    }
    
   
/** SEND SMS BY TEXT LOCAL **/
function sendSmsByTextLocal($numbers, $message) {
    
    // Account details
    $apiKey = urlencode("mXrxihWr2dk-DPEiDemVCEkovt7Tu1H2Aq5ADbQaf3");
    // Message details
    $sender = urlencode('TXTLCL');
    $message = rawurlencode($message);
    $numbers = implode(',', $numbers);
     
    // Prepare data for POST request
    $data = array('apikey' => $apiKey, 'numbers' => $numbers, "sender" => $sender, "message" => $message);
    // Send the POST request with cURL
    $ch = curl_init('https://api.textlocal.in/send/');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $response = curl_exec($ch);
    curl_close($ch);
    // Process your response here
    return $response;
}

    
    
/** UPDATE DATA TABLE*/
function updateTable($table_name, $data, $where){
    $cols = array(); foreach($data as $key=>$val) { $cols[] = "$key = '$val'"; }
    $sql2= "UPDATE $table_name SET " . implode(', ', $cols) . " WHERE $where LIMIT 1";
    $stmt2= $this->conn->prepare($sql2);
    $stmt2->execute();
}


/** INSERT DATA IN TABLE **/
function insertInTable($table_name, $d){
    $k = array_keys($d); $v = array_values($d);
    $sql= "INSERT INTO $table_name ( ". implode(',' , $k) .") VALUES('". implode("','" , $v) ."')";
    $stmt= $this->conn->prepare($sql);
    $stmt->execute();
    return $this->conn->lastInsertId();
}
 
    
    
    
//dashboard
function dashboard()
{        
      $sql= "SELECT * FROM products WHERE  status=1 AND is_active=1";

        $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
        $stmt->execute();
        $rows = $stmt->fetchAll();

        if($rows) {

            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $rows;

        }else{
            $response['status'] = 0;
        $response['message'] = "not found";
        }
    return $response;  
}

    

function edit_profile($id,$name,$address,$area,$city,$state,$pincode,$landmark,$website)
  {
      $response = array();
     
      $mdate = date('Y-m-d H:i:s');
                $sql = "UPDATE users SET name='$name', address='$address', area='$area', city='$city',state='$state', pincode='$pincode',landmark='$landmark',website='$website', mdate='$mdate' WHERE id=$id";
                    $stmt = $this->conn->query($sql);
                    $stmt->execute();


                    if($stmt){

                        $response['status'] = 1;
                        $response['message'] = "success";
                  
            
                }
              else{
                    
                    $response['status'] = 0;
                    $response['message'] = "Data insert error !";
                    
                }

    return $response;
  }

 function all_user()
  {
     $response=array();
    $sql = "SELECT * FROM users WHERE  status=1 AND is_active=1 ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();
     if(count($row)>0)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{
              $response['status'] = 0;
              $response['message'] = "User not found";
              $response['data'] = array();
           }
    
    return $response;
  }

//
//  function product($id){
//
//      $response=array();
//    $sql = "SELECT * FROM products WHERE id='$id' ";
//    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
//    $stmt->execute();
//    $row = $stmt->fetch();
//
//     if($row)
//        {
//            $response['status'] = 1;
//            $response['message'] = "success";
//            $response['data'] = $row;
//        }
//           else{
//
//              $response['status'] = 0;
//              $response['message'] = "Product not found";
//           }
//
//    return $response;
//  }

 
function all_cart(){
    
   $response=array();
   $r = array();
    $sql = "SELECT * FROM cart WHERE status=1 AND is_active=1";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $rows = $stmt->fetchAll();
    
    if(count($rows)>0) {

        $response['status'] = 1;
        $response['message'] = "success";
        $response['data'] = $rows;

    }else{
        $response['status'] = 0;
    $response['message'] = "Carts not found";
    }
return $response;

}
    
    
//function carts($user_id){
//
//       $response=array();
//
//        $sql = "SELECT * FROM cart WHERE user_id=$user_id AND status=1 AND is_active=1";
//        $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
//        $stmt->execute();
//        $rows = $stmt->fetchAll();
//
//        if(count($rows)>0) {
//
//            $response['status'] = 1;
//            $response['message'] = "success";
//            $response['data'] = $rows;
//
//        }else{
//            $response['status'] = 0;
//        $response['message'] = "Cart not found";
//        }
//    return $response;
//
//}
//


  function edit_cart($id,$user_id,$product_id,$product_name,$order_amount,$status)
  {
      $response = array();
     
      $mdate = date('Y-m-d H:i:s');
                $sql = "UPDATE cart SET user_id='$user_id', product_id='$product_id', product_name='$product_name', order_amount='$order_amount',status='$status', mdate='$mdate' WHERE id=$id";
                    $stmt = $this->conn->query($sql);
                    $stmt->execute();


                    if($stmt){

                        $response['status'] = 1;
                        $response['message'] = "success";
                  
            
                }
              else{
                    
                    $response['status'] = 0;
                    $response['message'] = "Data insert error !";
                    
                }

    return $response;
  }

  function delete_cart($id)
  {
      $status =0;
      $is_active=0;
           $sql = "UPDATE cart SET status='$status', is_active='$is_active' WHERE id='$id' ";
            $stmt = $this->conn->query($sql);
            $stmt->execute();

           if($stmt){
 
                   $response['status'] = 1;
                   $response['message'] = "delete success";
         
                   
                }else{
                    
                    $response['status'] = 0;
                    $response['message'] = "exists !";
                    
                }
              return $response;

    

  }

  function search_product($name){
    
      $response=array();
   
    $sql = "SELECT * FROM products  WHERE  name LIKE '%$name%' AND status=1 AND is_active=1 ";

    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();

     if(count($row)>0)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{

              $response['status'] = 0;
              $response['message'] = "Product not found";
           }
    
    return $response;
  }

 function favourite_list($user_id){
    
      $response=array();
    $sql = "SELECT favourites.*,products.* FROM favourites  join products on products.id=favourites.product_id WHERE user_id='$user_id' ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();

     if(count($row)>0)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{

              $response['status'] = 0;
              $response['message'] = "Favourite not found";
           }
    
    return $response;
  }

  function remove_favourite($id)
  {
      $status =0;
      $is_active=0;
           $sql = "UPDATE favourites SET status='$status', is_active='$is_active' WHERE id='$id' ";
            $stmt = $this->conn->query($sql);
            $stmt->execute();

           if($stmt){
 
                   $response['status'] = 1;
                   $response['message'] = "delete success";
         
                   
                }else{
                    
                    $response['status'] = 0;
                    $response['message'] = "exists !";
                    
                }
              return $response;

    

  }

   function notification_list($user_id){
    
      $response=array();
    $sql = "SELECT * FROM notification WHERE user_id='$user_id' ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();

     if(count($row)>0)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{

              $response['status'] = 0;
              $response['message'] = "notification not found";
           }
    
    return $response;
  }

  function all_offer(){
        
       $response=array();
       $r = array();
        $sql = "SELECT * FROM offers WHERE status=1 AND is_active=1";
        $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
        $stmt->execute();
        $rows = $stmt->fetchAll();
        
        if(count($rows)>0) {

            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $rows;

        }else{
            $response['status'] = 0;
        $response['message'] = "Offers not found";
        }
    return $response;
    
}

 function history_purchase($user_id){
    
    $response=array();
    $sql = "SELECT * FROM order_details WHERE user_id='$user_id' AND payment_status=2 AND order_status=2 ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();

     if(count($row)>0)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{

              $response['status'] = 0;
              $response['message'] = "No purchase";
           }
    
    return $response;
  }

  function add_order_details($user_id,$product_id,$payment_id,$order_amount,$order_status,$payment_status)
  {
      $response = array();
      $is_active=1;
      $cby=1;
      $status=1;
      $mby=1;
      $cdate = date('Y-m-d H:i:s');
      $mdate = date('Y-m-d H:i:s');
                $sql = "INSERT INTO order_details (user_id,product_id,payment_id,order_amount,order_status,payment_status,status,is_active,cby,cdate,mby,mdate) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
                    $stmt= $this->conn->prepare($sql);
         $stmt->execute([$user_id,$product_id,$payment_id,$order_amount,$order_status,$payment_status,$status,$is_active,$cby,$cdate,$mby,$mdate]);


                    if($stmt){

                        $response['status'] = 1;
                        $response['message'] = "success";
            
                }
              else{
                    
                    $response['status'] = 0;
                    $response['message'] = "Data insert error !";
                    
                }

    return $response;

  }

  function order_info_details($user_id){
    
      $response=array();
      $status=1;
    $sql = "SELECT * FROM order_details WHERE user_id='$user_id' AND status='$status' ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetchAll();

     if($row)
        {
            $response['status'] = 1;
            $response['message'] = "success";
            $response['data'] = $row;
        }
           else{

              $response['status'] = 0;
              $response['message'] = "Order details not found";
           }
    
    return $response;
  }

  function add_payment_autocapture($user_id, $amount, $order_id) {
        $response = array();
        
        $sql2 = "SELECT * FROM payments WHERE order_details_id = '$order_id' AND user_id = '$user_id'";
        $stmt2 = $this->conn->query($sql2, PDO::FETCH_ASSOC);
        $stmt2->execute();
        $rows2 = $stmt2->fetchAll();
        $count = $stmt2->rowCount();
        $date_of_order = date("Y-m-d");
        $payment_mode = 1; //web
        $payment_status = 1; //pending
        $is_active = 1;
        $cdate = date('Y-m-d H:i:s');
        if($count==0){
            
            $sql3 = "INSERT INTO payments (user_id, amount, order_details_id,date_of_order,payment_mode,payment_status,is_active,cdate) VALUES (?,?,?,?,?,?,?,?)";
            $stmt3= $this->conn->prepare($sql3);
            $stmt3->execute([$user_id, $amount, $order_id,$date_of_order,$payment_mode, $payment_status,$is_active,$cdate]);

            $payment_id = $this->conn->lastInsertId();
            
            $sql = "UPDATE order_details SET payment_id='$payment_id' WHERE id=$order_id";
            $stmt = $this->conn->query($sql);
            $stmt->execute();
    
            
            if($stmt3){
                    
                // Orders
                $order  = $this->api->order->create(array('receipt' => 'receipt123','amount' =>$amount*100, 'currency' => 'INR',  'payment_capture' =>  1)); // Creates order
                $orderId = $order['id']; // Get the created Order ID
                
                
                $response['status'] = 1;
                $response['message'] = "success";

                $response['id'] =  $payment_id;
                $response['order_details_id'] = $order_id;
                $response['razorpay_order_id'] = $orderId;
                $response['totalamount'] = $amount*100;
                
                
            }else{
                
                $response['status'] = 0;
                $response['message'] = "Data insert error !";
                
            }
            
        }else{
                $response['status'] = "failed";
                $response['message'] = "Try again !";
        }
        
        return $response;
        
    }

  function pay_later_otp($user_id,$payment_id)
  {
       $response = array();
       $payment_status=1;
    $sql = "SELECT mobile FROM users WHERE id=$user_id ";
    $stmt = $this->conn->query($sql, PDO::FETCH_ASSOC);
    $stmt->execute();
    $row = $stmt->fetch();
    $response['mobile']=$row['mobile'];
     
    $smsres = $this->generate_otp($row['mobile']);
    
    if($smsres['status'] == 1)
    {
        $sql1 = "UPDATE payments SET payment_status='$payment_status' WHERE id='$payment_id' AND user_id='$user_id' ";
        $stmt = $this->conn->query($sql);
        $stmt->execute();

       if($stmt){

             $response['status']=1;
              $response['message'] = "success";
          }else {
              
              $response['status'] = 0;
              $response['message'] = "update error !";
              
          }
      
        }
        else{
            
             $response['status'] = "failed";
            $response['message'] = "sms send  failure !";
          }

   
      return $response;

  }

  function payment_success($user_id,$payment_id,$transaction_id,$order_details_id) {
    
                   $response=array();
                   $payment_status = 2; //success
                   $order_status = 2; //success
                   $payment_comment ='success';

                   $sql = "UPDATE payments SET pay_payment_id='$transaction_id',payment_status='$payment_status',payment_comment='$payment_comment' WHERE id='$payment_id' AND user_id='$user_id' ";
                    $stmt = $this->conn->query($sql);
                    $stmt->execute();
                    
                    $sql3 = "UPDATE order_details SET order_status=?,payment_status=? WHERE id=? ";
                    $stmt1 = $this->conn->prepare($sql3);
                    $stmt1->execute([$order_status, $payment_status,$order_details_id]);

                    if($stmt){
 
                      $sql3 = "SELECT * FROM order_details WHERE payment_id = '$payment_id' AND user_id = '$user_id'";
                        $stmt3 = $this->conn->query($sql3, PDO::FETCH_ASSOC);
                        $stmt3->execute();
                        $rows3 = $stmt3->fetchAll();
                        
                          
                          $response['status']=1;
                        $response['message'] = "success";
                    }else {
                        
                        $response['status'] = 0;
                        $response['message'] = "Payment update error !";
                        
                    }
                
                return $response;
    
}


function payment_failure($payment_id,$error_msg)
{
        $response=array();
        $payment_status=0;
        $inpay = $this->conn->prepare("UPDATE payments SET payment_comment=?,payment_status=? WHERE id=?");
        $inpay->execute([$error_msg,$payment_status,$payment_id]);
        // echo $inpay->rowCount();
        if($inpay)
        {
            $response['status'] = 1;
            $response['message'] = "Payment update error !";
        }
        return $response;
}


}


?>
