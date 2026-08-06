package com.sulake.habbo.communication.messages.parser.gifts
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PhoneCollectionStateParser implements IMessageParser
   {
      private var _phoneStatusCode:int;
      
      private var _collectionStatusCode:int;
      
      private var _millisecondsToAllowProcessReset:int;
      
      public function PhoneCollectionStateParser()
      {
         super();
      }
      
      public function get phoneStatusCode() : int
      {
         return _phoneStatusCode;
      }
      
      public function get collectionStatusCode() : int
      {
         return _collectionStatusCode;
      }
      
      public function get millisecondsToAllowProcessReset() : int
      {
         return _millisecondsToAllowProcessReset;
      }
      
      public function flush() : Boolean
      {
         _phoneStatusCode = -1;
         _millisecondsToAllowProcessReset = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _phoneStatusCode = param1.readInteger();
         _collectionStatusCode = param1.readInteger();
         _millisecondsToAllowProcessReset = param1.readInteger();
         return true;
      }
   }
}

