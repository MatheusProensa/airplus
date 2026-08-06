package com.sulake.habbo.avatar.figuredata
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import flash.utils.Dictionary;
   
   public class FigureData implements UnknownIHabboAvatar1
   {
      public static const MALE:String = "M";
      
      public static const UnknownConstFromFigureDataContainer_String_1:String = "F";
      
      public static const UnknownConstFromFigureDataContainer_String_2:String = "U";
      
      public static const SCALE:String = "h";
      
      public static const ACTION:String = "std";
      
      public static const DEFAULT_FRAME:String = "0";
      
      private var _avatarEditor:HabboAvatarEditor;
      
      private var _view:FigureDataView;
      
      private var UnknownVarFromFigureData_Dictionary_1:Dictionary;
      
      private var _colors:Dictionary;
      
      private var _gender:String = "M";
      
      private var _disposed:Boolean;
      
      private var _direction:int = 4;
      
      private var _avatarEffectType:int = -1;
      
      public function FigureData(param1:HabboAvatarEditor)
      {
         super();
         _direction = 4;
         _avatarEditor = param1;
         _view = new FigureDataView(this);
      }
      
      public function loadAvatarData(param1:String, param2:String) : void
      {
         UnknownVarFromFigureData_Dictionary_1 = new Dictionary();
         _colors = new Dictionary();
         _gender = param2;
         parseFigureString(param1);
         updateView();
      }
      
      public function dispose() : void
      {
         _avatarEditor = null;
         _view = null;
         UnknownVarFromFigureData_Dictionary_1 = null;
         _colors = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function parseFigureString(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         for each(var _loc7_ in param1.split("."))
         {
            _loc2_ = _loc7_.split("-");
            if(_loc2_.length > 0)
            {
               _loc6_ = String(_loc2_[0]);
               _loc3_ = parseInt(_loc2_[1]);
               _loc5_ = [];
               _loc4_ = 2;
               while(_loc4_ < _loc2_.length)
               {
                  _loc5_.push(_loc2_[_loc4_]);
                  _loc4_++;
               }
               if(_loc5_.length == 0)
               {
                  _loc5_.push(0);
               }
               savePartSetId(_loc6_,_loc3_,false);
               savePartSetColourId(_loc6_,_loc5_,false);
            }
         }
      }
      
      public function getPartSetId(param1:String) : int
      {
         if(UnknownVarFromFigureData_Dictionary_1 && UnknownVarFromFigureData_Dictionary_1[param1] != null)
         {
            return UnknownVarFromFigureData_Dictionary_1[param1];
         }
         return -1;
      }
      
      public function getColourIds(param1:String) : Array
      {
         if(_colors && _colors[param1] != null)
         {
            return _colors[param1];
         }
         return [_avatarEditor.getDefaultColour(param1)];
      }
      
      public function getFigureString() : String
      {
         var _loc2_:String = null;
         var _loc8_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         var _loc1_:Array = [];
         for(var _loc7_ in UnknownVarFromFigureData_Dictionary_1)
         {
            if(UnknownVarFromFigureData_Dictionary_1[_loc7_] != null)
            {
               _loc2_ = UnknownVarFromFigureData_Dictionary_1[_loc7_];
               _loc8_ = _colors[_loc7_] as Array;
               _loc3_ = _loc7_ + "-" + _loc2_;
               if(_loc8_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc8_.length)
                  {
                     _loc3_ += "-" + _loc8_[_loc4_];
                     _loc4_++;
                  }
               }
               _loc1_.push(_loc3_);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ += _loc1_[_loc5_];
            if(_loc5_ < _loc1_.length - 1)
            {
               _loc6_ += ".";
            }
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function savePartData(param1:String, param2:int, param3:Array, param4:Boolean = false) : void
      {
         savePartSetId(param1,param2,param4);
         savePartSetColourId(param1,param3,param4);
      }
      
      private function savePartSetId(param1:String, param2:int, param3:Boolean = true) : void
      {
         switch(param1)
         {
            case "hd":
            case "hr":
            case "ha":
            case "he":
            case "ea":
            case "fa":
            case "ch":
            case "cc":
            case "ca":
            case "cp":
            case "lg":
            case "sh":
            case "wa":
            case "mc":
            case "pt":
               if(param2 >= 0)
               {
                  UnknownVarFromFigureData_Dictionary_1[param1] = param2;
               }
               else
               {
                  delete UnknownVarFromFigureData_Dictionary_1[param1];
               }
         }
         if(param3)
         {
            updateView();
         }
      }
      
      public function savePartSetColourId(param1:String, param2:Array, param3:Boolean = true) : void
      {
         switch(param1)
         {
            case "hd":
            case "hr":
            case "ha":
            case "he":
            case "ea":
            case "fa":
            case "ch":
            case "cc":
            case "ca":
            case "cp":
            case "lg":
            case "sh":
            case "wa":
            case "mc":
            case "pt":
               _colors[param1] = param2;
         }
         if(param3)
         {
            updateView();
         }
      }
      
      public function getFigureStringWithFace(param1:int) : String
      {
         var _loc4_:* = 0;
         var _loc10_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         _loc3_.push("hd");
         var _loc8_:String = "";
         var _loc2_:Array = [];
         for each(var _loc9_ in _loc3_)
         {
            if(_colors[_loc9_] != null)
            {
               _loc4_ = int(UnknownVarFromFigureData_Dictionary_1[_loc9_]);
               _loc10_ = _colors[_loc9_] as Array;
               if(_loc9_ == "hd")
               {
                  _loc4_ = param1;
               }
               _loc5_ = _loc9_ + "-" + _loc4_;
               if(_loc4_ >= 0)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc10_.length)
                  {
                     _loc5_ += "-" + _loc10_[_loc6_];
                     _loc6_++;
                  }
               }
               _loc2_.push(_loc5_);
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc8_ += _loc2_[_loc7_];
            if(_loc7_ < _loc2_.length - 1)
            {
               _loc8_ += ".";
            }
            _loc7_++;
         }
         return _loc8_;
      }
      
      public function updateView() : void
      {
         _view.update(getFigureString(),_avatarEffectType,_direction);
      }
      
      public function get view() : FigureDataView
      {
         return _view;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         updateView();
      }
      
      public function set avatarEffectType(param1:int) : void
      {
         _avatarEffectType = param1;
      }
      
      public function get avatarEffectType() : int
      {
         return _avatarEffectType;
      }
      
      public function get avatarEditor() : HabboAvatarEditor
      {
         return _avatarEditor;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
         updateView();
      }
   }
}

