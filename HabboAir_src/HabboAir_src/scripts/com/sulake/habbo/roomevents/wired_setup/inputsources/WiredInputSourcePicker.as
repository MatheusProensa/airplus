package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.InputSourcesConf;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.*;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import flash.utils.Dictionary;
   
   public class WiredInputSourcePicker implements IWiredInputSourcePicker, IComponentInterfaceQueue
   {
      public static var UnknownVarFromWiredInputSourcePicker_Int_1:int = 0;
      
      public static var USER_SOURCE:int = 1;
      
      public static var MERGED_SOURCE:int = 2;
      
      public static var STUFF_PICKING_MODE_NONE:int = 0;
      
      public static var STUFF_PICKING_MODE_1:int = 1;
      
      public static var STUFF_PICKING_MODE_2:int = 2;
      
      private var _disposed:Boolean = false;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _sourceType:int;
      
      private var _id:int;
      
      private var UnknownVarFromWiredInputSourcePicker_Triggerable_1:Triggerable;
      
      private var UnknownVarFromWiredInputSourcePicker_IDefaultElement_1:IDefaultElement;
      
      private var _selectionCache:Dictionary;
      
      private var _selectedText:String;
      
      private var _stuffPickingSpecialMode:int;
      
      private var _isButtonsDisabled:Boolean;
      
      private var _disabled:Boolean;
      
      public function WiredInputSourcePicker(param1:HabboUserDefinedRoomEvents, param2:int, param3:int)
      {
         super();
         this._roomEvents = param1;
         this._sourceType = param2;
         this._id = param3;
         if(_sourceType == MERGED_SOURCE)
         {
            _selectionCache = new Dictionary();
         }
      }
      
      public static function getTypeNameForSource(param1:int) : String
      {
         if(param1 == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            return "furni";
         }
         if(param1 == USER_SOURCE)
         {
            return "users";
         }
         if(param1 == VariableExtraSourceTypes.CONTEXT_SOURCE)
         {
            return "context";
         }
         if(param1 == VariableExtraSourceTypes.GLOBAL_SOURCE)
         {
            return "global";
         }
         return "";
      }
      
      public function onChangeInputSource(param1:Boolean) : void
      {
         var _loc9_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:InputSourcesConf = UnknownVarFromWiredInputSourcePicker_Triggerable_1.inputSourcesConf;
         if(_sourceType == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _loc9_ = _loc4_.getAllowedFurniSources(_id);
            _loc2_ = int(UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_id]);
            _loc3_ = int(_loc9_.indexOf(_loc2_));
         }
         else if(_sourceType == USER_SOURCE)
         {
            _loc9_ = _loc4_.getAllowedUserSources(_id);
            _loc2_ = int(UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_id]);
            _loc3_ = int(_loc9_.indexOf(_loc2_));
         }
         else
         {
            _loc7_ = UnknownVarFromWiredInputSourcePicker_IDefaultElement_1.mergedSelections()[_id];
            _loc5_ = int(_loc7_[0]);
            _loc6_ = int(_loc7_[1]);
            _loc8_ = UnknownVarFromWiredInputSourcePicker_IDefaultElement_1.getMergedType(_id);
            if(_loc8_ == UnknownVarFromWiredInputSourcePicker_Int_1)
            {
               _loc9_ = _loc4_.getAllowedFurniSources(_loc5_);
               _loc2_ = int(UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_loc5_]);
               _loc3_ = int(_loc9_.indexOf(_loc2_));
            }
            else
            {
               if(_loc8_ != USER_SOURCE)
               {
                  return;
               }
               _loc9_ = _loc4_.getAllowedUserSources(_loc6_);
               _loc2_ = int(UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_loc6_]);
               _loc3_ = int(_loc9_.indexOf(_loc2_));
            }
         }
         if(_loc3_ == -1)
         {
            _loc3_ = 0;
         }
         else if(param1)
         {
            _loc3_ = (_loc3_ + 1) % _loc9_.length;
         }
         else
         {
            _loc3_ = (_loc3_ - 1 + _loc9_.length) % _loc9_.length;
         }
         if(_sourceType == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_id] = _loc9_[_loc3_];
         }
         else if(_sourceType == USER_SOURCE)
         {
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_id] = _loc9_[_loc3_];
         }
         else if(_loc8_ == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_loc5_] = _loc9_[_loc3_];
         }
         else if(_loc8_ == USER_SOURCE)
         {
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_loc6_] = _loc9_[_loc3_];
         }
         refreshContainer(UnknownVarFromWiredInputSourcePicker_Triggerable_1,UnknownVarFromWiredInputSourcePicker_IDefaultElement_1);
      }
      
      public function set sourceType(param1:int) : void
      {
         var _loc6_:int = 0;
         if(_sourceType != MERGED_SOURCE)
         {
            return;
         }
         var _loc2_:int = UnknownVarFromWiredInputSourcePicker_IDefaultElement_1.getMergedType(_id);
         UnknownVarFromWiredInputSourcePicker_IDefaultElement_1.setMergedType(_id,param1);
         var _loc7_:Array = UnknownVarFromWiredInputSourcePicker_IDefaultElement_1.mergedSelections()[_id];
         var _loc5_:int = int(_loc7_[0]);
         var _loc3_:int = int(_loc7_[1]);
         if(_loc2_ == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _selectionCache[_loc2_] = UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_loc5_];
         }
         else if(_loc2_ == USER_SOURCE)
         {
            _selectionCache[_loc2_] = UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_loc3_];
         }
         var _loc4_:InputSourcesConf = UnknownVarFromWiredInputSourcePicker_Triggerable_1.inputSourcesConf;
         if(param1 == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _loc6_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc4_.getAllowedFurniSources(_loc5_)[0]);
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.furniSourceTypes[_loc5_] = _loc6_;
         }
         else if(param1 == USER_SOURCE)
         {
            _loc6_ = int(param1 in _selectionCache ? _selectionCache[param1] : _loc4_.getAllowedUserSources(_loc3_)[0]);
            UnknownVarFromWiredInputSourcePicker_Triggerable_1.userSourceTypes[_loc3_] = _loc6_;
         }
         refreshContainer(UnknownVarFromWiredInputSourcePicker_Triggerable_1,UnknownVarFromWiredInputSourcePicker_IDefaultElement_1);
      }
      
      public function refreshContainer(param1:Triggerable, param2:IDefaultElement) : void
      {
         var _loc14_:int = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:String = null;
         var _loc13_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc12_:Array = null;
         var _loc5_:int = 0;
         if(UnknownVarFromWiredInputSourcePicker_Triggerable_1 != param1 || UnknownVarFromWiredInputSourcePicker_IDefaultElement_1 != param2)
         {
            UnknownVarFromWiredInputSourcePicker_Triggerable_1 = param1;
            UnknownVarFromWiredInputSourcePicker_IDefaultElement_1 = param2;
            if(_sourceType == MERGED_SOURCE)
            {
               _selectionCache = new Dictionary();
            }
         }
         var _loc3_:Boolean = false;
         if(_sourceType == UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _loc9_ = "furni";
            _loc14_ = int(param1.furniSourceTypes[_id]);
         }
         else if(_sourceType == USER_SOURCE)
         {
            _loc9_ = "users";
            _loc14_ = int(param1.userSourceTypes[_id]);
         }
         else
         {
            _loc10_ = param2.mergedSelections()[_id];
            _loc7_ = int(_loc10_[0]);
            _loc8_ = int(_loc10_[1]);
            _loc11_ = param2.getMergedType(_id);
            if(_loc11_ == UnknownVarFromWiredInputSourcePicker_Int_1)
            {
               _loc9_ = "furni";
               _loc14_ = int(param1.furniSourceTypes[_loc7_]);
            }
            else if(_loc11_ == USER_SOURCE)
            {
               _loc9_ = "users";
               _loc14_ = int(param1.userSourceTypes[_loc8_]);
            }
            else
            {
               _loc3_ = true;
               _loc9_ = getTypeNameForSource(param2.getMergedType(_id));
            }
         }
         if(_loc3_)
         {
            _loc4_ = "wiredfurni.params.sources." + _loc9_;
         }
         else
         {
            _loc4_ = "wiredfurni.params.sources." + _loc9_ + "." + _loc14_;
         }
         var _loc15_:String = _roomEvents.localization.getLocalization(_loc4_,_loc4_);
         _stuffPickingSpecialMode = STUFF_PICKING_MODE_NONE;
         if(_loc9_ == "furni")
         {
            _loc13_ = param1.inputSourcesConf.isDualFurniPickingMode();
            _loc6_ = wiredCtrl.hidePickFurniInstructions;
            _loc5_ = STUFF_PICKING_MODE_NONE;
            if(_loc14_ == 100 || _loc14_ == 110)
            {
               _loc12_ = wiredCtrl.getStuffIds();
               _loc5_ = STUFF_PICKING_MODE_1;
            }
            else if(_loc14_ == 101)
            {
               _loc12_ = wiredCtrl.getStuffIds2();
               _loc5_ = STUFF_PICKING_MODE_2;
            }
            if(_loc13_ && _loc5_ != STUFF_PICKING_MODE_NONE)
            {
               _stuffPickingSpecialMode = _loc5_;
            }
            if((_loc13_ || _loc6_) && _loc12_ != null)
            {
               _loc15_ += " [" + _loc12_.length + "/" + param1.furniLimit + "]";
            }
         }
         _isButtonsDisabled = _loc3_;
         _selectedText = _loc15_;
         _disabled = param2.isInputSourceDisabled(_id,_sourceType);
      }
      
      public function get sourceType() : int
      {
         return _sourceType;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get selectedText() : String
      {
         return _selectedText;
      }
      
      public function get isButtonsDisabled() : Boolean
      {
         return _isButtonsDisabled;
      }
      
      public function get stuffPickingSpecialMode() : int
      {
         return _stuffPickingSpecialMode;
      }
      
      private function get wiredCtrl() : IUserDefinedRoomEventsCtrl
      {
         return _roomEvents.wiredCtrl;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _roomEvents = null;
         UnknownVarFromWiredInputSourcePicker_Triggerable_1 = null;
         UnknownVarFromWiredInputSourcePicker_IDefaultElement_1 = null;
         _selectionCache = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

