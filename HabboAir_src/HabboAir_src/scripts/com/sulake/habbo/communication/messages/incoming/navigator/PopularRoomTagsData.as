package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PopularRoomTagsData implements IComponentInterfaceQueue, UnknownIHabboCommunicationMessagesIncomingNavigator1
   {
      private var _tags:Array;
      
      private var _disposed:Boolean;
      
      public function PopularRoomTagsData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _tags = [];
         super();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _tags.push(new PopularTagData(param1));
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this._tags = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get tags() : Array
      {
         return _tags;
      }
   }
}

