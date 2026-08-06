package splash
{
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class PhotoSplashScreen extends Sprite
   {
      private var splashBgClass:Class;
      
      private var splashTopClass:Class;
      
      private var splashImg1:Class;
      
      private var splashImg2:Class;
      
      private var splashImg3:Class;
      
      private var splashImg4:Class;
      
      private var splashImg5:Class;
      
      private var splashImg6:Class;
      
      private var splashImg7:Class;
      
      private var splashImg8:Class;
      
      private var splashImg9:Class;
      
      private var splashImg10:Class;
      
      private var splashImg11:Class;
      
      private var splashImg12:Class;
      
      private var splashImg13:Class;
      
      private var splashImg14:Class;
      
      private var splashImg15:Class;
      
      private var splashImg16:Class;
      
      private var splashImg17:Class;
      
      private var splashImg18:Class;
      
      private var splashImg19:Class;
      
      private var splashImg20:Class;
      
      private var splashImg21:Class;
      
      private var splashImg22:Class;
      
      private var splashImg23:Class;
      
      private var splashImg24:Class;
      
      private var splashImg25:Class;
      
      private var splashImg26:Class;
      
      private var splashImg27:Class;
      
      private var splashImg28:Class;
      
      private var splashImg29:Class;
      
      private var splashImg30:Class;
      
      public function PhotoSplashScreen(param1:DisplayObjectContainer)
      {
         var _loc3_:Bitmap = null;
         splashBgClass = splash_bg_1_png;
         splashTopClass = splash_top_1_png;
         splashImg1 = userphoto_1_1_png;
         splashImg2 = userphoto_2_1_png;
         splashImg3 = userphoto_3_1_png;
         splashImg4 = userphoto_4_1_png;
         splashImg5 = userphoto_5_1_png;
         splashImg6 = userphoto_6_1_png;
         splashImg7 = userphoto_7_1_png;
         splashImg8 = userphoto_8_1_png;
         splashImg9 = userphoto_9_1_png;
         splashImg10 = userphoto_10_1_png;
         splashImg11 = userphoto_11_1_png;
         splashImg12 = userphoto_12_1_png;
         splashImg13 = userphoto_13_1_png;
         splashImg14 = userphoto_14_1_png;
         splashImg15 = userphoto_15_1_png;
         splashImg16 = userphoto_16_1_png;
         splashImg17 = userphoto_17_1_png;
         splashImg18 = userphoto_18_1_png;
         splashImg19 = userphoto_19_1_png;
         splashImg20 = userphoto_20_1_png;
         splashImg21 = userphoto_21_1_png;
         splashImg22 = userphoto_22_1_png;
         splashImg23 = userphoto_23_1_png;
         splashImg24 = userphoto_24_1_png;
         splashImg25 = userphoto_25_1_png;
         splashImg26 = userphoto_26_1_png;
         splashImg27 = userphoto_27_1_png;
         splashImg28 = userphoto_28_1_png;
         splashImg29 = userphoto_29_1_png;
         splashImg30 = userphoto_30_1_png;
         super();
         var _loc2_:Vector.<Bitmap> = new Vector.<Bitmap>(0);
         _loc3_ = new splashBgClass() as Bitmap;
         _loc2_.push(_loc3_);
         var _loc4_:Class = this["splashImg" + (int(1 + Math.floor(Math.random() * 0)))] as Class;
         if(_loc4_ != null)
         {
            _loc3_ = new _loc4_();
            _loc3_.x = 96;
            _loc3_.y = 51;
            _loc2_.push(_loc3_);
         }
         _loc3_ = new splashTopClass() as Bitmap;
         _loc2_.push(_loc3_);
         for each(_loc3_ in _loc2_)
         {
            addChild(_loc3_);
         }
      }
   }
}

