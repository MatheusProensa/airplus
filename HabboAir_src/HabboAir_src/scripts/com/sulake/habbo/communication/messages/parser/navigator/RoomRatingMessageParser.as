package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomRatingMessageParser implements IMessageParser
   {
      private var _rating:int;
      
      private var _canRate:Boolean;
      
      public function RoomRatingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._rating = param1.readInteger();
         this._canRate = param1.readBoolean();
         return true;
      }
      
      public function get rating() : int
      {
         return _rating;
      }
      
      public function get canRate() : Boolean
      {
         return _canRate;
      }
   }
}

