package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class FaqClientFaqsMessageParser implements IMessageParser
   {
      private var _urgentData:Map;
      
      private var _normalData:Map;
      
      public function FaqClientFaqsMessageParser()
      {
         super();
      }
      
      public function get urgentData() : Map
      {
         return _urgentData;
      }
      
      public function get normalData() : Map
      {
         return _normalData;
      }
      
      public function flush() : Boolean
      {
         if(_urgentData != null)
         {
            _urgentData.dispose();
         }
         _urgentData = null;
         if(_normalData != null)
         {
            _normalData.dispose();
         }
         _normalData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc5_:String = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _urgentData = new Map();
         _normalData = new Map();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.readInteger();
            _loc5_ = param1.readString();
            _urgentData.add(_loc2_,_loc5_);
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1.readInteger();
            _loc5_ = param1.readString();
            _normalData.add(_loc2_,_loc5_);
            _loc4_++;
         }
         return true;
      }
   }
}

