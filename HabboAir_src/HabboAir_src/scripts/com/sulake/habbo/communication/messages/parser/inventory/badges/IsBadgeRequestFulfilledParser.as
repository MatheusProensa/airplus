package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsBadgeRequestFulfilledParser implements IMessageParser
   {
      private var _requestCode:String;
      
      private var _fulfilled:Boolean;
      
      public function IsBadgeRequestFulfilledParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _requestCode = param1.readString();
         _fulfilled = param1.readBoolean();
         return true;
      }
      
      public function get requestCode() : String
      {
         return _requestCode;
      }
      
      public function get fulfilled() : Boolean
      {
         return _fulfilled;
      }
   }
}

