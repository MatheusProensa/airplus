package com.sulake.habbo.ui.widget.events
{
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class RoomWidgetFurniInfoUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const FURNI:String = "RWFIUE_FURNI";
      
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _name:String = "";
      
      private var _description:String = "";
      
      private var _image:BitmapData = null;
      
      private var _classId:int = 0;
      
      private var _isWallItem:Boolean = false;
      
      private var _isStickie:Boolean = false;
      
      private var _isRoomOwner:Boolean = false;
      
      private var _roomControllerLevel:int = 0;
      
      private var _isAnyRoomController:Boolean = false;
      
      private var _expiration:int = -1;
      
      private var UnknownVarFromRoomWidgetFurniInfoUpdateEvent_Int_1:int = -1;
      
      private var _purchaseOfferId:int = -1;
      
      private var _extraParam:String = "";
      
      private var _isOwner:Boolean = false;
      
      private var _stuffData:IStuffData = null;
      
      private var _groupId:int = 0;
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _usagePolicy:int = 0;
      
      private var UnknownVarFromRoomWidgetFurniInfoUpdateEvent_Int_2:int = -1;
      
      private var _rentOfferId:int = -1;
      
      private var _purchaseCouldBeUsedForBuyout:Boolean;
      
      private var _rentCouldBeUsedForBuyout:Boolean;
      
      private var _availableForBuildersClub:Boolean;
      
      private var _isNft:Boolean;
      
      private var _bcOfferId:int = -1;
      
      private var _tradeable:Boolean;
      
      public function RoomWidgetFurniInfoUpdateEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set category(param1:int) : void
      {
         _category = param1;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function set isWallItem(param1:Boolean) : void
      {
         _isWallItem = param1;
      }
      
      public function get isWallItem() : Boolean
      {
         return _isWallItem;
      }
      
      public function set isStickie(param1:Boolean) : void
      {
         _isStickie = param1;
      }
      
      public function get isStickie() : Boolean
      {
         return _isStickie;
      }
      
      public function set isRoomOwner(param1:Boolean) : void
      {
         _isRoomOwner = param1;
      }
      
      public function get isRoomOwner() : Boolean
      {
         return _isRoomOwner;
      }
      
      public function set roomControllerLevel(param1:int) : void
      {
         _roomControllerLevel = param1;
      }
      
      public function get roomControllerLevel() : int
      {
         return _roomControllerLevel;
      }
      
      public function set isAnyRoomController(param1:Boolean) : void
      {
         _isAnyRoomController = param1;
      }
      
      public function get isAnyRoomController() : Boolean
      {
         return _isAnyRoomController;
      }
      
      public function set expiration(param1:int) : void
      {
         _expiration = param1;
      }
      
      public function get expiration() : int
      {
         return _expiration;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         _purchaseOfferId = param1;
      }
      
      public function get purchaseOfferId() : int
      {
         return _purchaseOfferId;
      }
      
      public function get bcOfferId() : int
      {
         return _bcOfferId;
      }
      
      public function set bcOfferId(param1:int) : void
      {
         _bcOfferId = param1;
      }
      
      public function set extraParam(param1:String) : void
      {
         _extraParam = param1;
      }
      
      public function get extraParam() : String
      {
         return _extraParam;
      }
      
      public function set isOwner(param1:Boolean) : void
      {
         _isOwner = param1;
      }
      
      public function get isOwner() : Boolean
      {
         return _isOwner;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         _stuffData = param1;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function set ownerId(param1:int) : void
      {
         _ownerId = param1;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         _usagePolicy = param1;
      }
      
      public function get usagePolicy() : int
      {
         return _usagePolicy;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         _rentOfferId = param1;
      }
      
      public function get rentOfferId() : int
      {
         return _rentOfferId;
      }
      
      public function get purchaseCouldBeUsedForBuyout() : Boolean
      {
         return _purchaseCouldBeUsedForBuyout;
      }
      
      public function set purchaseCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _purchaseCouldBeUsedForBuyout = param1;
      }
      
      public function get rentCouldBeUsedForBuyout() : Boolean
      {
         return _rentCouldBeUsedForBuyout;
      }
      
      public function set rentCouldBeUsedForBuyout(param1:Boolean) : void
      {
         _rentCouldBeUsedForBuyout = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return _availableForBuildersClub;
      }
      
      public function set availableForBuildersClub(param1:Boolean) : void
      {
         _availableForBuildersClub = param1;
      }
      
      public function get isNft() : Boolean
      {
         return _isNft;
      }
      
      public function set isNft(param1:Boolean) : void
      {
         _isNft = param1;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function set classId(param1:int) : void
      {
         _classId = param1;
      }
      
      public function get tradeable() : Boolean
      {
         return _tradeable;
      }
      
      public function set tradeable(param1:Boolean) : void
      {
         _tradeable = param1;
      }
   }
}

