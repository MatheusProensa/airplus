package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNode;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNodeListView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfigs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class NewVariablePicker implements IComponentInterfaceQueue
   {
      public static var UNSPECIFIED_TYPE:int = 2147483647;
      
      private var _disposed:Boolean = false;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:IWindowController_1;
      
      private var _expandedWindowWrapper:IWindowController_1;
      
      private var _inputFieldRegion:IRegionWindow;
      
      private var _isExpanded:Boolean = false;
      
      private var _variableFilter:Function;
      
      private var UnknownVarFromNewVariablePicker_Function_1:Function;
      
      private var _showFilteredVariables:Boolean = true;
      
      private var _allVariables:UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1;
      
      private var _filteredVariables:Vector.<WiredVariable>;
      
      private var _selected:WiredVariable;
      
      private var _variableTarget:int;
      
      private var UnknownVarFromNewVariablePicker_Dictionary_1:Dictionary;
      
      private var UnknownVarFromNewVariablePicker_String_1:String;
      
      private var UnknownVarFromNewVariablePicker_Boolean_1:Boolean;
      
      private var _expandedView:ExpandedVariablePickerView = null;
      
      public function NewVariablePicker(param1:HabboUserDefinedRoomEvents, param2:IWindowController_1, param3:Function = null, param4:Function = null, param5:WiredStyle = null)
      {
         super();
         _roomEvents = param1;
         _container = param2;
         _variableFilter = param3;
         UnknownVarFromNewVariablePicker_Function_1 = param4;
         UnknownVarFromNewVariablePicker_Dictionary_1 = new Dictionary();
         _inputFieldRegion = _container.findChildByName("input_field_region") as IRegionWindow;
         _expandedWindowWrapper = _container.findChildByName("expanded_view_wrapper") as IWindowController_1;
         _expandedWindowWrapper.desktop.addChild(_expandedWindowWrapper);
         _expandedWindowWrapper.visible = false;
         setWiredStyle(param5);
         inputFieldRegion.addEventListener("WME_CLICK",onTextRegionClick);
         inputField.addEventListener("WME_CLICK",onTextRegionClick);
         cancelSearchButton.addEventListener("WME_CLICK",onCancelSearch);
         inputField.addEventListener("WE_CHANGE",onChangeQuery);
         inputField.addEventListener("WKE_KEY_UP",onKeyUp);
         inputPlaceholderText.visible = true;
         expandedWindowWrapper.setParamFlag(16,false);
         expandedWindowWrapper.addEventListener("WE_DEACTIVATED",onDeactivate);
         collapseView(true);
      }
      
      private function setWiredStyle(param1:WiredStyle) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.name == "illumina")
         {
            collapsedView.style = 105;
            _expandedWindowWrapper.findChildByName("expanded_view").style = 105;
         }
      }
      
      public function init(param1:UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextParams1, param2:String, param3:int) : void
      {
         _allVariables = param1;
         _variableTarget = param3;
         UnknownVarFromNewVariablePicker_String_1 = param2;
         UnknownVarFromNewVariablePicker_Boolean_1 = false;
         UnknownVarFromNewVariablePicker_Dictionary_1 = new Dictionary();
         _filteredVariables = filteredAllVariables;
         select(findVariableById(param2),true);
         if(_expandedView != null)
         {
            _expandedView.selectTab(_expandedView.tabById(determineInitialTab()));
         }
      }
      
      public function set variableTarget(param1:int) : void
      {
         if(param1 == _variableTarget)
         {
            return;
         }
         collapseView();
         updateSelected();
         _variableTarget = param1;
         _filteredVariables = filteredAllVariables;
         if(param1 in UnknownVarFromNewVariablePicker_Dictionary_1)
         {
            select(UnknownVarFromNewVariablePicker_Dictionary_1[param1]);
         }
         else
         {
            select(null);
         }
      }
      
      public function get variableTarget() : int
      {
         return _variableTarget;
      }
      
      private function findVariableById(param1:String) : WiredVariable
      {
         for each(var _loc2_ in _filteredVariables)
         {
            if(_loc2_.variableId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get filteredVariables() : Vector.<WiredVariable>
      {
         return _filteredVariables;
      }
      
      public function filteredVariableById(param1:String) : WiredVariable
      {
         for each(var _loc2_ in _filteredVariables)
         {
            if(_loc2_.variableId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get filteredAllVariables() : Vector.<WiredVariable>
      {
         if(_allVariables == null || _allVariables.variables == null)
         {
            return new Vector.<WiredVariable>();
         }
         var _loc1_:Vector.<WiredVariable> = new Vector.<WiredVariable>();
         for each(var _loc2_ in _allVariables.variables)
         {
            if((_variableFilter == null || _showFilteredVariables || _variableFilter(_loc2_)) && _loc2_.variableName != "" && (_loc2_.variableTarget == _variableTarget || _variableTarget == UNSPECIFIED_TYPE))
            {
               if(!(_loc2_.isInvisible && UnknownVarFromNewVariablePicker_String_1 != _loc2_.variableId))
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      public function select(param1:WiredVariable, param2:Boolean = false) : void
      {
         collapseView();
         UnknownVarFromNewVariablePicker_Dictionary_1[_variableTarget] = param1;
         _selected = param1;
         inputField.text = param1?.variableName;
         updatePlaceholder();
         if(!param2 && UnknownVarFromNewVariablePicker_Function_1 != null)
         {
            UnknownVarFromNewVariablePicker_Function_1(param1);
         }
         UnknownVarFromNewVariablePicker_Boolean_1 = false;
      }
      
      public function get expandedView() : ExpandedVariablePickerView
      {
         return _expandedView;
      }
      
      private function updateSelected() : void
      {
         var _loc1_:WiredVariable = filteredVariableByDisplayName(inputField.text);
         if(_loc1_ != null && _selected != _loc1_)
         {
            select(_loc1_);
         }
         if(inputField.text == "" && _selected != null)
         {
            select(null);
         }
      }
      
      public function get selected() : WiredVariable
      {
         updateSelected();
         return _selected;
      }
      
      public function finalize() : void
      {
         updateSelected();
         if(_selected != null)
         {
            _roomEvents.variablePickerHelper.addToHistory(_selected);
         }
      }
      
      private function collapseView(param1:Boolean = false) : void
      {
         if(!_isExpanded && !param1)
         {
            return;
         }
         _isExpanded = false;
         collapsedView.visible = true;
         expandedWindowWrapper.visible = false;
         expandedWindowWrapper.deactivate();
         moveInputField(searchWrapperCollapsed);
         if(_expandedView != null)
         {
            _expandedView.onHide();
         }
      }
      
      private function expandView() : void
      {
         if(_isExpanded)
         {
            return;
         }
         _isExpanded = true;
         collapsedView.visible = false;
         var _loc1_:Point = new Point();
         _container.getGlobalPosition(_loc1_);
         _loc1_.y -= searchWrapperExpanded.y;
         expandedWindowWrapper.setGlobalPosition(_loc1_);
         expandedWindowWrapper.visible = true;
         expandedWindowWrapper.activate();
         moveInputField(searchWrapperExpanded);
         inputField.focus();
         showExpand();
         UnknownVarFromNewVariablePicker_Boolean_1 = false;
      }
      
      private function showExpand() : void
      {
         if(_expandedView != null)
         {
            _expandedView.onVisible();
            return;
         }
         _expandedView = new ExpandedVariablePickerView(this,expandedWindowWrapper);
         _expandedView.selectTab(_expandedView.tabById(determineInitialTab()));
      }
      
      private function determineInitialTab() : int
      {
         if(_selected == null)
         {
            return TabButtonConfigs.USER_CREATED_TAB_ID;
         }
         if(_selected.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.UnknownVarFromUnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1_Int_3)
         {
            return TabButtonConfigs.UnknownVarFromTabButtonConfigs_Int_1;
         }
         if(_selected.variableType == UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL)
         {
            return TabButtonConfigs.INTERNAL_TAB_ID;
         }
         return TabButtonConfigs.USER_CREATED_TAB_ID;
      }
      
      private function moveInputField(param1:IWindowController_1) : void
      {
         IWindowController_1(inputFieldRegion.parent).removeChild(inputFieldRegion);
         param1.addChild(inputFieldRegion);
         inputFieldRegion.width = param1.width;
         inputFieldRegion.height = param1.height;
      }
      
      private function onDeactivate(param1:WindowEvent) : void
      {
         var _loc2_:WiredVariable = null;
         if(UnknownVarFromNewVariablePicker_Boolean_1)
         {
            _loc2_ = filteredVariableByDisplayName(inputField.text);
            if(_loc2_ != null)
            {
               select(_loc2_);
            }
            else
            {
               select(_selected);
            }
            UnknownVarFromNewVariablePicker_Boolean_1 = false;
         }
         collapseView();
      }
      
      private function filteredVariableByDisplayName(param1:String) : WiredVariable
      {
         var _loc2_:String = null;
         for each(var _loc3_ in _filteredVariables)
         {
            if(!(_variableFilter != null && !_variableFilter(_loc3_)))
            {
               if(_loc3_.variableName.toLowerCase() == param1.toLowerCase())
               {
                  return _loc3_;
               }
               _loc2_ = _loc3_.variableName;
               if(param1.toLowerCase() == _loc2_.toLowerCase())
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      private function onKeyUp(param1:WindowKeyboardEvent) : void
      {
         var _loc4_:WiredVariable = null;
         var _loc3_:TabButtonView = null;
         var _loc5_:VariableNodeListView = null;
         var _loc2_:VariableNode = null;
         if(param1.keyCode == 27)
         {
            collapseView();
         }
         else if(param1.keyCode == 13)
         {
            _loc4_ = filteredVariableByDisplayName(inputField.text);
            if(_loc4_ != null)
            {
               select(_loc4_);
               return;
            }
            if(inputField.text == "")
            {
               select(null);
               return;
            }
            if(_expandedView != null && _isExpanded)
            {
               _loc3_ = _expandedView.selectedTab;
               if(_loc3_ != null && _loc3_.tabConfig.tabId == TabButtonConfigs.UnknownVarFromTabButtonConfigs_Int_2)
               {
                  _loc5_ = _expandedView.activeItemsView;
                  if(_loc5_ != null && _loc5_.childNodes.length >= 1)
                  {
                     _loc2_ = _loc5_.childNodes[0].variableNode;
                     if(_loc2_.variable != null && _loc2_.canBeSelected(this))
                     {
                        select(_loc2_.variable);
                     }
                  }
                  else
                  {
                     select(null);
                  }
               }
            }
         }
      }
      
      private function onChangeQuery(param1:WindowEvent) : void
      {
         if(_isExpanded && _expandedView != null)
         {
            _expandedView.selectTab(_expandedView.tabById(TabButtonConfigs.UnknownVarFromTabButtonConfigs_Int_2),true);
         }
         updatePlaceholder();
         UnknownVarFromNewVariablePicker_Boolean_1 = true;
      }
      
      private function updatePlaceholder() : void
      {
         cancelSearchButton.visible = inputField.text.length > 0;
         inputPlaceholderText.visible = inputField.text.length == 0;
      }
      
      private function onTextRegionClick(param1:WindowMouseEvent) : void
      {
         inputField.focus();
         expandView();
      }
      
      private function onCancelSearch(param1:WindowMouseEvent) : void
      {
         inputField.text = "";
         select(null);
         updatePlaceholder();
         inputField.focus();
         expandView();
      }
      
      public function get showFilteredVariables() : Boolean
      {
         return _showFilteredVariables;
      }
      
      public function get variableFilter() : Function
      {
         return _variableFilter;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_expandedView != null)
         {
            _expandedWindowWrapper.desktop.removeChild(_expandedWindowWrapper);
            _expandedView.dispose();
            _expandedView = null;
         }
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set width(param1:int) : void
      {
         _container.width = param1;
      }
      
      public function get window() : IWindowController_1
      {
         return _container;
      }
      
      private function get collapsedView() : UnknownICoreWindowComponents6
      {
         return _container.findChildByName("collapsed_view") as UnknownICoreWindowComponents6;
      }
      
      private function get expandedWindowWrapper() : IWindowController_1
      {
         return _expandedWindowWrapper;
      }
      
      private function get inputFieldRegion() : IRegionWindow
      {
         return _inputFieldRegion;
      }
      
      private function get inputPlaceholderText() : ITextWindow
      {
         return _inputFieldRegion.findChildByName("input_placeholder_text") as ITextWindow;
      }
      
      public function get inputField() : ITextFieldWindow
      {
         return _inputFieldRegion.findChildByName("input_field") as ITextFieldWindow;
      }
      
      private function get searchWrapperCollapsed() : IWindowController_1
      {
         return _container.findChildByName("search_wrapper_collapsed") as IWindowController_1;
      }
      
      private function get searchWrapperExpanded() : IWindowController_1
      {
         return _expandedWindowWrapper.findChildByName("search_wrapper_expanded") as IWindowController_1;
      }
      
      private function get cancelSearchButton() : IRegionWindow
      {
         return _expandedWindowWrapper.findChildByName("cancel_search") as IRegionWindow;
      }
   }
}

