package com.sulake.habbo.help.cfh.registry.user
{
   import com.sulake.core.utils.Map;
   
   public class UserRegistry
   {
      private static const MAX_USERS_TO_STORE:int = 80;
      
      private var _registry:Map = new Map();
      
      private var _roomName:String = "";
      
      private var _roomId:int;
      
      private var UnknownVarFromUserRegistry_Array_1:Array = [];
      
      public function UserRegistry()
      {
         super();
      }
      
      public function getRegistry() : Map
      {
         return _registry;
      }
      
      public function getEntry(param1:int) : UserRegistryItem
      {
         return _registry[param1];
      }
      
      public function registerRoom(param1:int, param2:String) : void
      {
         _roomId = param1;
         _roomName = param2;
         if(_roomName != "")
         {
            addRoomNameForMissing();
         }
      }
      
      public function registerUser(param1:int, param2:String, param3:String = "") : void
      {
         var _loc4_:UserRegistryItem = null;
         if(_registry.getValue(param1) != null)
         {
            _registry.remove(param1);
         }
         _loc4_ = new UserRegistryItem(param1,param2,param3,_roomId,_roomName);
         if(_roomName == "")
         {
            UnknownVarFromUserRegistry_Array_1.push(param1);
         }
         _registry.add(param1,_loc4_);
         purgeUserIndex();
      }
      
      private function purgeUserIndex() : void
      {
         var _loc1_:int = 0;
         while(_registry.length > 80)
         {
            _loc1_ = _registry.getKey(0);
            _registry.remove(_loc1_);
         }
      }
      
      private function addRoomNameForMissing() : void
      {
         var _loc1_:UserRegistryItem = null;
         while(UnknownVarFromUserRegistry_Array_1.length > 0)
         {
            _loc1_ = _registry.getValue(UnknownVarFromUserRegistry_Array_1.shift());
            if(_loc1_ != null && _loc1_.roomId == _roomId)
            {
               _loc1_.roomName = _roomName;
            }
         }
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

