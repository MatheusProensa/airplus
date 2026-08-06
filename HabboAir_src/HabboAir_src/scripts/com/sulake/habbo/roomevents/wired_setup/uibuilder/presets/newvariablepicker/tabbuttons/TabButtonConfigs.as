package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNode;
   
   public class TabButtonConfigs
   {
      public static var ALL_TAB_ID:int = 0;
      
      public static var RECENT_TAB_ID:int = 1;
      
      public static var USER_CREATED_TAB_ID:int = 2;
      
      public static var UnknownVarFromTabButtonConfigs_Int_1:int = 3;
      
      public static var INTERNAL_TAB_ID:int = 4;
      
      public static var UnknownVarFromTabButtonConfigs_Int_2:int = 5;
      
      private var UnknownVarFromTabButtonConfigs_NewVariablePicker_1:NewVariablePicker;
      
      private var _tabButtons:Vector.<TabButtonConfig>;
      
      public function TabButtonConfigs(param1:NewVariablePicker)
      {
         super();
         UnknownVarFromTabButtonConfigs_NewVariablePicker_1 = param1;
         _tabButtons = Vector.<TabButtonConfig>([new TabButtonConfig(ALL_TAB_ID,"var_picker_all","wiredfurni.variable_picker.tab.all",allFilter),new TabButtonConfig(RECENT_TAB_ID,"var_picker_recent","wiredfurni.variable_picker.tab.recent",recentFilter),new TabButtonConfig(USER_CREATED_TAB_ID,"var_picker_usermade","wiredfurni.variable_picker.tab.user_created",userCreatedFilter),new TabButtonConfig(UnknownVarFromTabButtonConfigs_Int_1,"var_picker_smart","wiredfurni.variable_picker.tab.dynamic",dynamicFilter),new TabButtonConfig(INTERNAL_TAB_ID,"var_picker_internal","wiredfurni.variable_picker.tab.internal",internalFilter),new TabButtonConfig(UnknownVarFromTabButtonConfigs_Int_2,"var_picker_search","wiredfurni.variable_picker.tab.search",searchFilter)]);
      }
      
      public function get tabButtons() : Vector.<TabButtonConfig>
      {
         return _tabButtons;
      }
      
      private function nodesFromVector(param1:Vector.<WiredVariable>, param2:Boolean = false) : VariableNode
      {
         var _loc11_:Array = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc5_:String = null;
         var _loc4_:* = false;
         var _loc6_:VariableNode = null;
         var _loc7_:VariableNode = new VariableNode(null,null);
         for each(var _loc8_ in param1)
         {
            _loc11_ = Util.splitName(_loc8_);
            _loc9_ = _loc7_;
            _loc10_ = 0;
            while(_loc10_ < _loc11_.length)
            {
               _loc5_ = _loc11_[_loc10_];
               _loc4_ = _loc10_ == _loc11_.length - 1;
               _loc6_ = _loc9_.getChildNodeByName(_loc5_);
               if(_loc6_ == null)
               {
                  _loc6_ = new VariableNode(_loc4_ ? _loc8_ : null,_loc5_);
                  _loc9_.addChildNode(_loc6_);
               }
               _loc9_ = _loc6_;
               _loc10_ += 1;
            }
         }
         if(param2)
         {
            for each(var _loc3_ in _loc7_.children)
            {
               _loc3_.flatten(true);
            }
         }
         return _loc7_;
      }
      
      private function allFilter() : VariableNode
      {
         return nodesFromVector(UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariables);
      }
      
      private function recentFilter() : VariableNode
      {
         var _loc3_:WiredVariable = null;
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         var _loc2_:Vector.<String> = UnknownVarFromTabButtonConfigs_NewVariablePicker_1.roomEvents.variablePickerHelper.getHistory(UnknownVarFromTabButtonConfigs_NewVariablePicker_1.variableTarget);
         for each(var _loc4_ in _loc2_)
         {
            _loc3_ = UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariableById(_loc4_);
            if(_loc3_ != null)
            {
               _loc1_.push(_loc3_);
            }
         }
         return nodesFromVector(_loc1_,true);
      }
      
      private function userCreatedFilter() : VariableNode
      {
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariables)
         {
            if(_loc2_.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_1 || _loc2_.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_2)
            {
               _loc1_.push(_loc2_);
            }
         }
         return nodesFromVector(_loc1_);
      }
      
      private function dynamicFilter() : VariableNode
      {
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariables)
         {
            if(_loc2_.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_3)
            {
               _loc1_.push(_loc2_);
            }
         }
         return nodesFromVector(_loc1_);
      }
      
      private function internalFilter() : VariableNode
      {
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariables)
         {
            if(_loc2_.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL)
            {
               _loc1_.push(_loc2_);
            }
         }
         return nodesFromVector(_loc1_);
      }
      
      private function searchFilter() : VariableNode
      {
         var _loc5_:Boolean = false;
         var _loc3_:String = UnknownVarFromTabButtonConfigs_NewVariablePicker_1.inputField.text;
         if(_loc3_.length == "")
         {
            return nodesFromVector(new Vector.<WiredVariable>());
         }
         var _loc2_:Array = _loc3_.split(" ");
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc4_ in UnknownVarFromTabButtonConfigs_NewVariablePicker_1.filteredVariables)
         {
            _loc5_ = true;
            for each(var _loc6_ in _loc2_)
            {
               if(_loc4_.variableName.toLowerCase().indexOf(_loc6_.toLowerCase()) == -1)
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc1_.push(_loc4_);
            }
         }
         return nodesFromVector(_loc1_,true);
      }
   }
}

