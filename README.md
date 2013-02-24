==============
API Specs
=============

User API:
---------
  URL: user.php
  GET: user.php?uid=1 or user.php?email=&password=  TO get the user infor
  POST:functionType
  "insert":insertNewUser($user);
  "update":updateUser($user);

Promotion API:
--------------
URL:promotion.php
GET: promotion.php?hid=1 GET all the promotions of hotel 1
POST: functionType
	"insert":insertNewPromotion($promotion);
	"delete":deletePromotion($pid,$hid);
	"update":updatePromotion($promotion);
	"uploadImg":requires $_POST["hid"];$_POST["pid"];$_FILES["userfile"];

Booking API:
------------
URL: booking.php
GET: booking.php?bid=1 to GET a booking with book id, 
     booking.php?hid=1&uid to GET user uid's booking history
POST: functionType
	"insert":insertNewBooking($booking);
	"delete":deleteBooking($bid);
	"update":updateBooking($booking);
	
Hotel API:
------------
GET hotel.php?hid= to get the hotel information

Will get a setting.php in the later stage.