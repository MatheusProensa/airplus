package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.actions.IActiveActionData;
   
   public class AvatarImageBodyPartCache
   {
      private var _cache:Map;
      
      private var _action:IActiveActionData;
      
      private var _direction:int;
      
      private var _disposed:Boolean;
      
      public function AvatarImageBodyPartCache()
      {
         super();
         _cache = new Map();
      }
      
      public function setAction(param1:IActiveActionData, param2:int) : void
      {
         if(_action == null)
         {
            _action = param1;
         }
         var _loc3_:AvatarImageActionCache = getActionCache(_action);
         if(_loc3_ != null)
         {
            _loc3_.setLastAccessTime(param2);
         }
         _action = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         var _loc3_:AvatarImageActionCache = null;
         if(_disposed)
         {
            return;
         }
         if(_cache)
         {
            _loc1_ = _cache.getKeys();
            for each(var _loc2_ in _loc1_)
            {
               _loc3_ = _cache.getValue(_loc2_) as AvatarImageActionCache;
               if(_loc3_)
               {
                  _loc3_.dispose();
               }
            }
            _cache.dispose();
            _cache = null;
         }
         _action = null;
         _direction = 0;
         _disposed = true;
      }
      
      public function disposeActions(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:AvatarImageActionCache = null;
         var _loc6_:* = null;
         if(_cache == null || _disposed)
         {
            return;
         }
         var _loc4_:Array = _cache.getKeys();
         for each(_loc6_ in _loc4_)
         {
            _loc5_ = _cache.getValue(_loc6_) as AvatarImageActionCache;
            if(_loc5_ != null)
            {
               _loc3_ = _loc5_.getLastAccessTime();
               if(param2 - _loc3_ >= param1)
               {
                  _loc5_.dispose();
                  _cache.remove(_loc6_);
               }
            }
         }
      }
      
      public function getAction() : IActiveActionData
      {
         return _action;
      }
      
      public function setDirection(param1:int) : void
      {
         _direction = param1;
      }
      
      public function getDirection() : int
      {
         return _direction;
      }
      
      public function getActionCache(param1:IActiveActionData = null) : AvatarImageActionCache
      {
         if(!_action)
         {
            return null;
         }
         if(param1 == null)
         {
            param1 = _action;
         }
         if(param1.overridingAction != null)
         {
            return _cache.getValue(param1.overridingAction) as AvatarImageActionCache;
         }
         return _cache.getValue(param1.id) as AvatarImageActionCache;
      }
      
      public function updateActionCache(param1:IActiveActionData, param2:AvatarImageActionCache) : void
      {
         if(param1.overridingAction != null)
         {
            _cache.add(param1.overridingAction,param2);
         }
         else
         {
            _cache.add(param1.id,param2);
         }
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}

