package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FavouriteChangedMessageParser implements IMessageParser
   {
      private var _flatId:int;
      
      private var _added:Boolean;
      
      public function FavouriteChangedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._flatId = param1.readInteger();
         this._added = param1.readBoolean();
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get added() : Boolean
      {
         return _added;
      }
   }
}

