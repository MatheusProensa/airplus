package com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredMenuErrorEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredObjectInspectionData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredVariablesForObjectEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetVariablesForObjectMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetObjectVariableValueMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredMenuErrorMessageParser;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.common.VariableTypePicker;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.VariableHoldersHighlighter;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class WiredMenuInspectionTab extends WiredMenuDefaultTab implements IProfiler_1
   {
      private static var POLL_VARIABLES_MS:uint = 500;
      
      private static var STATE_NOTHING:int = 0;
      
      private static var STATE_FETCHING_HOLDING_VARIABLES:int = 1;
      
      private static var STATE_AWAITING_VARIABLES:int = 2;
      
      private static var STATE_DISPLAYING:int = 3;
      
      public static var VARIABLES_COLUMN_VARIABLE:String = "variable";
      
      public static var VARIABLES_COLUMN_VALUE:String = "value";
      
      private var UnknownVarFromWiredMenuInspectionTab_TableView_1:TableView;
      
      private var UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1:VariableTypePicker;
      
      private var UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1:VariableHolderPreviewer;
      
      private var UnknownVarFromWiredMenuInspectionTab_Int_1:int = STATE_NOTHING;
      
      private var UnknownVarFromWiredMenuInspectionTab_Int_2:int = 0;
      
      private var UnknownVarFromWiredMenuInspectionTab_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1:WiredObjectInspectionData = null;
      
      private var UnknownVarFromWiredMenuInspectionTab_Int_3:int = -1;
      
      private var UnknownVarFromWiredMenuInspectionTab_Int_4:int = 0;
      
      private var _highlightingForFurni:int = -1;
      
      private var _highlighter:VariableHoldersHighlighter;
      
      private var UnknownVarFromWiredMenuInspectionTab_Int_5:int = -1;
      
      private var UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1:NewVariablePicker;
      
      public function WiredMenuInspectionTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         super(param1,param2);
         _highlighter = new VariableHoldersHighlighter(param1.roomEvents);
         UnknownVarFromWiredMenuInspectionTab_TableView_1 = new TableView(param1.windowManager,variableValuesTableContainer);
         UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1 = new VariableTypePicker(typePickerContainer,onSelectVariableType);
         UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1 = new VariableHolderPreviewer(previewContainer,param1);
         createVariableValuesTable();
         createCreateVariableBubble();
         updateTableUI();
         updatePreviewUI();
         addMessageEvent(new WiredVariablesForObjectEvent(onWiredVariablesForObject));
         addMessageEvent(new WiredMenuErrorEvent(onWiredMenuError));
         highlightWiredButton.addEventListener("WME_CLICK",onHighlightWiredsClicked);
         deleteVariableButton.addEventListener("WME_CLICK",onDeleteVariableClicked);
         addVariableButton.addEventListener("WME_CLICK",onAddVariableClicked);
         createVariableButton.addEventListener("WME_CLICK",onCreateVariableClicked);
         param2.procedure = windowProcedure;
      }
      
      private function createVariableValuesTable() : void
      {
         var _loc1_:Array = [new TableColumn(VARIABLES_COLUMN_VARIABLE,loc("wiredmenu.inspection.variables.variable"),0.65,"left"),new TableColumn(VARIABLES_COLUMN_VALUE,loc("wiredmenu.inspection.variables.value"),0.35,"right")];
         UnknownVarFromWiredMenuInspectionTab_TableView_1.initialize(Vector.<TableColumn>(_loc1_));
         UnknownVarFromWiredMenuInspectionTab_TableView_1.onCellEditCallback = onCellEdit;
         UnknownVarFromWiredMenuInspectionTab_TableView_1.onRowSelectedCallback = onRowSelected;
      }
      
      private function createCreateVariableBubble() : void
      {
         var _loc1_:HabboUserDefinedRoomEvents = controller.roomEvents;
         var _loc3_:PresetManager = _loc1_.wiredCtrl.presetManager;
         var _loc2_:IWindowController_1 = _loc3_.createLayout("search_tree_dropdown") as IWindowController_1;
         variablePickerContainer.addChild(_loc2_);
         UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1 = new NewVariablePicker(controller.roomEvents,_loc2_,variableFilter,onChangeCreateVariable);
         UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1.width = variablePickerContainer.width;
         createVariableBubble.visible = false;
      }
      
      private function onChangeCreateVariable(param1:WiredVariable) : void
      {
         Util.disableSection(valueSettingContainer,param1 != null && !param1.hasValue);
         Util.disableSection(createVariableButton,param1 == null);
      }
      
      private function variableFilter(param1:WiredVariable) : Boolean
      {
         return param1.canCreateAndDelete && (UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 == null || !UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.variableValues.hasKey(param1.variableId));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         maybePollNewVariables(false);
      }
      
      private function maybePollNewVariables(param1:Boolean = true) : void
      {
         if(UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING)
         {
            if(!param1)
            {
               UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_FETCHING_HOLDING_VARIABLES;
               updateLoadingState();
            }
            requestVariablesForObject(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type,getObjectIdForType());
         }
      }
      
      private function getObjectIdForType() : int
      {
         if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type == WiredInputSourcePicker.USER_SOURCE)
         {
            return UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.userIndex;
         }
         if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            return UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.objectId;
         }
         return 0;
      }
      
      override protected function isDataReady() : Boolean
      {
         return UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_NOTHING || UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING;
      }
      
      private function clearDataAndState() : void
      {
         UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_NOTHING;
         var _loc1_:WiredObjectInspectionData = UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1;
         UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 = null;
         onDataChanged(_loc1_,null);
         updateTableUI();
      }
      
      private function onCellEdit(param1:ITableObject, param2:String, param3:String) : void
      {
         if(param2 != VARIABLES_COLUMN_VALUE)
         {
            return;
         }
         var _loc5_:VariableValueTableObject = param1 as VariableValueTableObject;
         var _loc4_:WiredVariable = _loc5_.variable;
         if(!controller.hasWritePermission || !_loc4_.hasValue || !_loc4_.canWriteValue)
         {
            return;
         }
         var _loc6_:int = Util.getIntFromString(param3,-2147483648,true);
         if(_loc6_ != -2147483648)
         {
            controller.send(new WiredSetObjectVariableValueMessageComposer(_loc4_.variableTarget,getObjectIdForType(),_loc4_.variableId,_loc6_,0));
         }
      }
      
      private function onAddVariableClicked(param1:WindowMouseEvent) : void
      {
         if(createVariableBubble.visible)
         {
            createVariableBubble.visible = false;
         }
         else
         {
            controller.roomEvents.variablesSynchronizer.getAllVariables(initializeCreateVariableBubble,true);
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && Boolean(createVariableBubble.visible))
         {
            if(param2.name != "add_var_btn" && !createVariableBubble.windowIsChild(param2))
            {
               createVariableBubble.visible = false;
            }
         }
      }
      
      private function initializeCreateVariableBubble(param1:Vector.<WiredVariable>) : void
      {
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_);
         }
         UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1.init(new VariableList(_loc3_),"",UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType);
         Util.disableSection(createVariableButton,true);
         createVariableBubble.visible = true;
      }
      
      private function onDeleteVariableClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 == null)
         {
            return;
         }
         var _loc3_:VariableValueTableObject = UnknownVarFromWiredMenuInspectionTab_TableView_1.selected as VariableValueTableObject;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:WiredVariable = _loc3_.variable;
         if(!controller.hasWritePermission || !_loc2_.canCreateAndDelete)
         {
            return;
         }
         UnknownVarFromWiredMenuInspectionTab_Int_5 = UnknownVarFromWiredMenuInspectionTab_TableView_1.getIndexOfObject(_loc3_);
         controller.send(new WiredSetObjectVariableValueMessageComposer(_loc2_.variableTarget,getObjectIdForType(),_loc2_.variableId,0,2));
      }
      
      private function onCreateVariableClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 == null)
         {
            return;
         }
         var _loc2_:WiredVariable = UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1.selected;
         UnknownVarFromWiredMenuInspectionTab_NewVariablePicker_1.finalize();
         var _loc3_:int = 0;
         if(_loc2_.hasValue)
         {
            _loc3_ = int(valueInput.text);
         }
         controller.send(new WiredSetObjectVariableValueMessageComposer(_loc2_.variableTarget,getObjectIdForType(),_loc2_.variableId,_loc3_,1));
         createVariableBubble.visible = false;
         valueInput.text = "0";
      }
      
      private function onWiredVariablesForObject(param1:WiredVariablesForObjectEvent) : void
      {
         if(UnknownVarFromWiredMenuInspectionTab_Int_1 != STATE_FETCHING_HOLDING_VARIABLES && UnknownVarFromWiredMenuInspectionTab_Int_1 != STATE_DISPLAYING)
         {
            return;
         }
         var _loc3_:WiredObjectInspectionData = param1.getParser().data;
         if(_loc3_.type != UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType)
         {
            return;
         }
         var _loc2_:WiredObjectInspectionData = UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1;
         UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 = _loc3_;
         onDataChanged(_loc2_,UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1);
         UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_AWAITING_VARIABLES;
         if(!controller.variablesSynchronizer.getAllVariables(onAllVariables,!allVariablesAvailable))
         {
            updateLoadingState();
         }
      }
      
      private function onWiredMenuError(param1:WiredMenuErrorEvent) : void
      {
         var _loc2_:WiredMenuErrorMessageParser = param1.getParser();
         if(_loc2_.errorCode == WiredMenuErrorMessageParser.UnknownVarFromWiredMenuErrorMessageParser_Int_1)
         {
            if(UnknownVarFromWiredMenuInspectionTab_Int_1 != STATE_DISPLAYING)
            {
               clearDataAndState();
               updatePreviewUI();
               updateLoadingState();
            }
         }
      }
      
      private function get allVariablesAvailable() : Boolean
      {
         for each(var _loc1_ in UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.variableValues.getKeys())
         {
            if(!(_loc1_ in UnknownVarFromWiredMenuInspectionTab_Dictionary_1))
            {
               return false;
            }
         }
         return true;
      }
      
      private function updatePreviewUI() : void
      {
         var _loc1_:* = UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == VariableExtraSourceTypes.GLOBAL_SOURCE;
         Util.disableSection(pinContainer,_loc1_);
         var _loc2_:* = UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
         var _loc3_:* = UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.USER_SOURCE;
         Util.disableSection(highlightWiredButton,UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 == null || UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type != WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 || UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.configuredInWireds == null || UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.configuredInWireds.length == 0);
         highlightWiredButton.visible = _loc2_;
         if(_loc1_)
         {
            UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.setGlobalPlaceholder();
            return;
         }
         if(!_loc2_ && !_loc3_)
         {
            UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.clearPreviewer();
            return;
         }
         if(UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_NOTHING)
         {
            if(_loc2_)
            {
               UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.setFurniInstructions();
            }
            else if(_loc3_)
            {
               UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.setUserInstructions();
            }
         }
         else if(UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING)
         {
            if(_loc2_)
            {
               UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.setFurniByObjectId(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.objectId);
            }
            else if(_loc3_)
            {
               UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.setPreviewByUserIndex(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.userIndex);
            }
         }
      }
      
      private function onHighlightWiredsClicked(param1:WindowMouseEvent) : void
      {
         _highlighter.clear();
         if(_highlightingForFurni == -1 && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 != null && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.configuredInWireds != null && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.configuredInWireds.length > 0)
         {
            for each(var _loc2_ in UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.configuredInWireds)
            {
               _highlighter.highlightObject(_loc2_,null);
            }
            _highlightingForFurni = UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.objectId;
         }
         else
         {
            _highlightingForFurni = -1;
         }
      }
      
      private function onDataChanged(param1:WiredObjectInspectionData, param2:WiredObjectInspectionData) : void
      {
         if(param2 == null)
         {
            clearHighlights();
         }
         if(param2 != null && _highlightingForFurni != -1 && (param2.type != WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 || param2.objectId != _highlightingForFurni))
         {
            clearHighlights();
         }
         if(param1 == null || param2 == null || param1.type != param2.type || param1.objectId != param2.objectId || param1.userIndex != param2.userIndex)
         {
            createVariableBubble.visible = false;
         }
      }
      
      private function clearHighlights() : void
      {
         _highlighter.clear();
         _highlightingForFurni = -1;
      }
      
      override public function stopViewing() : void
      {
         super.stopViewing();
         clearHighlights();
         createVariableBubble.visible = false;
      }
      
      private function updateTableUI() : void
      {
         var _loc4_:WiredVariable = null;
         var _loc5_:Map = null;
         var _loc1_:Array = null;
         var _loc3_:Boolean = false;
         var _loc2_:* = undefined;
         if(UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_NOTHING)
         {
            UnknownVarFromWiredMenuInspectionTab_TableView_1.clear();
            Util.disableSection(variableValuesTableContainer);
         }
         else if(UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING)
         {
            if(!variableValuesTableContainer.isEnabled())
            {
               Util.disableSection(variableValuesTableContainer,false);
            }
            _loc5_ = UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.variableValues;
            _loc1_ = [];
            for each(var _loc6_ in _loc5_.getKeys())
            {
               _loc4_ = UnknownVarFromWiredMenuInspectionTab_Dictionary_1[_loc6_];
               if(_loc4_ != null)
               {
                  _loc1_.push(_loc4_);
               }
            }
            Util.sortVariables(_loc1_);
            _loc3_ = getObjectIdForType() == UnknownVarFromWiredMenuInspectionTab_Int_4 && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type == UnknownVarFromWiredMenuInspectionTab_Int_3;
            _loc2_ = new Vector.<ITableObject>();
            for each(_loc4_ in _loc1_)
            {
               if(!_loc4_.isInvisible)
               {
                  _loc2_.push(new VariableValueTableObject(_loc4_,_loc5_.getValue(_loc4_.variableId),controller.hasWritePermission,_loc3_,controller.roomEvents));
               }
            }
            UnknownVarFromWiredMenuInspectionTab_TableView_1.setObjects(_loc2_);
            UnknownVarFromWiredMenuInspectionTab_Int_4 = getObjectIdForType();
            UnknownVarFromWiredMenuInspectionTab_Int_3 = UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type;
         }
         updateButtonsUI();
      }
      
      private function updateButtonsUI() : void
      {
         var _loc3_:VariableValueTableObject = null;
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(controller.hasWritePermission)
         {
            _loc3_ = UnknownVarFromWiredMenuInspectionTab_TableView_1.selected as VariableValueTableObject;
            if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 != null && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type != VariableExtraSourceTypes.GLOBAL_SOURCE)
            {
               if(_loc3_ != null && _loc3_.variable != null && _loc3_.variable.canCreateAndDelete)
               {
                  _loc2_ = true;
               }
               _loc1_ = true;
            }
         }
         Util.disableSection(deleteVariableButton,!_loc2_);
         Util.disableSection(addVariableButton,!_loc1_);
      }
      
      private function onRowSelected(param1:VariableValueTableObject) : void
      {
         var _loc2_:VariableValueTableObject = null;
         updateButtonsUI();
         if(param1 == null && UnknownVarFromWiredMenuInspectionTab_Int_5 != -1)
         {
            _loc2_ = UnknownVarFromWiredMenuInspectionTab_TableView_1.getObjectByIndex(UnknownVarFromWiredMenuInspectionTab_Int_5) as VariableValueTableObject;
            UnknownVarFromWiredMenuInspectionTab_TableView_1.trySelect(_loc2_);
            UnknownVarFromWiredMenuInspectionTab_Int_5 = -1;
         }
      }
      
      private function onAllVariables(param1:Vector.<WiredVariable>) : void
      {
         UnknownVarFromWiredMenuInspectionTab_Dictionary_1 = new Dictionary();
         for each(var _loc2_ in param1)
         {
            UnknownVarFromWiredMenuInspectionTab_Dictionary_1[_loc2_.variableId] = _loc2_;
         }
         if(UnknownVarFromWiredMenuInspectionTab_Int_1 != STATE_AWAITING_VARIABLES)
         {
            return;
         }
         UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_DISPLAYING;
         updateTableUI();
         updateLoadingState();
         updatePreviewUI();
      }
      
      private function onSelectVariableType(param1:int) : void
      {
         clearDataAndState();
         initializeInterface();
         if(param1 == VariableExtraSourceTypes.GLOBAL_SOURCE)
         {
            UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_FETCHING_HOLDING_VARIABLES;
            requestVariablesForObject(param1,0);
            updateLoadingState();
         }
         updatePreviewUI();
         updateButtonsUI();
      }
      
      private function requestVariablesForObject(param1:int, param2:int) : void
      {
         UnknownVarFromWiredMenuInspectionTab_Int_2 = getTimer();
         controller.send(new WiredGetVariablesForObjectMessageComposer(param1,param2));
      }
      
      public function inspectFurni(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
         if(param2 && !_loc3_)
         {
            UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType = WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 != null && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1 && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.objectId == param1)
            {
               return;
            }
            UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1,param1);
         }
      }
      
      public function inspectUser(param1:int, param2:Boolean = false) : void
      {
         if(!isViewing)
         {
            return;
         }
         if(pinCheckbox.isSelected && UnknownVarFromWiredMenuInspectionTab_Int_1 == STATE_DISPLAYING && !param2)
         {
            return;
         }
         if(param2)
         {
            pinCheckbox.select();
         }
         var _loc3_:* = UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.USER_SOURCE;
         if(param2 && !_loc3_)
         {
            UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType = WiredInputSourcePicker.USER_SOURCE;
            updatePreviewUI();
         }
         else if(!_loc3_)
         {
            return;
         }
         if(UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.selectedType == WiredInputSourcePicker.USER_SOURCE)
         {
            if(UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 != null && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.type == WiredInputSourcePicker.USER_SOURCE && UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1.userIndex == param1)
            {
               return;
            }
            UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_FETCHING_HOLDING_VARIABLES;
            updateLoadingState();
            requestVariablesForObject(WiredInputSourcePicker.USER_SOURCE,param1);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(controller != null && controller.variablesSynchronizer != null)
         {
            controller.variablesSynchronizer.removeListener(onAllVariables);
         }
         UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.dispose();
         UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1 = null;
         UnknownVarFromWiredMenuInspectionTab_TableView_1.dispose();
         UnknownVarFromWiredMenuInspectionTab_TableView_1 = null;
         UnknownVarFromWiredMenuInspectionTab_Int_1 = STATE_NOTHING;
         UnknownVarFromWiredMenuInspectionTab_Dictionary_1 = null;
         UnknownVarFromWiredMenuInspectionTab_WiredObjectInspectionData_1 = null;
         UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1.dispose();
         UnknownVarFromWiredMenuInspectionTab_VariableHolderPreviewer_1 = null;
         _highlighter.dispose();
         _highlighter = null;
         super.dispose();
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         UnknownVarFromWiredMenuInspectionTab_VariableTypePicker_1.update(param1);
         var _loc2_:int = getTimer();
         if(UnknownVarFromWiredMenuInspectionTab_Int_2 < _loc2_ - POLL_VARIABLES_MS && isDataReady())
         {
            maybePollNewVariables();
         }
         _highlighter.update(param1);
      }
      
      private function get variableValuesTableContainer() : IWindowController_1
      {
         return container.findChildByName("variable_values_table_container") as IWindowController_1;
      }
      
      private function get typePickerContainer() : IWindowController_1
      {
         return container.findChildByName("type_picker_container") as IWindowController_1;
      }
      
      private function get previewContainer() : IWindowController_1
      {
         return container.findChildByName("preview_container") as IWindowController_1;
      }
      
      private function get pinContainer() : IWindowController_1
      {
         return container.findChildByName("pin_option_container") as IWindowController_1;
      }
      
      private function get pinCheckbox() : UnknownICoreWindowComponents2
      {
         return container.findChildByName("pin_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get highlightWiredButton() : UnknownICoreWindowComponents5
      {
         return container.findChildByName("highlight_wired_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get deleteVariableButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("delete_var_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get addVariableButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("add_var_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get createVariableBubble() : IBubbleController
      {
         return container.findChildByName("create_var_bubble") as IBubbleController;
      }
      
      private function get variablePickerContainer() : IWindowController_1
      {
         return createVariableBubble.findChildByName("var_picker_container") as IWindowController_1;
      }
      
      private function get valueInputBorder() : UnknownICoreWindowComponents6
      {
         return createVariableBubble.findChildByName("value_input_border") as UnknownICoreWindowComponents6;
      }
      
      private function get valueInput() : ITextWindow
      {
         return createVariableBubble.findChildByName("value_input") as ITextWindow;
      }
      
      private function get createVariableButton() : UnknownICoreWindowComponents4
      {
         return createVariableBubble.findChildByName("create_var_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get variableSettingContainer() : IWindowController_1
      {
         return createVariableBubble.findChildByName("variable_setting") as IWindowController_1;
      }
      
      private function get valueSettingContainer() : IWindowController_1
      {
         return createVariableBubble.findChildByName("value_setting") as IWindowController_1;
      }
   }
}

