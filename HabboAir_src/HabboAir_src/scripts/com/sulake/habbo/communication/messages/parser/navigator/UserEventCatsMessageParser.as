package com.sulake.habbo.communication.messages.parser.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.navigator.EventCategory;
   
   [SecureSWF(rename="true")]
   public class UserEventCatsMessageParser implements IMessageParser
   {
      private var _eventCategories:Array;
      
      public function UserEventCatsMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _eventCategories = [];
         var _loc3_:int = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _eventCategories.push(new EventCategory(param1));
            _loc2_++;
         }
         return true;
      }
      
      public function flush() : Boolean
      {
         _eventCategories = null;
         return true;
      }
      
      public function get eventCategories() : Array
      {
         return _eventCategories;
      }
   }
}

