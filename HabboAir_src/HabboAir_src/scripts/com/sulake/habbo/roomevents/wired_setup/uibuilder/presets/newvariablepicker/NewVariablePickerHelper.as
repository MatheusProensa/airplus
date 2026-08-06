package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NewVariablePickerHelper
   {
      private static var MAX_HISTORY:int = 20;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromNewVariablePickerHelper_Map_1:Map;
      
      private var _windowTemplates:Map;
      
      private var UnknownVarFromNewVariablePickerHelper_Map_2:Map;
      
      public function NewVariablePickerHelper(param1:HabboUserDefinedRoomEvents)
      {
         super();
         _roomEvents = param1;
         UnknownVarFromNewVariablePickerHelper_Map_2 = new Map();
         _windowTemplates = new Map();
         UnknownVarFromNewVariablePickerHelper_Map_1 = new Map();
      }
      
      public function addToHistory(param1:WiredVariable) : void
      {
         var _loc3_:int = param1.variableTarget;
         var _loc5_:String = param1.variableId;
         var _loc6_:int = _roomEvents.roomId;
         if(_loc6_ == 0)
         {
            return;
         }
         if(!UnknownVarFromNewVariablePickerHelper_Map_1.hasKey(_loc6_))
         {
            UnknownVarFromNewVariablePickerHelper_Map_1.add(_loc6_,new Map());
         }
         var _loc2_:Map = UnknownVarFromNewVariablePickerHelper_Map_1.getValue(_loc6_);
         if(!_loc2_.hasKey(_loc3_))
         {
            _loc2_.add(_loc3_,new Vector.<String>());
         }
         var _loc4_:Vector.<String> = _loc2_.getValue(_loc3_);
         var _loc7_:int = int(_loc4_.indexOf(_loc5_));
         if(_loc7_ >= 0)
         {
            _loc4_.removeAt(_loc7_);
         }
         _loc4_.splice(0,0,_loc5_);
         if(_loc4_.length > MAX_HISTORY)
         {
            _loc4_.pop();
         }
      }
      
      public function getHistory(param1:int) : Vector.<String>
      {
         var _loc3_:int = _roomEvents.roomId;
         if(_loc3_ == 0)
         {
            return Vector.<String>([]);
         }
         if(!UnknownVarFromNewVariablePickerHelper_Map_1.hasKey(_loc3_))
         {
            return Vector.<String>([]);
         }
         var _loc2_:Map = UnknownVarFromNewVariablePickerHelper_Map_1.getValue(_loc3_);
         if(!_loc2_.hasKey(param1))
         {
            return Vector.<String>([]);
         }
         return _loc2_.getValue(param1);
      }
      
      public function acquireNodeView(param1:WiredStyle) : IRegionWindow
      {
         var _loc3_:* = undefined;
         var _loc4_:IWindowModel = null;
         if(UnknownVarFromNewVariablePickerHelper_Map_2.hasKey(param1))
         {
            _loc3_ = UnknownVarFromNewVariablePickerHelper_Map_2.getValue(param1);
            if(_loc3_.length > 0)
            {
               return _loc3_.pop();
            }
         }
         if(!_windowTemplates.hasKey(param1))
         {
            _loc4_ = _roomEvents.wiredCtrl.presetManager.createLayout("search_tree_dropdown");
            _windowTemplates.add(param1,_loc4_.findChildByName("node_template"));
         }
         var _loc2_:IRegionWindow = _windowTemplates.getValue(param1);
         return _loc2_.clone() as IRegionWindow;
      }
      
      public function releaseNodeView(param1:WiredStyle, param2:IRegionWindow) : void
      {
         if(!UnknownVarFromNewVariablePickerHelper_Map_2.hasKey(param1))
         {
            UnknownVarFromNewVariablePickerHelper_Map_2.add(param1,new Vector.<IRegionWindow>());
         }
         UnknownVarFromNewVariablePickerHelper_Map_2.getValue(param1).push(param2);
      }
   }
}

