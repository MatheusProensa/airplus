package com.sulake.habbo.avatar.structure.figure
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class SetType implements ISetType
   {
      private var _partSets:Map;
      
      private var _type:String;
      
      private var _paletteID:int;
      
      private var UnknownVarFromSetType_Dictionary_1:Dictionary;
      
      public function SetType(param1:XML)
      {
         super();
         _type = String(param1.@type);
         _paletteID = parseInt(param1.@paletteid);
         UnknownVarFromSetType_Dictionary_1 = new Dictionary();
         UnknownVarFromSetType_Dictionary_1["F"] = [];
         UnknownVarFromSetType_Dictionary_1["M"] = [];
         UnknownVarFromSetType_Dictionary_1["F"][0] = Boolean(parseInt(param1.@mand_f_0));
         UnknownVarFromSetType_Dictionary_1["F"][1] = Boolean(parseInt(param1.@mand_f_1));
         UnknownVarFromSetType_Dictionary_1["M"][0] = Boolean(parseInt(param1.@mand_m_0));
         UnknownVarFromSetType_Dictionary_1["M"][1] = Boolean(parseInt(param1.@mand_m_1));
         _partSets = new Map();
         append(param1);
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in _partSets.getValues())
         {
            _loc1_.dispose();
         }
         _partSets.dispose();
         _partSets = null;
      }
      
      public function cleanUp(param1:XML) : void
      {
         var _loc3_:String = null;
         var _loc2_:FigurePartSet = null;
         for each(var _loc4_ in param1["set"])
         {
            _loc3_ = String(_loc4_.@id);
            _loc2_ = _partSets.getValue(_loc3_);
            if(_loc2_ != null)
            {
               _loc2_.dispose();
               _partSets.remove(_loc3_);
            }
         }
      }
      
      public function append(param1:XML) : void
      {
         for each(var _loc2_ in param1["set"])
         {
            _partSets.add(String(_loc2_.@id),new FigurePartSet(_loc2_,_type));
         }
      }
      
      public function getDefaultPartSet(param1:String) : IFigurePartSet
      {
         var _loc4_:int = 0;
         var _loc2_:IFigurePartSet = null;
         var _loc3_:Array = _partSets.getKeys();
         _loc4_ = _loc3_.length - 1;
         while(_loc4_ >= 0)
         {
            _loc2_ = _partSets.getValue(_loc3_[_loc4_]);
            if(_loc2_ && _loc2_.clubLevel == 0 && (_loc2_.gender == param1 || _loc2_.gender == "U"))
            {
               return _loc2_;
            }
            _loc4_--;
         }
         return null;
      }
      
      public function getPartSet(param1:int) : IFigurePartSet
      {
         return _partSets.getValue(String(param1));
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get paletteID() : int
      {
         return _paletteID;
      }
      
      public function isMandatory(param1:String, param2:int) : Boolean
      {
         if(param1 == null || param1.length == 0)
         {
            return false;
         }
         var _loc4_:String = param1.toUpperCase();
         var _loc3_:Array = UnknownVarFromSetType_Dictionary_1[_loc4_] as Array;
         if(_loc3_ == null)
         {
            return false;
         }
         return _loc3_[Math.min(param2,1)];
      }
      
      public function optionalFromClubLevel(param1:String) : int
      {
         if(param1 == null || param1.length == 0)
         {
            return -1;
         }
         var _loc2_:Array = UnknownVarFromSetType_Dictionary_1[param1.toUpperCase()];
         if(_loc2_ == null)
         {
            return -1;
         }
         return _loc2_.indexOf(false);
      }
      
      public function get partSets() : Map
      {
         return _partSets;
      }
   }
}

