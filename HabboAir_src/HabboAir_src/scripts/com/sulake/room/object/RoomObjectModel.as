package com.sulake.room.object
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class RoomObjectModel implements IRoomObjectModelController
   {
      private static const MAP_KEYS_PREFIX:String = "ROMC_MAP_KEYS_";
      
      private static const MAP_VALUES_PREFIX:String = "ROMC_MAP_VALUES_";
      
      private var UnknownVarFromRoomObjectModel_Dictionary_1:Dictionary;
      
      private var UnknownVarFromRoomObjectModel_Dictionary_2:Dictionary;
      
      private var UnknownVarFromRoomObjectModel_Dictionary_3:Dictionary;
      
      private var UnknownVarFromRoomObjectModel_Dictionary_4:Dictionary;
      
      private var UnknownVarFromRoomObjectModel_Array_1:Array;
      
      private var UnknownVarFromRoomObjectModel_Array_2:Array;
      
      private var UnknownVarFromRoomObjectModel_Array_3:Array;
      
      private var UnknownVarFromRoomObjectModel_Array_4:Array;
      
      private var _updateID:int;
      
      public function RoomObjectModel()
      {
         super();
         UnknownVarFromRoomObjectModel_Dictionary_1 = new Dictionary();
         UnknownVarFromRoomObjectModel_Dictionary_2 = new Dictionary();
         UnknownVarFromRoomObjectModel_Dictionary_3 = new Dictionary();
         UnknownVarFromRoomObjectModel_Dictionary_4 = new Dictionary();
         UnknownVarFromRoomObjectModel_Array_1 = [];
         UnknownVarFromRoomObjectModel_Array_2 = [];
         UnknownVarFromRoomObjectModel_Array_3 = [];
         UnknownVarFromRoomObjectModel_Array_4 = [];
         _updateID = 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         if(UnknownVarFromRoomObjectModel_Dictionary_1 != null)
         {
            for(_loc1_ in UnknownVarFromRoomObjectModel_Dictionary_1)
            {
               delete UnknownVarFromRoomObjectModel_Dictionary_1[_loc1_];
            }
            UnknownVarFromRoomObjectModel_Dictionary_1 = null;
         }
         if(UnknownVarFromRoomObjectModel_Dictionary_2 != null)
         {
            for(_loc1_ in UnknownVarFromRoomObjectModel_Dictionary_2)
            {
               delete UnknownVarFromRoomObjectModel_Dictionary_2[_loc1_];
            }
            UnknownVarFromRoomObjectModel_Dictionary_2 = null;
         }
         if(UnknownVarFromRoomObjectModel_Dictionary_3 != null)
         {
            for(_loc1_ in UnknownVarFromRoomObjectModel_Dictionary_3)
            {
               delete UnknownVarFromRoomObjectModel_Dictionary_3[_loc1_];
            }
            UnknownVarFromRoomObjectModel_Dictionary_3 = null;
         }
         if(UnknownVarFromRoomObjectModel_Dictionary_4 != null)
         {
            for(_loc1_ in UnknownVarFromRoomObjectModel_Dictionary_4)
            {
               delete UnknownVarFromRoomObjectModel_Dictionary_4[_loc1_];
            }
            UnknownVarFromRoomObjectModel_Dictionary_4 = null;
         }
         UnknownVarFromRoomObjectModel_Array_2 = [];
         UnknownVarFromRoomObjectModel_Array_1 = [];
         UnknownVarFromRoomObjectModel_Array_4 = [];
         UnknownVarFromRoomObjectModel_Array_3 = [];
      }
      
      public function hasNumber(param1:String) : Boolean
      {
         return UnknownVarFromRoomObjectModel_Dictionary_1[param1] != null;
      }
      
      public function hasNumberArray(param1:String) : Boolean
      {
         return UnknownVarFromRoomObjectModel_Dictionary_3[param1] != null;
      }
      
      public function hasString(param1:String) : Boolean
      {
         return UnknownVarFromRoomObjectModel_Dictionary_2[param1] != null;
      }
      
      public function hasStringArray(param1:String) : Boolean
      {
         return UnknownVarFromRoomObjectModel_Dictionary_4[param1] != null;
      }
      
      public function getNumber(param1:String) : Number
      {
         return UnknownVarFromRoomObjectModel_Dictionary_1[param1];
      }
      
      public function getString(param1:String) : String
      {
         return UnknownVarFromRoomObjectModel_Dictionary_2[param1];
      }
      
      public function getNumberArray(param1:String) : Array
      {
         var _loc2_:Array = UnknownVarFromRoomObjectModel_Dictionary_3[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringArray(param1:String) : Array
      {
         var _loc2_:Array = UnknownVarFromRoomObjectModel_Dictionary_4[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringToStringMap(param1:String) : Map
      {
         var _loc4_:int = 0;
         var _loc5_:Map = new Map();
         var _loc2_:Array = getStringArray("ROMC_MAP_KEYS_" + param1);
         var _loc3_:Array = getStringArray("ROMC_MAP_VALUES_" + param1);
         if(_loc2_ != null && _loc3_ != null && _loc2_.length == _loc3_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_.add(_loc2_[_loc4_],_loc3_[_loc4_]);
               _loc4_++;
            }
         }
         return _loc5_;
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(UnknownVarFromRoomObjectModel_Array_1.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomObjectModel_Array_1.push(param1);
         }
         if(UnknownVarFromRoomObjectModel_Dictionary_1[param1] != param2)
         {
            UnknownVarFromRoomObjectModel_Dictionary_1[param1] = param2;
            _updateID++;
         }
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(UnknownVarFromRoomObjectModel_Array_2.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomObjectModel_Array_2.push(param1);
         }
         if(UnknownVarFromRoomObjectModel_Dictionary_2[param1] != param2)
         {
            UnknownVarFromRoomObjectModel_Dictionary_2[param1] = param2;
            _updateID++;
         }
      }
      
      public function setNumberArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(UnknownVarFromRoomObjectModel_Array_3.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomObjectModel_Array_3.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is Number)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = UnknownVarFromRoomObjectModel_Dictionary_3[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as Number != _loc5_[_loc7_] as Number)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         UnknownVarFromRoomObjectModel_Dictionary_3[param1] = _loc6_;
         _updateID++;
      }
      
      public function setStringArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(UnknownVarFromRoomObjectModel_Array_4.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            UnknownVarFromRoomObjectModel_Array_4.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is String)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = UnknownVarFromRoomObjectModel_Dictionary_4[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as String != _loc5_[_loc7_] as String)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         UnknownVarFromRoomObjectModel_Dictionary_4[param1] = _loc6_;
         _updateID++;
      }
      
      public function setStringToStringMap(param1:String, param2:Map, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         setStringArray("ROMC_MAP_KEYS_" + param1,param2.getKeys(),param3);
         setStringArray("ROMC_MAP_VALUES_" + param1,param2.getValues(),param3);
      }
      
      public function getUpdateID() : int
      {
         return _updateID;
      }
   }
}

