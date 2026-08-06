package com.sulake.habbo.avatar.geometry
{
   import flash.utils.Dictionary;
   
   public class AvatarSet
   {
      private var _id:String;
      
      private var UnknownVarFromAvatarSet_Dictionary_1:Dictionary;
      
      private var UnknownVarFromAvatarSet_Array_1:Array;
      
      private var UnknownVarFromAvatarSet_Array_2:Array;
      
      private var _isMain:Boolean;
      
      public function AvatarSet(param1:XML)
      {
         var _loc4_:AvatarSet = null;
         super();
         _id = String(param1.@id);
         var _loc3_:String = String(param1.@main);
         _isMain = _loc3_ == null ? false : Boolean(parseInt(_loc3_));
         UnknownVarFromAvatarSet_Dictionary_1 = new Dictionary();
         UnknownVarFromAvatarSet_Array_1 = [];
         for each(var _loc6_ in param1.avatarset)
         {
            _loc4_ = new AvatarSet(_loc6_);
            UnknownVarFromAvatarSet_Dictionary_1[String(_loc6_.@id)] = _loc4_;
         }
         for each(var _loc2_ in param1.bodypart)
         {
            UnknownVarFromAvatarSet_Array_1.push(String(_loc2_.@id));
         }
         var _loc5_:Array = UnknownVarFromAvatarSet_Array_1.concat();
         for each(_loc4_ in UnknownVarFromAvatarSet_Dictionary_1)
         {
            _loc5_ = _loc5_.concat(_loc4_.getBodyParts());
         }
         UnknownVarFromAvatarSet_Array_2 = _loc5_;
      }
      
      public function findAvatarSet(param1:String) : AvatarSet
      {
         if(param1 == _id)
         {
            return this;
         }
         for each(var _loc2_ in UnknownVarFromAvatarSet_Dictionary_1)
         {
            if(_loc2_.findAvatarSet(param1) != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBodyParts() : Array
      {
         return UnknownVarFromAvatarSet_Array_2.concat();
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get isMain() : Boolean
      {
         if(_isMain)
         {
            return true;
         }
         for each(var _loc1_ in UnknownVarFromAvatarSet_Dictionary_1)
         {
            if(_loc1_.isMain)
            {
               return true;
            }
         }
         return false;
      }
   }
}

