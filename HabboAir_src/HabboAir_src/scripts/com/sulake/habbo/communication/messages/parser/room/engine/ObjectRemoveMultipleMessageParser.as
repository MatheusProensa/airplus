package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMultipleMessageParser implements IMessageParser
   {
      private var _ids:Array;
      
      private var _pickerId:int;
      
      public function ObjectRemoveMultipleMessageParser()
      {
         super();
      }
      
      public function get ids() : Array
      {
         return _ids;
      }
      
      public function get pickerId() : int
      {
         return _pickerId;
      }
      
      public function flush() : Boolean
      {
         _ids = [];
         _pickerId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = param1.readInteger();
         _ids = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            ids.push(param1.readInteger());
            _loc3_++;
         }
         _pickerId = param1.readInteger();
         return true;
      }
   }
}

