package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class SharedGlobalPlaceholderList
   {
      private var _sharedPlaceholders:Vector.<SharedGlobalPlaceholder>;
      
      public function SharedGlobalPlaceholderList(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _sharedPlaceholders = new Vector.<SharedGlobalPlaceholder>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _sharedPlaceholders.push(new SharedGlobalPlaceholder(param1));
            _loc3_++;
         }
      }
      
      public function get sharedPlaceholders() : Vector.<SharedGlobalPlaceholder>
      {
         return _sharedPlaceholders;
      }
   }
}

