package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BuildersClubFurniCountMessageParser implements IMessageParser
   {
      private var _furniCount:int;
      
      public function BuildersClubFurniCountMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _furniCount = param1.readInteger();
         return true;
      }
      
      public function get furniCount() : int
      {
         return _furniCount;
      }
   }
}

