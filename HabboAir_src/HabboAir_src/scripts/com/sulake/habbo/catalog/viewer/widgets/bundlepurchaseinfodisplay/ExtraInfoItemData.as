package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   public class ExtraInfoItemData
   {
      public static const TYPE_PROMO:int = 0;
      
      public static const TYPE_BUNDLES_INFO_SCREEN:int = 1;
      
      public static const UnknownConstFromExtraInfoItemData_Int_1:int = 2;
      
      public static const TYPE_BONUS_BADGE:int = 3;
      
      public static const UnknownConstFromExtraInfoItemData_Int_2:int = 4;
      
      public static const TYPE_RESET_MESSAGE:int = 5;
      
      private var _type:int;
      
      private var _text:String;
      
      private var _quantity:int;
      
      private var _activityPointType:int;
      
      private var _discountPriceCredits:int;
      
      private var _discountPriceActivityPoints:int;
      
      private var _priceCredits:int;
      
      private var _priceActivityPoints:int;
      
      private var _priceSilver:int;
      
      private var _badgeCode:String;
      
      private var _achievementCode:String;
      
      public function ExtraInfoItemData(param1:int, param2:String = "")
      {
         super();
         _type = param1;
         _text = param2;
      }
      
      public function set text(param1:String) : void
      {
         _text = param1;
      }
      
      public function set quantity(param1:int) : void
      {
         _quantity = param1;
      }
      
      public function set activityPointType(param1:int) : void
      {
         _activityPointType = param1;
      }
      
      public function set discountPriceCredits(param1:int) : void
      {
         _discountPriceCredits = param1;
      }
      
      public function set discountPriceActivityPoints(param1:int) : void
      {
         _discountPriceActivityPoints = param1;
      }
      
      public function set priceCredits(param1:int) : void
      {
         _priceCredits = param1;
      }
      
      public function set priceActivityPoints(param1:int) : void
      {
         _priceActivityPoints = param1;
      }
      
      public function set priceSilver(param1:int) : void
      {
         _priceSilver = param1;
      }
      
      public function set badgeCode(param1:String) : void
      {
         _badgeCode = param1;
      }
      
      public function set achievementCode(param1:String) : void
      {
         _achievementCode = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get quantity() : int
      {
         return _quantity;
      }
      
      public function get priceCredits() : int
      {
         return _priceCredits;
      }
      
      public function get priceActivityPoints() : int
      {
         return _priceActivityPoints;
      }
      
      public function get activityPointType() : int
      {
         return _activityPointType;
      }
      
      public function get priceSilver() : int
      {
         return _priceSilver;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
      
      public function get achievementCode() : String
      {
         return _achievementCode;
      }
      
      public function get discountPriceCredits() : int
      {
         return _discountPriceCredits;
      }
      
      public function get discountPriceActivityPoints() : int
      {
         return _discountPriceActivityPoints;
      }
   }
}

