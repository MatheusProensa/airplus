package com.sulake.habbo.communication.messages.parser.newnavigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollapsedCategoriesMessageParser implements IMessageParser
   {
      private var _collapsedCategories:Vector.<String>;
      
      public function CollapsedCategoriesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _collapsedCategories = new Vector.<String>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _collapsedCategories.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get collapsedCategories() : Vector.<String>
      {
         return _collapsedCategories;
      }
   }
}

