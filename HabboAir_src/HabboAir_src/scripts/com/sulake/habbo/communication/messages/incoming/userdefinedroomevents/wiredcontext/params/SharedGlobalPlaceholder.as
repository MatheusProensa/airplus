package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedGlobalPlaceholder
   {
      private var _roomId:int;
      
      private var _roomName:String;
      
      private var _placeholderName:String;
      
      public function SharedGlobalPlaceholder(param1:IMessageDataWrapper)
      {
         super();
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         _placeholderName = param1.readString();
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get placeholderName() : String
      {
         return _placeholderName;
      }
   }
}

