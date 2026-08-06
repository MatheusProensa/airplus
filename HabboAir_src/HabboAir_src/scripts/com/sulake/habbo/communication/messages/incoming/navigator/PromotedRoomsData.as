package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PromotedRoomsData implements IComponentInterfaceQueue, UnknownIHabboCommunicationMessagesIncomingNavigator1
   {
      private var _entries:Array;
      
      private var _disposed:Boolean;
      
      public function PromotedRoomsData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         _entries = [];
         super();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _entries.push(new PromotedRoomCategoryData(param1));
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
         if(_entries != null)
         {
            for each(var _loc1_ in _entries)
            {
               _loc1_.dispose();
            }
         }
         _entries = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get entries() : Array
      {
         return _entries;
      }
   }
}

