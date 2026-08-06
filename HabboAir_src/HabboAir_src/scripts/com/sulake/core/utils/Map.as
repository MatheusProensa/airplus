package com.sulake.core.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   use namespace flash_proxy;
   
   [SecureSWF(rename="true")]
   public class Map extends Proxy implements IComponentInterfaceQueue
   {
      private var _length:uint;
      
      private var UnknownVarFromMap_Dictionary_1:Dictionary;
      
      private var UnknownVarFromMap_Array_1:Array;
      
      private var UnknownVarFromMap_Array_2:Array;
      
      public function Map()
      {
         super();
         _length = 0;
         UnknownVarFromMap_Dictionary_1 = new Dictionary();
         UnknownVarFromMap_Array_1 = [];
         UnknownVarFromMap_Array_2 = [];
      }
      
      public function get length() : uint
      {
         return _length;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromMap_Dictionary_1 == null;
      }
      
      public function dispose() : void
      {
         UnknownVarFromMap_Dictionary_1 = null;
         _length = 0;
         UnknownVarFromMap_Array_1 = null;
         UnknownVarFromMap_Array_2 = null;
      }
      
      public function reset() : void
      {
         UnknownVarFromMap_Dictionary_1 = new Dictionary();
         _length = 0;
         UnknownVarFromMap_Array_1 = [];
         UnknownVarFromMap_Array_2 = [];
      }
      
      public function unshift(param1:*, param2:*) : Boolean
      {
         if(UnknownVarFromMap_Dictionary_1[param1] != null)
         {
            return false;
         }
         UnknownVarFromMap_Dictionary_1[param1] = param2;
         UnknownVarFromMap_Array_1.unshift(param2);
         UnknownVarFromMap_Array_2.unshift(param1);
         _length++;
         return true;
      }
      
      public function add(param1:*, param2:*) : Boolean
      {
         if(UnknownVarFromMap_Dictionary_1[param1] != null)
         {
            return false;
         }
         UnknownVarFromMap_Dictionary_1[param1] = param2;
         UnknownVarFromMap_Array_1[_length] = param2;
         UnknownVarFromMap_Array_2[_length] = param1;
         _length++;
         return true;
      }
      
      public function replace(param1:*, param2:*) : Boolean
      {
         if(UnknownVarFromMap_Dictionary_1[param1] == null)
         {
            return false;
         }
         var _loc3_:int = int(UnknownVarFromMap_Array_2.indexOf(param1));
         UnknownVarFromMap_Dictionary_1[param1] = param2;
         UnknownVarFromMap_Array_1[_loc3_] = param2;
         return true;
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:Object = UnknownVarFromMap_Dictionary_1[param1];
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:int = int(UnknownVarFromMap_Array_2.indexOf(param1));
         if(_loc3_ >= 0)
         {
            UnknownVarFromMap_Array_1.splice(_loc3_,1);
            UnknownVarFromMap_Array_2.splice(_loc3_,1);
            _length--;
         }
         delete UnknownVarFromMap_Dictionary_1[param1];
         return _loc2_;
      }
      
      public function getWithIndex(param1:int) : *
      {
         if(param1 < 0 || param1 >= _length)
         {
            return null;
         }
         return UnknownVarFromMap_Array_1[param1];
      }
      
      public function getKey(param1:int) : *
      {
         if(param1 < 0 || param1 >= _length)
         {
            return null;
         }
         return UnknownVarFromMap_Array_2[param1];
      }
      
      public function getValueByIndex(param1:int) : *
      {
         if(param1 < 0 || param1 >= _length)
         {
            return null;
         }
         return UnknownVarFromMap_Array_1[param1];
      }
      
      public function getKeys() : Array
      {
         return UnknownVarFromMap_Array_2.slice();
      }
      
      public function hasKey(param1:*) : Boolean
      {
         return param1 in UnknownVarFromMap_Dictionary_1;
      }
      
      public function getValue(param1:*) : *
      {
         return UnknownVarFromMap_Dictionary_1[param1];
      }
      
      public function getValues() : Array
      {
         return UnknownVarFromMap_Array_1.slice();
      }
      
      public function hasValue(param1:*) : Boolean
      {
         return UnknownVarFromMap_Array_1.indexOf(param1) > -1;
      }
      
      public function indexOf(param1:*) : int
      {
         return UnknownVarFromMap_Array_1.indexOf(param1);
      }
      
      public function concatenate(param1:Map) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = param1.UnknownVarFromMap_Array_2;
         for each(_loc3_ in _loc2_)
         {
            add(_loc3_,param1[_loc3_]);
         }
      }
      
      public function clone() : Map
      {
         var _loc1_:Map = new Map();
         _loc1_.concatenate(this);
         return _loc1_;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         if(param1 is QName)
         {
            param1 = QName(param1).localName;
         }
         return UnknownVarFromMap_Dictionary_1[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(param1 is QName)
         {
            param1 = QName(param1).localName;
         }
         UnknownVarFromMap_Dictionary_1[param1] = param2;
         var _loc3_:int = int(UnknownVarFromMap_Array_2.indexOf(param1));
         if(_loc3_ == -1)
         {
            UnknownVarFromMap_Array_1[_length] = param2;
            UnknownVarFromMap_Array_2[_length] = param1;
            _length++;
         }
         else
         {
            UnknownVarFromMap_Array_1.splice(_loc3_,1,param2);
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < _length ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return UnknownVarFromMap_Array_2[param1 - 1];
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return UnknownVarFromMap_Array_1[param1 - 1];
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return param1.localName == "toString" ? "Map" : null;
      }
   }
}

