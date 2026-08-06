package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.ObjectIdAndValuePair;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetAllVariableHoldersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management.WiredGetVariableOwnersPageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersMessageParser;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.common.VariableTypePicker;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.overview.VariableManagementConfig;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class WiredMenuOverviewTab extends WiredMenuDefaultTab implements IProfiler_1
   {
      private static var POLL_MS:uint = 500;
      
      private static var MAX_HIGHLIGHTS:uint = 1000;
      
      private static var MAX_HIGHLIGHTS_WITH_VALUE:uint = 400;
      
      private static var MAX_TEXT_CONNECTIONS:uint = 400;
      
      public static var LIST_COLUMN_NAME:String = "variable";
      
      public static var PROPERTIES_COLUMN_PROPERTY:String = "property";
      
      public static var PROPERTIES_COLUMN_VALUE:String = "value";
      
      public static var UnknownVarFromWiredMenuOverviewTab_String_1:String = "value";
      
      public static var UnknownVarFromWiredMenuOverviewTab_String_2:String = "text";
      
      private var UnknownVarFromWiredMenuOverviewTab_TableView_1:TableView;
      
      private var UnknownVarFromWiredMenuOverviewTab_TableView_2:TableView;
      
      private var UnknownVarFromWiredMenuOverviewTab_TableView_3:TableView;
      
      private var UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1:VariableTypePicker;
      
      private var _highlighter:VariableHoldersHighlighter;
      
      private var _highlightEnabled:Boolean;
      
      private var UnknownVarFromWiredMenuOverviewTab_Int_1:int = 0;
      
      private var UnknownVarFromWiredMenuOverviewTab_Int_2:int = 0;
      
      private var _allVariables:Vector.<WiredVariable>;
      
      private var UnknownVarFromWiredMenuOverviewTab_String_3:String = null;
      
      private var UnknownVarFromWiredMenuOverviewTab_WiredVariable_1:WiredVariable = null;
      
      public function WiredMenuOverviewTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         super(param1,param2);
         _highlighter = new VariableHoldersHighlighter(param1.roomEvents);
         UnknownVarFromWiredMenuOverviewTab_TableView_1 = new TableView(param1.windowManager,variableListContainer);
         UnknownVarFromWiredMenuOverviewTab_TableView_2 = new TableView(param1.windowManager,propertiesTableContainer);
         UnknownVarFromWiredMenuOverviewTab_TableView_3 = new TableView(param1.windowManager,textsTableContainer);
         UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         createVariableList();
         createPropertiesTable();
         createTextTable();
         addMessageEvent(new WiredAllVariableHoldersEvent(onAllVariableHolders));
         highlightHoldersButton.addEventListener("WME_CLICK",onHighlightClick);
         manageButton.addEventListener("WME_CLICK",onManageClick);
      }
      
      private function createVariableList() : void
      {
         var _loc1_:Array = [new TableColumn(LIST_COLUMN_NAME,"",1,"left")];
         UnknownVarFromWiredMenuOverviewTab_TableView_1.initialize(Vector.<TableColumn>(_loc1_),false);
         UnknownVarFromWiredMenuOverviewTab_TableView_1.onRowSelectedCallback = onSelectVariable;
      }
      
      private function createPropertiesTable() : void
      {
         var _loc1_:Array = [new TableColumn(PROPERTIES_COLUMN_PROPERTY,loc("wiredmenu.variable_overview.properties.column.property"),0.52,"left"),new TableColumn(PROPERTIES_COLUMN_VALUE,loc("wiredmenu.variable_overview.properties.column.value"),0.48,"left")];
         UnknownVarFromWiredMenuOverviewTab_TableView_2.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      private function createTextTable() : void
      {
         var _loc1_:Array = [new TableColumn(UnknownVarFromWiredMenuOverviewTab_String_1,loc("wiredmenu.variable_overview.text.column.value"),0.2,"left"),new TableColumn(UnknownVarFromWiredMenuOverviewTab_String_2,loc("wiredmenu.variable_overview.text.column.text"),0.8,"right")];
         UnknownVarFromWiredMenuOverviewTab_TableView_3.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return _allVariables != null;
      }
      
      private function clearData() : void
      {
         _allVariables = null;
      }
      
      private function requestData() : void
      {
         UnknownVarFromWiredMenuOverviewTab_Int_1 = getTimer();
         controller.variablesSynchronizer.getAllVariables(onAllVariables);
      }
      
      private function requestHolders() : void
      {
         UnknownVarFromWiredMenuOverviewTab_Int_2 = getTimer();
         controller.send(new WiredGetAllVariableHoldersMessageComposer(selectedVariableId));
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         _allVariables = param1;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            initializeInterface();
         }
      }
      
      private function onAllVariableHolders(param1:WiredAllVariableHoldersEvent) : void
      {
         var _loc9_:int = 0;
         var _loc8_:Number = NaN;
         if(!_highlightEnabled || !isViewing)
         {
            return;
         }
         var _loc2_:WiredAllVariableHoldersMessageParser = param1.getParser();
         var _loc4_:Vector.<ObjectIdAndValuePair> = _loc2_.variableInfoAndHolders.holders;
         var _loc6_:WiredVariable = _loc2_.variableInfoAndHolders.variable;
         if(_loc6_.variableId != selectedVariableId)
         {
            return;
         }
         if(!_loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS || _loc6_.hasValue && _loc4_.length > MAX_HIGHLIGHTS_WITH_VALUE)
         {
            controller.roomEvents.notifications.addItem(loc("wiredmenu.variable_overview.highlight.error.too_many"),"info","icon_wired_notification_png");
            stopHighlight();
            return;
         }
         var _loc5_:Dictionary = new Dictionary();
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc7_ in _loc4_)
         {
            _loc9_ = int(_loc7_.objectId);
            _loc8_ = _loc6_.hasValue ? _loc7_.value : NaN;
            if(_loc6_.variableTarget == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1)
            {
               _highlighter.highlightObject(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc5_[_loc9_] = true;
            }
            else if(_loc6_.variableTarget == WiredInputSourcePicker.USER_SOURCE)
            {
               _highlighter.highlightUser(_loc9_,Util.variableValueWithString(_loc6_,_loc8_));
               _loc3_[_loc9_] = true;
            }
         }
         _highlighter.removeRemovedHolders(_loc5_,_loc3_);
      }
      
      private function get selectedVariableId() : String
      {
         var _loc1_:WiredVariable = selectedVariable;
         return _loc1_?.variableId;
      }
      
      private function get selectedVariable() : WiredVariable
      {
         if(UnknownVarFromWiredMenuOverviewTab_TableView_1.selected == null)
         {
            return null;
         }
         return VariableTableObject(UnknownVarFromWiredMenuOverviewTab_TableView_1.selected).variable;
      }
      
      override protected function initializeInterface() : void
      {
         if(UnknownVarFromWiredMenuOverviewTab_String_3 != null)
         {
            findFocusVariable(UnknownVarFromWiredMenuOverviewTab_String_3);
            UnknownVarFromWiredMenuOverviewTab_String_3 = null;
         }
         updateVariableListUI();
         updatePropertiesTableUI();
         updateTextTableUI();
         updateButtonsUI();
      }
      
      private function updateVariableListUI() : void
      {
         var _loc5_:ITableObject = null;
         var _loc1_:ITableObject = UnknownVarFromWiredMenuOverviewTab_TableView_1.selected;
         var _loc3_:Vector.<ITableObject> = new Vector.<ITableObject>();
         var _loc2_:* = null;
         for each(var _loc4_ in _allVariables)
         {
            if(!_loc4_.isInvisible)
            {
               if(_loc4_.variableTarget == UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1.selectedType)
               {
                  _loc5_ = new VariableTableObject(_loc4_,controller.roomEvents);
                  if(_loc4_ == UnknownVarFromWiredMenuOverviewTab_WiredVariable_1)
                  {
                     _loc2_ = _loc5_;
                  }
                  _loc3_.push(_loc5_);
               }
            }
         }
         UnknownVarFromWiredMenuOverviewTab_TableView_1.setObjects(_loc3_);
         if(_loc2_ != null)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_1.trySelect(_loc2_);
         }
         else if(_loc1_ == null && _loc3_.length > 0)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_1.trySelect(_loc3_[0]);
         }
         else if(_loc1_ != null)
         {
            if(UnknownVarFromWiredMenuOverviewTab_TableView_1.selected == null)
            {
               UnknownVarFromWiredMenuOverviewTab_TableView_1.trySelect(_loc3_[0]);
            }
         }
         UnknownVarFromWiredMenuOverviewTab_WiredVariable_1 = null;
      }
      
      private function updateButtonsUI() : void
      {
         Util.disableSection(highlightHoldersButton,!canHighlightCurrentVariable);
         Util.disableSection(manageButton,!canManageCurrentVariable);
      }
      
      private function onSelectVariable(param1:VariableTableObject) : void
      {
         UnknownVarFromWiredMenuOverviewTab_TableView_3.resetScrollingNextUpdate();
         updatePropertiesTableUI();
         updateTextTableUI();
         if(_highlightEnabled)
         {
            _highlighter.clear();
            if(canHighlightCurrentVariable)
            {
               requestHolders();
            }
         }
         updateButtonsUI();
      }
      
      private function get canHighlightCurrentVariable() : Boolean
      {
         var _loc1_:WiredVariable = getSelectedVariable();
         return _loc1_ != null && _loc1_.variableType != UnknownHabboCommunicationMessagesIncomingUserdefinedroomeventsWiredcontextVariables1.INTERNAL && (_loc1_.variableTarget == WiredInputSourcePicker.USER_SOURCE || _loc1_.variableTarget == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1);
      }
      
      private function get canManageCurrentVariable() : Boolean
      {
         var _loc1_:WiredVariable = getSelectedVariable();
         return _loc1_ != null && _loc1_.variableTarget == WiredInputSourcePicker.USER_SOURCE && _loc1_.isPersisted;
      }
      
      private function onHighlightClick(param1:WindowMouseEvent) : void
      {
         if(_highlightEnabled)
         {
            stopHighlight();
         }
         else
         {
            startHighlight();
         }
      }
      
      private function onManageClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:WiredVariable = getSelectedVariable();
         if(!canManageCurrentVariable)
         {
            return;
         }
         controller.send(new WiredGetVariableOwnersPageComposer(_loc2_.variableId,1,VariableManagementConfig.PAGE_SIZE,0,-1));
      }
      
      private function startHighlight() : void
      {
         _highlightEnabled = true;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.unhighlight_holders");
         requestHolders();
      }
      
      private function stopHighlight() : void
      {
         _highlightEnabled = false;
         highlightHoldersButton.caption = loc("wiredmenu.variable_overview.highlight_holders");
         _highlighter.clear();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         UnknownVarFromWiredMenuOverviewTab_TableView_1.resetScrollingNextUpdate();
         initializeInterface();
      }
      
      private function updatePropertiesTableUI() : void
      {
         var _loc2_:WiredVariable = getSelectedVariable();
         if(_loc2_ == null)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_2.clear();
            return;
         }
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         _loc1_.push(new PropertyTableObject("name",_loc2_.variableName,localization,true));
         _loc1_.push(new PropertyTableObject("type",getTypeString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("target",getTargetString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("availability",getAvailabilityString(_loc2_),localization));
         _loc1_.push(new PropertyTableObject("has_value",_loc2_.hasValue,localization));
         _loc1_.push(new PropertyTableObject("can_write_to",_loc2_.canWriteValue,localization));
         _loc1_.push(new PropertyTableObject("can_create_delete",_loc2_.canCreateAndDelete,localization));
         _loc1_.push(new PropertyTableObject("can_intercept",_loc2_.canInterceptChanges,localization));
         _loc1_.push(new PropertyTableObject("is_always_available",_loc2_.alwaysAvailable,localization));
         _loc1_.push(new PropertyTableObject("can_read_creation_time",_loc2_.canReadCreationTime,localization));
         _loc1_.push(new PropertyTableObject("can_read_last_update_time",_loc2_.canReadLastUpdateTime,localization));
         _loc1_.push(new PropertyTableObject("is_text_connected",_loc2_.hasTextConnector,localization));
         UnknownVarFromWiredMenuOverviewTab_TableView_2.setObjects(_loc1_);
      }
      
      private function getTypeString(param1:WiredVariable) : String
      {
         return loc("wiredfurni.params.variables.idtype." + param1.variableType);
      }
      
      private function getTargetString(param1:WiredVariable) : String
      {
         switch(param1.variableTarget)
         {
            case WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1:
               return loc("wiredfurni.params.sourcetype.furni");
            case WiredInputSourcePicker.USER_SOURCE:
               return loc("wiredfurni.params.sourcetype.users");
            case VariableExtraSourceTypes.GLOBAL_SOURCE:
               return loc("wiredfurni.params.sourcetype.global");
            case VariableExtraSourceTypes.CONTEXT_SOURCE:
               return loc("wiredfurni.params.sourcetype.context");
            default:
               return "";
         }
      }
      
      private function getAvailabilityString(param1:WiredVariable) : String
      {
         return localization.getLocalization("wiredfurni.params.variables.availability." + param1.availabilityType,loc("wiredfurni.params.variables.availability.misc"));
      }
      
      private function updateTextTableUI() : void
      {
         var _loc4_:String = null;
         var _loc6_:WiredVariable = getSelectedVariable();
         var _loc3_:Boolean = _loc6_ == null || !_loc6_.hasTextConnector;
         if(_loc3_)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_3.clear();
            Util.disableSection(textsTableContainer);
            return;
         }
         if(!textsTableContainer.isEnabled())
         {
            Util.disableSection(textsTableContainer,false);
         }
         var _loc5_:Map = _loc6_.textConnector;
         var _loc2_:Array = _loc5_.getKeys();
         _loc2_.sort(16);
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         if(_loc2_.length <= MAX_TEXT_CONNECTIONS)
         {
            for each(var _loc7_ in _loc2_)
            {
               _loc4_ = _loc5_.getValue(_loc7_);
               _loc1_.push(new TextTableObject(_loc7_,_loc4_));
            }
         }
         UnknownVarFromWiredMenuOverviewTab_TableView_3.setObjects(_loc1_);
      }
      
      private function getSelectedVariable() : WiredVariable
      {
         var _loc1_:ITableObject = UnknownVarFromWiredMenuOverviewTab_TableView_1.selected;
         if(_loc1_ == null)
         {
            return null;
         }
         return (_loc1_ as VariableTableObject).variable;
      }
      
      override public function stopViewing() : void
      {
         super.stopViewing();
         if(_highlightEnabled)
         {
            _highlighter.clear();
         }
      }
      
      public function jumpToVariableByName(param1:String) : void
      {
         if(isDataReady())
         {
            findFocusVariable(param1);
            initializeInterface();
         }
         else
         {
            UnknownVarFromWiredMenuOverviewTab_String_3 = param1;
         }
      }
      
      private function findFocusVariable(param1:String) : void
      {
         var _loc2_:WiredVariable = getVariableByNameOrPrefix(param1);
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1.selectedType = _loc2_.variableTarget;
         UnknownVarFromWiredMenuOverviewTab_WiredVariable_1 = _loc2_;
      }
      
      private function getVariableByNameOrPrefix(param1:String) : WiredVariable
      {
         var _loc2_:* = null;
         for each(var _loc3_ in _allVariables)
         {
            if(!_loc3_.isInvisible)
            {
               if(_loc3_.variableName == param1)
               {
                  return _loc3_;
               }
               if(_loc2_ == null && _loc3_.variableName.indexOf(param1 + ".") == 0)
               {
                  _loc2_ = _loc3_;
               }
            }
         }
         return _loc2_;
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1.update(param1);
         var _loc2_:int = getTimer();
         if(UnknownVarFromWiredMenuOverviewTab_Int_1 < _loc2_ - POLL_MS)
         {
            requestData();
         }
         if(canHighlightCurrentVariable && _highlightEnabled && UnknownVarFromWiredMenuOverviewTab_Int_2 < _loc2_ - POLL_MS)
         {
            requestHolders();
         }
         _highlighter.update(param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var _loc1_:UnknownICoreWindowComponents4 = highlightHoldersButton;
         if(_loc1_ != null)
         {
            _loc1_.removeEventListener("WME_CLICK",onHighlightClick);
         }
         var _loc2_:UnknownICoreWindowComponents4 = manageButton;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener("WME_CLICK",onManageClick);
         }
         if(controller != null && controller.variablesSynchronizer != null)
         {
            controller.variablesSynchronizer.removeListener(onAllVariables);
         }
         if(UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1 != null)
         {
            UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1.dispose();
         }
         UnknownVarFromWiredMenuOverviewTab_VariableTypePicker_1 = null;
         if(UnknownVarFromWiredMenuOverviewTab_TableView_1 != null)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_1.dispose();
         }
         UnknownVarFromWiredMenuOverviewTab_TableView_1 = null;
         if(UnknownVarFromWiredMenuOverviewTab_TableView_2 != null)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_2.dispose();
         }
         UnknownVarFromWiredMenuOverviewTab_TableView_2 = null;
         if(UnknownVarFromWiredMenuOverviewTab_TableView_3 != null)
         {
            UnknownVarFromWiredMenuOverviewTab_TableView_3.dispose();
         }
         UnknownVarFromWiredMenuOverviewTab_TableView_3 = null;
         _allVariables = null;
         if(_highlighter != null)
         {
            _highlighter.dispose();
         }
         _highlighter = null;
         super.dispose();
      }
      
      private function get variableListContainer() : IWindowController_1
      {
         return container.findChildByName("variable_list_container") as IWindowController_1;
      }
      
      private function get propertiesTableContainer() : IWindowController_1
      {
         return container.findChildByName("variable_properties_table_container") as IWindowController_1;
      }
      
      private function get textsTableContainer() : IWindowController_1
      {
         return container.findChildByName("variable_texts_table_container") as IWindowController_1;
      }
      
      private function get highlightHoldersButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("highlight_holders_button") as UnknownICoreWindowComponents4;
      }
      
      private function get manageButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("manage_button") as UnknownICoreWindowComponents4;
      }
      
      private function get typePickerContainer() : IWindowController_1
      {
         return container.findChildByName("type_picker_container") as IWindowController_1;
      }
   }
}

