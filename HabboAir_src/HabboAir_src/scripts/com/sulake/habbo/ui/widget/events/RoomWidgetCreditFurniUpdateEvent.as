package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetCreditFurniUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const UPDATE_CREDIT_FURNI:String = "RWCFUE_CREDIT_FURNI_UPDATE";
      
      private var _objectId:int;
      
      private var _creditValue:Number;
      
      private var _isNftCredit:Boolean;
      
      public function RoomWidgetCreditFurniUpdateEvent(param1:String, param2:int, param3:Number, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         _creditValue = param3;
         _objectId = param2;
         _isNftCredit = param4;
      }
      
      public function get creditValue() : Number
      {
         return _creditValue;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get isNftCredit() : Boolean
      {
         return _isNftCredit;
      }
   }
}

