package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.WiredContext;
   
   [SecureSWF(rename="true")]
   public class Triggerable
   {
      private var _furniLimit:int;
      
      private var _stuffIds:Array;
      
      private var _stuffIds2:Array;
      
      private var _id:int;
      
      private var _stringParam:String;
      
      private var _intParams:Array;
      
      private var _variableIds:Array;
      
      private var _stuffTypeId:int;
      
      private var _code:int;
      
      private var _furniSourceTypes:Array;
      
      private var _userSourceTypes:Array;
      
      private var _advancedMode:Boolean;
      
      private var _inputSourcesConf:InputSourcesConf;
      
      private var _allowWallFurni:Boolean;
      
      private var _wiredContext:WiredContext;
      
      private var _defaultIntParams:Array;
      
      public function Triggerable(param1:IMessageDataWrapper)
      {
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc10_:int = 0;
         _stuffIds = [];
         _stuffIds2 = [];
         _intParams = [];
         _variableIds = [];
         _furniSourceTypes = [];
         _userSourceTypes = [];
         _defaultIntParams = [];
         super();
         _furniLimit = param1.readInteger();
         var _loc9_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc2_ = param1.readInteger();
            _stuffIds.push(_loc2_);
            _loc7_++;
         }
         var _loc3_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc10_ = param1.readInteger();
            _stuffIds2.push(_loc10_);
            _loc7_++;
         }
         _stuffTypeId = param1.readInteger();
         _id = param1.readInteger();
         _stringParam = param1.readString();
         var _loc4_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _intParams.push(param1.readInteger());
            _loc7_++;
         }
         var _loc6_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _variableIds.push(param1.readString());
            _loc7_++;
         }
         var _loc5_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _furniSourceTypes.push(param1.readInteger());
            _loc7_++;
         }
         var _loc11_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _userSourceTypes.push(param1.readInteger());
            _loc7_++;
         }
         _code = param1.readInteger();
         readDefinitionSpecifics(param1);
         _advancedMode = param1.readBoolean();
         _inputSourcesConf = new InputSourcesConf(param1);
         _allowWallFurni = param1.readBoolean();
         readTypeSpecifics(param1);
         _wiredContext = new WiredContext(param1);
         var _loc8_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _defaultIntParams.push(param1.readInteger());
            _loc7_++;
         }
      }
      
      public function get furniLimit() : int
      {
         return _furniLimit;
      }
      
      public function get stuffIds() : Array
      {
         return _stuffIds;
      }
      
      public function set stuffIds(param1:Array) : void
      {
         _stuffIds = param1;
      }
      
      public function get stuffIds2() : Array
      {
         return _stuffIds2;
      }
      
      public function set stuffIds2(param1:Array) : void
      {
         _stuffIds2 = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get stringParam() : String
      {
         return _stringParam;
      }
      
      public function set stringParam(param1:String) : void
      {
         _stringParam = param1;
      }
      
      public function get intParams() : Array
      {
         return _intParams;
      }
      
      public function set intParams(param1:Array) : void
      {
         _intParams = param1;
      }
      
      public function get variableIds() : Array
      {
         return _variableIds;
      }
      
      public function set variableIds(param1:Array) : void
      {
         _variableIds = param1;
      }
      
      public function get furniSourceTypes() : Array
      {
         return _furniSourceTypes;
      }
      
      public function set furniSourceTypes(param1:Array) : void
      {
         _furniSourceTypes = param1;
      }
      
      public function get userSourceTypes() : Array
      {
         return _userSourceTypes;
      }
      
      public function set userSourceTypes(param1:Array) : void
      {
         _userSourceTypes = param1;
      }
      
      public function get advancedMode() : Boolean
      {
         return _advancedMode;
      }
      
      public function get inputSourcesConf() : InputSourcesConf
      {
         return _inputSourcesConf;
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get stuffTypeId() : int
      {
         return _stuffTypeId;
      }
      
      public function getBoolean(param1:int) : Boolean
      {
         return _intParams[param1] == 1;
      }
      
      public function getString(param1:int = -1, param2:String = "\t") : String
      {
         if(param1 == -1)
         {
            return _stringParam;
         }
         var _loc3_:Array = _stringParam.split(param2);
         return _loc3_.length > param1 ? _loc3_[param1] : "";
      }
      
      public function getInt(param1:int) : int
      {
         return _intParams[param1];
      }
      
      public function get allowWallFurni() : Boolean
      {
         return _allowWallFurni;
      }
      
      public function get wiredContext() : WiredContext
      {
         return _wiredContext;
      }
      
      public function get defaultIntParams() : Array
      {
         return _defaultIntParams;
      }
      
      protected function readDefinitionSpecifics(param1:IMessageDataWrapper) : void
      {
      }
      
      protected function readTypeSpecifics(param1:IMessageDataWrapper) : void
      {
      }
      
      public function get usingCustomInputSources() : Boolean
      {
         return _inputSourcesConf.isUsingAdvancedSettings(furniSourceTypes,userSourceTypes);
      }
   }
}

