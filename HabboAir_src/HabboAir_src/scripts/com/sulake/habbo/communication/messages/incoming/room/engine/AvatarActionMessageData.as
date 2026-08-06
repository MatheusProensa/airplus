package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class AvatarActionMessageData
   {
      private var _actionType:String;
      
      private var _actionParameter:String;
      
      public function AvatarActionMessageData(param1:String, param2:String)
      {
         super();
         _actionType = param1;
         _actionParameter = param2;
      }
      
      public function get actionType() : String
      {
         return _actionType;
      }
      
      public function get actionParameter() : String
      {
         return _actionParameter;
      }
      
      public function toString() : String
      {
         return _actionType + ":" + _actionParameter;
      }
   }
}

