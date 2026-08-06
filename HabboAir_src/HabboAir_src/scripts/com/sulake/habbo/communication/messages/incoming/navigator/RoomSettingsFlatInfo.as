package com.sulake.habbo.communication.messages.incoming.navigator
{
   [SecureSWF(rename="true")]
   public class RoomSettingsFlatInfo
   {
      public static const UnknownConstFromRoomSettingsData_Int_1:int = 0;
      
      public static const UnknownConstFromRoomSettingsData_Int_2:int = 1;
      
      public static const UnknownConstFromRoomSettingsData_Int_3:int = 2;
      
      public static const UnknownConstFromRoomSettingsData_Int_4:int = 3;
      
      public static const UnknownConstFromRoomSettingsData_Int_5:int = 4;
      
      private var _allowFurniMoving:Boolean;
      
      private var _doorMode:int;
      
      private var _id:int;
      
      private var _ownerName:String;
      
      private var _type:String;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _showOwnerName:Boolean;
      
      private var _allowTrading:Boolean;
      
      private var _categoryAlertKey:Boolean;
      
      private var _password:String;
      
      public function RoomSettingsFlatInfo()
      {
         super();
      }
      
      public function get allowFurniMoving() : Boolean
      {
         return _allowFurniMoving;
      }
      
      public function get doorMode() : int
      {
         return _doorMode;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get showOwnerName() : Boolean
      {
         return _showOwnerName;
      }
      
      public function get allowTrading() : Boolean
      {
         return _allowTrading;
      }
      
      public function get categoryAlertKey() : Boolean
      {
         return _categoryAlertKey;
      }
      
      public function get password() : String
      {
         return _password;
      }
      
      public function set allowFurniMoving(param1:Boolean) : void
      {
         _allowFurniMoving = param1;
      }
      
      public function set doorMode(param1:int) : void
      {
         _doorMode = param1;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function set showOwnerName(param1:Boolean) : void
      {
         _showOwnerName = param1;
      }
      
      public function set allowTrading(param1:Boolean) : void
      {
         _allowTrading = param1;
      }
      
      public function set categoryAlertKey(param1:Boolean) : void
      {
         _categoryAlertKey = param1;
      }
      
      public function set password(param1:String) : void
      {
         _password = param1;
      }
   }
}

