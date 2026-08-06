package com.sulake.habbo.avatar.actions
{
   import com.sulake.core.utils.Map;
   import flash.utils.Dictionary;
   
   public class ActionDefinition implements IActionDefinition
   {
      private var _id:String;
      
      private var _state:String;
      
      private var _precedence:int;
      
      private var _activePartSet:String;
      
      private var _assetPartDefinition:String;
      
      private var _lay:String;
      
      private var _geometryType:String;
      
      private var _isMain:Boolean = false;
      
      private var _isDefault:Boolean = false;
      
      private var _isAnimation:Boolean = false;
      
      private var _startFromFrameZero:Boolean = false;
      
      private var UnknownVarFromActionDefinition_Array_1:Array = [];
      
      private var UnknownVarFromActionDefinition_Boolean_1:Boolean;
      
      private var UnknownVarFromActionDefinition_Map_1:Map;
      
      private var _types:Dictionary = new Dictionary();
      
      private var _params:Dictionary = new Dictionary();
      
      private var UnknownVarFromActionDefinition_String_1:String = "";
      
      public function ActionDefinition(param1:XML = null)
      {
         super();
         if(param1 != null)
         {
            createFromXml(param1);
         }
      }
      
      private function createFromXml(param1:XML) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc4_:String = null;
         _id = String(param1.@id);
         _state = String(param1.@state);
         _precedence = parseInt(param1.@precedence);
         _activePartSet = String(param1.@activepartset);
         _assetPartDefinition = String(param1.@assetpartdefinition);
         _lay = String(param1.@lay);
         _geometryType = String(param1.@geometrytype);
         _isMain = Boolean(parseInt(param1.@main));
         _isDefault = Boolean(parseInt(param1.@isdefault));
         _isAnimation = Boolean(parseInt(param1.@animation));
         _startFromFrameZero = param1.@startfromframezero == "true";
         UnknownVarFromActionDefinition_Boolean_1 = param1.@preventheadturn == "true";
         var _loc3_:String = String(param1.@prevents);
         if(_loc3_ != "")
         {
            UnknownVarFromActionDefinition_Array_1 = _loc3_.split(",");
         }
         for each(var _loc2_ in param1.param)
         {
            _loc6_ = String(_loc2_.@id);
            _loc7_ = String(_loc2_.@value);
            if(_loc6_ == "default")
            {
               UnknownVarFromActionDefinition_String_1 = _loc7_;
            }
            else
            {
               _params[_loc6_] = _loc7_;
            }
         }
         for each(var _loc5_ in param1.type)
         {
            _loc4_ = String(_loc5_.@id);
            _types[_loc4_] = new ActionType(_loc5_);
         }
      }
      
      public function setOffsets(param1:String, param2:int, param3:Array) : void
      {
         if(UnknownVarFromActionDefinition_Map_1 == null)
         {
            UnknownVarFromActionDefinition_Map_1 = new Map();
         }
         if(UnknownVarFromActionDefinition_Map_1.getValue(param1) == null)
         {
            UnknownVarFromActionDefinition_Map_1.add(param1,new Map());
         }
         var _loc4_:Map = UnknownVarFromActionDefinition_Map_1.getValue(param1);
         _loc4_.add(param2,param3);
      }
      
      public function getOffsets(param1:String, param2:int) : Array
      {
         if(UnknownVarFromActionDefinition_Map_1 == null)
         {
            return null;
         }
         var _loc3_:Map = UnknownVarFromActionDefinition_Map_1.getValue(param1) as Map;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getValue(param2) as Array;
      }
      
      public function getParameterValue(param1:String) : String
      {
         if(param1 == "")
         {
            return "";
         }
         var _loc2_:String = _params[param1];
         if(_loc2_ == null)
         {
            _loc2_ = UnknownVarFromActionDefinition_String_1;
         }
         return _loc2_;
      }
      
      private function getTypePrevents(param1:String) : Array
      {
         if(param1 == "")
         {
            return [];
         }
         var _loc2_:ActionType = _types[param1];
         if(_loc2_ != null)
         {
            return _loc2_.prevents;
         }
         return [];
      }
      
      public function toString() : String
      {
         return "[ActionDefinition]\nid:           " + id + "\n" + "state:        " + state + "\n" + "main:         " + isMain + "\n" + "default:      " + isDefault + "\n" + "geometry:     " + state + "\n" + "precedence:   " + precedence + "\n" + "activepartset:" + activePartSet + "\n" + "activepartdef:" + assetPartDefinition + "";
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get state() : String
      {
         return _state;
      }
      
      public function get precedence() : int
      {
         return _precedence;
      }
      
      public function get activePartSet() : String
      {
         return _activePartSet;
      }
      
      public function get isMain() : Boolean
      {
         return _isMain;
      }
      
      public function get isDefault() : Boolean
      {
         return _isDefault;
      }
      
      public function get assetPartDefinition() : String
      {
         return _assetPartDefinition;
      }
      
      public function get lay() : String
      {
         return _lay;
      }
      
      public function get geometryType() : String
      {
         return _geometryType;
      }
      
      public function get isAnimation() : Boolean
      {
         return _isAnimation;
      }
      
      public function getPrevents(param1:String = "") : Array
      {
         return UnknownVarFromActionDefinition_Array_1.concat(getTypePrevents(param1));
      }
      
      public function getPreventHeadTurn(param1:String = "") : Boolean
      {
         if(param1 == "")
         {
            return UnknownVarFromActionDefinition_Boolean_1;
         }
         var _loc2_:ActionType = _types[param1];
         if(_loc2_ != null)
         {
            return _loc2_.preventHeadTurn;
         }
         return UnknownVarFromActionDefinition_Boolean_1;
      }
      
      public function isAnimated(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return true;
         }
         var _loc2_:ActionType = _types[param1];
         if(_loc2_ != null)
         {
            return _loc2_.isAnimated;
         }
         return true;
      }
      
      public function get startFromFrameZero() : Boolean
      {
         return _startFromFrameZero;
      }
      
      public function get params() : Dictionary
      {
         return _params;
      }
      
      public function setGeometryType(param1:String) : void
      {
         _geometryType = param1;
      }
      
      public function setState(param1:String) : void
      {
         _state = param1;
      }
      
      public function setAssetPartDefinition(param1:String) : void
      {
         _assetPartDefinition = param1;
      }
      
      public function copy() : ActionDefinition
      {
         var _loc1_:ActionDefinition = new ActionDefinition();
         _loc1_._id = _id;
         _loc1_._state = _state;
         _loc1_._precedence = _precedence;
         _loc1_._activePartSet = _activePartSet;
         _loc1_._assetPartDefinition = _assetPartDefinition;
         _loc1_._lay = _lay;
         _loc1_._geometryType = _geometryType;
         _loc1_._isMain = _isMain;
         _loc1_._isDefault = _isDefault;
         _loc1_._isAnimation = _isAnimation;
         _loc1_._startFromFrameZero = _startFromFrameZero;
         _loc1_.UnknownVarFromActionDefinition_Array_1 = UnknownVarFromActionDefinition_Array_1;
         _loc1_.UnknownVarFromActionDefinition_Boolean_1 = UnknownVarFromActionDefinition_Boolean_1;
         _loc1_.UnknownVarFromActionDefinition_Map_1 = UnknownVarFromActionDefinition_Map_1;
         _loc1_._types = _types;
         _loc1_._params = _params;
         _loc1_.UnknownVarFromActionDefinition_String_1 = UnknownVarFromActionDefinition_String_1;
         return _loc1_;
      }
   }
}

