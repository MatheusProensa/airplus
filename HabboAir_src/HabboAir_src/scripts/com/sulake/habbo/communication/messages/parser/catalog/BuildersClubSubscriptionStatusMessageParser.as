package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubSubscriptionStatusMessageParser implements IMessageParser
   {
      private var _secondsLeft:int;
      
      private var _furniLimit:int;
      
      private var _maxFurniLimit:int;
      
      private var _secondsLeftWithGrace:int;
      
      public function BuildersClubSubscriptionStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _secondsLeft = param1.readInteger();
         _furniLimit = param1.readInteger();
         _maxFurniLimit = param1.readInteger();
         if(param1.bytesAvailable)
         {
            _secondsLeftWithGrace = param1.readInteger();
         }
         else
         {
            _secondsLeftWithGrace = _secondsLeft;
         }
         return true;
      }
      
      public function get secondsLeft() : int
      {
         return _secondsLeft;
      }
      
      public function get furniLimit() : int
      {
         return _furniLimit;
      }
      
      public function get maxFurniLimit() : int
      {
         return _maxFurniLimit;
      }
      
      public function get secondsLeftWithGrace() : int
      {
         return _secondsLeftWithGrace;
      }
   }
}

