package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.CategoriesWithVisitorCountData;
   
   [SecureSWF(rename="true")]
   public class CategoriesWithVisitorCountParser implements IMessageParser
   {
      private var _data:CategoriesWithVisitorCountData;
      
      public function CategoriesWithVisitorCountParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new CategoriesWithVisitorCountData(param1);
         return true;
      }
      
      public function get data() : CategoriesWithVisitorCountData
      {
         return _data;
      }
   }
}

