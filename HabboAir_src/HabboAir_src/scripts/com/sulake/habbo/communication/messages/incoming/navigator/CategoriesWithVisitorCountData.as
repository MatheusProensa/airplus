package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class CategoriesWithVisitorCountData implements IComponentInterfaceQueue, UnknownIHabboCommunicationMessagesIncomingNavigator1
   {
      private var _categoryToCurrentUserCountMap:Map;
      
      private var _categoryToMaxUserCountMap:Map;
      
      private var _disposed:Boolean;
      
      public function CategoriesWithVisitorCountData(param1:IMessageDataWrapper)
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _categoryToCurrentUserCountMap = new Map();
         _categoryToMaxUserCountMap = new Map();
         super();
         var _loc4_:int = param1.readInteger();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.readInteger();
            _loc3_ = param1.readInteger();
            _loc2_ = param1.readInteger();
            _categoryToCurrentUserCountMap.add(_loc6_,_loc3_);
            _categoryToMaxUserCountMap.add(_loc6_,_loc2_);
            _loc5_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this._categoryToCurrentUserCountMap = null;
         this._categoryToMaxUserCountMap = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get categoryToCurrentUserCountMap() : Map
      {
         return _categoryToCurrentUserCountMap;
      }
      
      public function get categoryToMaxUserCountMap() : Map
      {
         return _categoryToMaxUserCountMap;
      }
   }
}

