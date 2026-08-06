package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage
   {
      public static const UnknownConstFromRoomWidgetCreditFurniRedeemMessage_String_1:String = "RWFCRM_REDEEM";
      
      private var _objectId:int;
      
      public function RoomWidgetCreditFurniRedeemMessage(param1:String, param2:int)
      {
         super(param1);
         _objectId = param2;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

