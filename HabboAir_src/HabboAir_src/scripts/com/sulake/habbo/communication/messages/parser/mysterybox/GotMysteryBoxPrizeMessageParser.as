package com.sulake.habbo.communication.messages.parser.mysterybox
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GotMysteryBoxPrizeMessageParser implements IMessageParser
   {
      private var _contentType:String;
      
      private var _classId:int;
      
      public function GotMysteryBoxPrizeMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _contentType = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _contentType = param1.readString();
         _classId = param1.readInteger();
         return true;
      }
      
      public function get contentType() : String
      {
         return _contentType;
      }
      
      public function get classId() : int
      {
         return _classId;
      }
   }
}

