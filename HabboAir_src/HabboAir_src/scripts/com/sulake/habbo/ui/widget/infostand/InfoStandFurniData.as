package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandFurniData
   {
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _name:String = "";
      
      private var _description:String = "";
      
      private var _image:BitmapData;
      
      private var _classId:int;
      
      private var _purchaseOfferId:int = -1;
      
      private var _extraParam:String = "";
      
      private var _stuffData:IStuffData = null;
      
      private var _groupId:int;
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _rentOfferId:int = -1;
      
      private var _availableForBuildersClub:Boolean = false;
      
      private var _bcOfferId:int = -1;
      
      private var _tradeable:Boolean;
      
      public function InfoStandFurniData()
      {
         super();
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set category(param1:int) : void
      {
         _category = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function set image(param1:BitmapData) : void
      {
         _image = param1;
      }
      
      public function set classId(param1:int) : void
      {
         _classId = param1;
      }
      
      public function set purchaseOfferId(param1:int) : void
      {
         _purchaseOfferId = param1;
      }
      
      public function set bcOfferId(param1:int) : void
      {
         _bcOfferId = param1;
      }
      
      public function set extraParam(param1:String) : void
      {
         _extraParam = param1;
      }
      
      public function set stuffData(param1:IStuffData) : void
      {
         _stuffData = param1;
      }
      
      public function set groupId(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function set ownerId(param1:int) : void
      {
         _ownerId = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set availableForBuildersClub(param1:Boolean) : void
      {
         _availableForBuildersClub = param1;
      }
      
      public function set tradeable(param1:Boolean) : void
      {
         _tradeable = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get purchaseOfferId() : int
      {
         return _purchaseOfferId;
      }
      
      public function get bcOfferId() : int
      {
         return _bcOfferId;
      }
      
      public function get extraParam() : String
      {
         return _extraParam;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get rentOfferId() : int
      {
         return _rentOfferId;
      }
      
      public function set rentOfferId(param1:int) : void
      {
         _rentOfferId = param1;
      }
      
      public function get availableForBuildersClub() : Boolean
      {
         return _availableForBuildersClub;
      }
      
      public function get tradeable() : Boolean
      {
         return _tradeable;
      }
      
      public function setData(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         id = param1.id;
         category = param1.category;
         name = param1.name;
         description = param1.description;
         image = param1.image;
         purchaseOfferId = param1.purchaseOfferId;
         extraParam = param1.extraParam;
         stuffData = param1.stuffData;
         groupId = param1.groupId;
         ownerName = param1.ownerName;
         ownerId = param1.ownerId;
         rentOfferId = param1.rentOfferId;
         availableForBuildersClub = param1.availableForBuildersClub;
         classId = param1.classId;
         bcOfferId = param1.bcOfferId;
         tradeable = param1.tradeable;
      }
   }
}

