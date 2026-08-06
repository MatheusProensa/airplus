package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FlatCreatedMessageParser implements IMessageParser
   {
      private var _flatId:int;
      
      private var _flatName:String;
      
      public function FlatCreatedMessageParser()
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
         this._flatName = param1.readString();
         Logger.log("FLAT CREATED: " + this._flatId + ", " + this._flatName);
         return true;
      }
      
      public function get flatId() : int
      {
         return _flatId;
      }
      
      public function get flatName() : String
      {
         return _flatName;
      }
   }
}

