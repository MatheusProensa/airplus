package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   
   public class AvatarFigureContainer implements IAvatarFigureContainer
   {
      private var UnknownVarFromAvatarFigureContainer_Map_1:Map;
      
      public function AvatarFigureContainer(param1:String)
      {
         super();
         UnknownVarFromAvatarFigureContainer_Map_1 = new Map();
         parseFigureString(param1);
      }
      
      public function getPartTypeIds() : Array
      {
         return getParts().getKeys();
      }
      
      public function hasPartType(param1:String) : Boolean
      {
         return getParts().getValue(param1) != null;
      }
      
      public function getPartSetId(param1:String) : int
      {
         var _loc2_:Map = getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("setid") as int;
         }
         return 0;
      }
      
      public function getPartColorIds(param1:String) : Array
      {
         var _loc2_:Map = getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("colorids") as Array;
         }
         return null;
      }
      
      public function updatePart(param1:String, param2:int, param3:Array) : void
      {
         var _loc4_:Map = new Map();
         _loc4_.add("type",param1);
         _loc4_.add("setid",param2);
         _loc4_.add("colorids",param3);
         var _loc5_:Map = getParts();
         _loc5_.remove(param1);
         _loc5_.add(param1,_loc4_);
      }
      
      public function removePart(param1:String) : void
      {
         getParts().remove(param1);
      }
      
      public function getFigureString() : String
      {
         var _loc3_:Array = null;
         var _loc1_:Array = [];
         for each(var _loc2_ in getParts().getKeys())
         {
            _loc3_ = [];
            _loc3_.push(_loc2_);
            _loc3_.push(getPartSetId(_loc2_));
            _loc3_ = _loc3_.concat(getPartColorIds(_loc2_));
            _loc1_.push(_loc3_.join("-"));
         }
         return _loc1_.join(".");
      }
      
      private function getParts() : Map
      {
         if(UnknownVarFromAvatarFigureContainer_Map_1 == null)
         {
            UnknownVarFromAvatarFigureContainer_Map_1 = new Map();
         }
         return UnknownVarFromAvatarFigureContainer_Map_1;
      }
      
      private function parseFigureString(param1:String) : void
      {
         var _loc3_:Array = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc2_:Array = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            param1 = "";
         }
         for each(var _loc7_ in param1.split("."))
         {
            _loc3_ = _loc7_.split("-");
            if(_loc3_.length >= 2)
            {
               _loc6_ = String(_loc3_[0]);
               _loc4_ = parseInt(_loc3_[1]);
               _loc2_ = [];
               _loc5_ = 2;
               while(_loc5_ < _loc3_.length)
               {
                  _loc2_.push(parseInt(_loc3_[_loc5_]));
                  _loc5_++;
               }
               updatePart(_loc6_,_loc4_,_loc2_);
            }
         }
      }
   }
}

