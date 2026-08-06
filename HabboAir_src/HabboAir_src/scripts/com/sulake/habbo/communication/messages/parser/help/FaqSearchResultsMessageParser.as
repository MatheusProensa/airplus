package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class FaqSearchResultsMessageParser implements IMessageParser
   {
      private var _data:Map;
      
      public function FaqSearchResultsMessageParser()
      {
         super();
      }
      
      public function get data() : Map
      {
         return _data;
      }
      
      public function flush() : Boolean
      {
         if(_data != null)
         {
            _data.dispose();
         }
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:int = 0;
         _data = new Map();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.readInteger();
            _loc5_ = param1.readString();
            _data.add(_loc2_,_loc5_);
            _loc4_++;
         }
         return true;
      }
   }
}

