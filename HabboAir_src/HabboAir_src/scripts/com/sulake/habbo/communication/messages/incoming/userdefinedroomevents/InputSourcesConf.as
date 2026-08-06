package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class InputSourcesConf
   {
      public static const FURNI_SOURCE_FURNI_PICKS_1:int = 100;
      
      public static const FURNI_SOURCE_FURNI_PICKS_2:int = 101;
      
      public static const UnknownConstFromInputSourcesConf_Int_1:int = 110;
      
      private var UnknownVarFromInputSourcesConf_Array_1:Array;
      
      private var UnknownVarFromInputSourcesConf_Array_2:Array;
      
      private var _defaultFurniSources:Array;
      
      private var _defaultUserSources:Array;
      
      public function InputSourcesConf(param1:IMessageDataWrapper)
      {
         super();
         UnknownVarFromInputSourcesConf_Array_1 = readAllowedSources(param1);
         UnknownVarFromInputSourcesConf_Array_2 = readAllowedSources(param1);
         _defaultFurniSources = readDefaultSources(param1);
         _defaultUserSources = readDefaultSources(param1);
      }
      
      private static function readAllowedSources(param1:IMessageDataWrapper) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = [];
            _loc5_ = param1.readInteger();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_[_loc4_][_loc6_] = param1.readInteger();
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function readDefaultSources(param1:IMessageDataWrapper) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(param1.readInteger());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get amountFurniSelections() : int
      {
         return UnknownVarFromInputSourcesConf_Array_1.length;
      }
      
      public function getAllowedFurniSources(param1:int) : Array
      {
         return UnknownVarFromInputSourcesConf_Array_1[param1];
      }
      
      public function get amountUserSelections() : int
      {
         return UnknownVarFromInputSourcesConf_Array_2.length;
      }
      
      public function getAllowedUserSources(param1:int) : Array
      {
         return UnknownVarFromInputSourcesConf_Array_2[param1];
      }
      
      public function get defaultFurniSources() : Array
      {
         return _defaultFurniSources;
      }
      
      public function get defaultUserSources() : Array
      {
         return _defaultUserSources;
      }
      
      public function isUsingAdvancedSettings(param1:Array, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _defaultFurniSources.length)
         {
            _loc4_ = int(_defaultFurniSources[_loc5_]);
            if(_loc4_ != param1[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _defaultUserSources.length)
         {
            _loc3_ = int(_defaultUserSources[_loc5_]);
            if(_loc3_ != param2[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function allowFurniSelection() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < amountFurniSelections)
         {
            if(getAllowedFurniSources(_loc1_).indexOf(100) != -1 || getAllowedFurniSources(_loc1_).indexOf(101) != -1 || getAllowedFurniSources(_loc1_).indexOf(110) != -1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function isDualFurniPickingMode() : Boolean
      {
         var _loc1_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < amountFurniSelections)
         {
            if(getAllowedFurniSources(_loc1_).indexOf(100) != -1 || getAllowedFurniSources(_loc1_).indexOf(110) != -1)
            {
               _loc3_ = true;
            }
            if(getAllowedFurniSources(_loc1_).indexOf(101) != -1)
            {
               _loc2_ = true;
            }
            _loc1_++;
         }
         return _loc3_ && _loc2_;
      }
      
      public function isFurniSelectionDefault() : Boolean
      {
         return _defaultFurniSources.indexOf(100) != -1 || _defaultFurniSources.indexOf(101) != -1;
      }
   }
}

