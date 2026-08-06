package com.sulake.habbo.help.cfh.registry.instantmessage
{
   import com.sulake.core.utils.Map;
   
   public class InstantMessageRegistry
   {
      private static const ITEMS_TO_PURGE:int = 5;
      
      private static const MAX_MESSAGES_TO_STORE:int = 20;
      
      private var _registry:Map;
      
      private var UnknownVarFromInstantMessageRegistry_Int_1:int = 0;
      
      private var UnknownVarFromInstantMessageRegistry_Int_2:int = 0;
      
      private var _holdPurges:Boolean;
      
      public function InstantMessageRegistry()
      {
         super();
         _registry = new Map();
      }
      
      public function addItem(param1:int, param2:String, param3:String) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:* = undefined;
         if(_registry.hasKey(param1))
         {
            _loc5_ = _registry.getValue(param1);
            _loc5_.push(new InstantMessageRegistryItem(UnknownVarFromInstantMessageRegistry_Int_1++,param1,param2,param3));
            _registry.remove(param1);
            _registry.add(param1,_loc5_);
         }
         else
         {
            _loc4_ = new Vector.<InstantMessageRegistryItem>();
            _loc4_.push(new InstantMessageRegistryItem(UnknownVarFromInstantMessageRegistry_Int_1++,param1,param2,param3));
            _registry.add(param1,_loc4_);
         }
         UnknownVarFromInstantMessageRegistry_Int_2++;
         if(UnknownVarFromInstantMessageRegistry_Int_2 % 3 == 0)
         {
            purgeRegistry();
         }
      }
      
      private function purgeRegistry() : void
      {
         var _loc4_:int = 0;
         var _loc1_:* = undefined;
         var _loc3_:* = undefined;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         if(_holdPurges)
         {
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _registry.length)
         {
            _loc1_ = _registry.getWithIndex(_loc4_);
            _loc3_ = new Vector.<InstantMessageRegistryItem>(0);
            if(_loc1_ && _loc1_.length > 0)
            {
               _loc7_ = _loc1_[0].userId;
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  _loc5_ = new Date().time - _loc1_[_loc6_].chatTime.time;
                  _loc2_ = _loc5_ / 65500;
                  if(_loc2_ <= 15)
                  {
                     _loc3_.push(_loc1_[_loc6_]);
                  }
                  _loc6_++;
               }
               if(_loc3_.length > 20)
               {
                  _loc3_.splice(0,_loc3_.length - (20 - 5));
               }
               _loc1_.splice(0,_loc1_.length);
               _loc1_ = _loc1_.concat(_loc3_);
               _registry.remove(_loc7_);
               _registry.add(_loc7_,_loc1_);
            }
            _loc4_++;
         }
      }
      
      public function set holdPurges(param1:Boolean) : void
      {
         _holdPurges = param1;
      }
      
      public function getItemsByUser(param1:int) : Vector.<InstantMessageRegistryItem>
      {
         return _registry.getValue(param1);
      }
      
      public function hasUserChatted(param1:int) : Boolean
      {
         var _loc2_:Vector.<InstantMessageRegistryItem> = getItemsByUser(param1);
         if(_loc2_)
         {
            return getItemsByUser(param1).length > 0;
         }
         return false;
      }
      
      public function hasContent() : Boolean
      {
         return _registry.length > 0;
      }
      
      public function getItems() : Map
      {
         return _registry;
      }
      
      public function getItem(param1:int, param2:uint) : InstantMessageRegistryItem
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<InstantMessageRegistryItem> = getItemsByUser(param1);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].index == param2)
            {
               return _loc3_[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
   }
}

