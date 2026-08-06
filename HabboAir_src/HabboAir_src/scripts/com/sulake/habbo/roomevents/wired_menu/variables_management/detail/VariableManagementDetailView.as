package com.sulake.habbo.roomevents.wired_menu.variables_management.detail
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.VariableList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management.WiredGetUserPermanentVariablesComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.variables_management.WiredSetUserPermanentVariableComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management.WiredUserPermanentVariablesList;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management.WiredVariableStorageParameter;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.VariableValueTableObject;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.utils.LoadingIcon;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   
   public class VariableManagementDetailView implements IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      public static var VARIABLES_COLUMN_VARIABLE:String = "variable";
      
      public static var VARIABLES_COLUMN_VALUE:String = "value";
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1:VariableManagementDetailController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _loadingIcon:LoadingIcon;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromVariableManagementDetailView_TableView_1:TableView;
      
      private var UnknownVarFromVariableManagementDetailView_NewVariablePicker_1:NewVariablePicker;
      
      private var UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1:PermanentVariableHolderPreviewer;
      
      public function VariableManagementDetailView(param1:VariableManagementDetailController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.assets.getAssetByName("variables_management_detail_xml").content),1) as IFrameController;
         _loadingIcon = new LoadingIcon();
         UnknownVarFromVariableManagementDetailView_TableView_1 = new TableView(param2,variableValuesTableContainer);
         UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1 = new PermanentVariableHolderPreviewer(previewWindow,UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents.wiredMenu);
         createVariableValuesTable();
         createCreateVariableBubble();
         refreshButton.addEventListener("WME_CLICK",onRefreshClick);
         closeButton.addEventListener("WME_CLICK",onClose);
         deleteVariableButton.addEventListener("WME_CLICK",onDeleteVariableClicked);
         addVariableButton.addEventListener("WME_CLICK",onAddVariableClicked);
         createVariableButton.addEventListener("WME_CLICK",onCreateVariableClicked);
         _window.procedure = windowProcedure;
         hide();
      }
      
      private function onRefreshClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.send(new WiredGetUserPermanentVariablesComposer(_loc2_.entityType,_loc2_.entityId));
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      private function createVariableValuesTable() : void
      {
         var _loc1_:Array = [new TableColumn(VARIABLES_COLUMN_VARIABLE,UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.localizationManager.getLocalization("wiredmenu.inspection.variables.variable"),0.65,"left"),new TableColumn(VARIABLES_COLUMN_VALUE,UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.localizationManager.getLocalization("wiredmenu.inspection.variables.value"),0.35,"right")];
         UnknownVarFromVariableManagementDetailView_TableView_1.initialize(Vector.<TableColumn>(_loc1_));
         UnknownVarFromVariableManagementDetailView_TableView_1.onCellEditCallback = onCellEdit;
         UnknownVarFromVariableManagementDetailView_TableView_1.onRowSelectedCallback = onRowSelected;
      }
      
      private function createCreateVariableBubble() : void
      {
         var _loc1_:HabboUserDefinedRoomEvents = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents;
         var _loc3_:PresetManager = _loc1_.wiredCtrl.presetManager;
         var _loc2_:IWindowController_1 = _loc3_.createLayout("search_tree_dropdown") as IWindowController_1;
         variablePickerContainer.addChild(_loc2_);
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1 = new NewVariablePicker(UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents,_loc2_,variableFilter,onChangeCreateVariable);
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1.width = variablePickerContainer.width;
         createVariableBubble.visible = false;
      }
      
      private function onChangeCreateVariable(param1:WiredVariable) : void
      {
         Util.disableSection(valueSettingContainer,param1 != null && !param1.hasValue);
         Util.disableSection(createVariableButton,param1 == null);
      }
      
      private function variableFilter(param1:WiredVariable) : Boolean
      {
         var _loc2_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         return param1.canCreateAndDelete && (_loc2_ == null || !(param1.variableId in _loc2_.variableIds)) && param1.isPersisted;
      }
      
      private function onCellEdit(param1:ITableObject, param2:String, param3:String) : void
      {
         if(param2 != VARIABLES_COLUMN_VALUE)
         {
            return;
         }
         var _loc6_:VariableValueTableObject = param1 as VariableValueTableObject;
         var _loc5_:WiredVariable = _loc6_.variable;
         if(!hasWritePermission || !_loc5_.hasValue || !_loc5_.canWriteValue)
         {
            return;
         }
         var _loc4_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         var _loc7_:int = Util.getIntFromString(param3,-2147483648,true);
         if(_loc7_ != -2147483648)
         {
            UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.send(new WiredSetUserPermanentVariableComposer(_loc4_.entityType,_loc4_.entityId,_loc5_.variableId,_loc7_,0));
            _loadingIcon.setVisible(loadingIconWindow,true);
         }
      }
      
      private function get hasWritePermission() : Boolean
      {
         return UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents.wiredMenu.hasWritePermission;
      }
      
      private function onAddVariableClicked(param1:WindowMouseEvent) : void
      {
         if(createVariableBubble.visible)
         {
            createVariableBubble.visible = false;
         }
         else
         {
            UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents.variablesSynchronizer.getAllVariables(initializeCreateVariableBubble,true);
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
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1.init(new VariableList(_loc3_),"",WiredInputSourcePicker.USER_SOURCE);
         Util.disableSection(createVariableButton,true);
         createVariableBubble.visible = true;
      }
      
      private function onDeleteVariableClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data == null)
         {
            return;
         }
         var _loc4_:VariableValueTableObject = UnknownVarFromVariableManagementDetailView_TableView_1.selected as VariableValueTableObject;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:WiredVariable = _loc4_.variable;
         if(!hasWritePermission || !_loc3_.canCreateAndDelete)
         {
            return;
         }
         var _loc2_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.send(new WiredSetUserPermanentVariableComposer(_loc2_.entityType,_loc2_.entityId,_loc3_.variableId,0,2));
         _loadingIcon.setVisible(loadingIconWindow,true);
      }
      
      private function onCreateVariableClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data == null)
         {
            return;
         }
         var _loc3_:WiredVariable = UnknownVarFromVariableManagementDetailView_NewVariablePicker_1.selected;
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1.finalize();
         var _loc4_:int = 0;
         if(_loc3_.hasValue)
         {
            _loc4_ = int(valueInput.text);
         }
         var _loc2_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.send(new WiredSetUserPermanentVariableComposer(_loc2_.entityType,_loc2_.entityId,_loc3_.variableId,_loc4_,1));
         _loadingIcon.setVisible(loadingIconWindow,true);
         createVariableBubble.visible = false;
         valueInput.text = "0";
      }
      
      private function onRowSelected(param1:VariableValueTableObject) : void
      {
         updateButtonsUI();
      }
      
      private function updateButtonsUI() : void
      {
         var _loc3_:VariableValueTableObject = null;
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(hasWritePermission)
         {
            _loc3_ = UnknownVarFromVariableManagementDetailView_TableView_1.selected as VariableValueTableObject;
            if(_loc3_ != null && _loc3_.variable != null && _loc3_.variable.canCreateAndDelete)
            {
               _loc2_ = true;
            }
            _loc1_ = true;
         }
         Util.disableSection(deleteVariableButton,!_loc2_);
         Util.disableSection(addVariableButton,!_loc1_);
      }
      
      public function displayNewData() : void
      {
         var _loc1_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         if(_loc1_ == null)
         {
            return;
         }
         updateTableviewUI();
         updatePreviewUI();
         updateInfoBoxUI();
         updateButtonsUI();
         _loadingIcon.setVisible(loadingIconWindow,false);
         UnknownVarFromVariableManagementDetailView_TableView_1.scrollToTop();
         _window.activate();
      }
      
      private function updatePreviewUI() : void
      {
         var _loc2_:int = 0;
         var _loc1_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         if(_loc1_ == null)
         {
            UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1.clearPreviewer();
            return;
         }
         if(_loc1_.entityType == 2)
         {
            UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1.setPetPreview(_loc1_.entityFigure);
         }
         else
         {
            _loc2_ = _loc1_.entityId;
            UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1.setUserPreview(_loc1_.entityFigure,_loc2_);
         }
      }
      
      private function updateInfoBoxUI() : void
      {
         var _loc1_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         if(_loc1_ == null)
         {
            infoBoxText.text = "";
            return;
         }
         if(_loc1_.entityType == 1)
         {
            infoBoxText.text = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.user","","name",_loc1_.entityName,"id",_loc1_.entityId);
         }
         else if(_loc1_.entityType == 2)
         {
            infoBoxText.text = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.pet","","name",_loc1_.entityName,"id",_loc1_.entityId,"owner_name",_loc1_.ownerName,"owner_id",_loc1_.ownerId);
         }
         else if(_loc1_.entityType == 4)
         {
            infoBoxText.text = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.localizationManager.getLocalizationWithParams("wiredmenu.variable_management_detail.info.bot","","name",_loc1_.entityName,"id",_loc1_.entityId,"owner_name",_loc1_.ownerName,"owner_id",_loc1_.ownerId);
         }
      }
      
      public function updateTableviewUI() : void
      {
         var _loc6_:WiredVariable = null;
         var _loc5_:Boolean = false;
         var _loc4_:WiredUserPermanentVariablesList = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.data;
         var _loc2_:Array = [];
         var _loc1_:Map = new Map();
         for each(var _loc7_ in _loc4_.variableStorage)
         {
            _loc6_ = UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.variablesById[_loc7_.variableId];
            if(_loc6_ != null)
            {
               _loc2_.push(_loc6_);
               _loc1_.add(_loc6_.variableId,_loc7_.value);
            }
         }
         Util.sortVariables(_loc2_);
         var _loc3_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(_loc6_ in _loc2_)
         {
            if(!_loc6_.isInvisible)
            {
               _loc5_ = hasWritePermission && _loc6_.hasValue && _loc6_.canWriteValue;
               _loc3_.push(new VariableValueTableObject(_loc6_,_loc1_.getValue(_loc6_.variableId),_loc5_,false,UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1.roomEvents));
            }
         }
         UnknownVarFromVariableManagementDetailView_TableView_1.setObjects(_loc3_);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1.dispose();
         UnknownVarFromVariableManagementDetailView_NewVariablePicker_1 = null;
         _loadingIcon.dispose();
         _loadingIcon = null;
         UnknownVarFromVariableManagementDetailView_TableView_1.dispose();
         UnknownVarFromVariableManagementDetailView_TableView_1 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromVariableManagementDetailView_VariableManagementDetailController_1 = null;
         _windowManager = null;
         UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1.dispose();
         UnknownVarFromVariableManagementDetailView_PermanentVariableHolderPreviewer_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get refreshButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("refresh_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get loadingIconWindow() : IIconWindow
      {
         return _window.findChildByName("searching_icon") as IIconWindow;
      }
      
      private function get previewWindow() : IWindowController_1
      {
         return _window.findChildByName("info_box") as IWindowController_1;
      }
      
      private function get infoBoxText() : ITextFieldWindow
      {
         return _window.findChildByName("info_box_text") as ITextFieldWindow;
      }
      
      private function get variableValuesTableContainer() : IWindowController_1
      {
         return _window.findChildByName("variable_values_table_container") as IWindowController_1;
      }
      
      private function get deleteVariableButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("delete_var_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get addVariableButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("add_var_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get createVariableBubble() : IBubbleController
      {
         return _window.findChildByName("create_var_bubble") as IBubbleController;
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
      
      private function get valueSettingContainer() : IWindowController_1
      {
         return createVariableBubble.findChildByName("value_setting") as IWindowController_1;
      }
   }
}

