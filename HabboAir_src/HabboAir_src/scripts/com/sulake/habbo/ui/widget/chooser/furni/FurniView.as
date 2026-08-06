package com.sulake.habbo.ui.widget.chooser.furni
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.Dictionary;
   
   public class FurniView
   {
      public static var COLUMN_FURNI_NAME:String = "name";
      
      public static var COLUMN_FURNI_OWNER:String = "owner";
      
      public static var COLUMN_ID:String = "id";
      
      private var UnknownVarFromFurniView_FurniChooserWidget_1:FurniChooserWidget;
      
      private var UnknownVarFromFurniView_String_1:String;
      
      private var UnknownVarFromFurniView_TableView_1:TableView;
      
      private var _window:IFrameController;
      
      private var _ignoreListeners:Boolean;
      
      public function FurniView(param1:FurniChooserWidget, param2:String)
      {
         super();
         UnknownVarFromFurniView_FurniChooserWidget_1 = param1;
         UnknownVarFromFurniView_String_1 = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function isOpen() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = XmlAsset(UnknownVarFromFurniView_FurniChooserWidget_1.assets.getAssetByName("new_furni_chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = UnknownVarFromFurniView_FurniChooserWidget_1.windowManager.buildFromXML(_loc1_.content as XML) as IFrameController;
         if(_window == null)
         {
            return;
         }
         _window.caption = UnknownVarFromFurniView_String_1;
         createTable();
         closeButton.addEventListener("WME_CLICK",onClose);
         searchTextInput.addEventListener("WE_CHANGE",onSearchChanged);
         usernameDropDown.addEventListener("WE_SELECTED",onUsernameChanged);
         clearButton.addEventListener("WME_CLICK",onClearClicked);
         if(_window.parent != null)
         {
            _window.x = _window.parent.width - _window.width - 10;
            _window.y = 10;
         }
      }
      
      private function onClearClicked(param1:WindowMouseEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         searchTextInput.text = "";
         onSearchChanged(null);
      }
      
      private function onUsernameChanged(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         populateWithFilters();
      }
      
      private function onSearchChanged(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         var _loc2_:String = searchTextInput.text;
         clearButton.visible = _loc2_.length > 0;
         textPlaceholder.visible = _loc2_.length == 0;
         populateWithFilters();
      }
      
      public function onItemsChanged() : void
      {
         if(UnknownVarFromFurniView_FurniChooserWidget_1 == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         constructOwners();
         populateWithFilters();
      }
      
      private function populateWithFilters() : void
      {
         var _loc1_:Array = searchTextInput.text.toLowerCase().split(" ");
         var _loc6_:int = usernameDropDown.selection;
         var _loc2_:String = _loc6_ > 0 ? usernameDropDown.enumerateSelection()[_loc6_] : null;
         var _loc3_:Array = [];
         loop0:
         for each(var _loc4_ in UnknownVarFromFurniView_FurniChooserWidget_1.items)
         {
            for each(var _loc5_ in _loc1_)
            {
               if(_loc4_.lowerCaseName.indexOf(_loc5_) != -1)
               {
                  continue;
               }
               continue loop0;
            }
            if(!(_loc2_ != null && _loc4_.owner != _loc2_))
            {
               _loc3_.push(_loc4_);
            }
         }
         populate(_loc3_);
         amountIndicator.text = UnknownVarFromFurniView_FurniChooserWidget_1.localizations.getLocalizationWithParams("new_furni_chooser.amount_indicator","","amount",_loc3_.length);
      }
      
      public function constructOwners() : void
      {
         _ignoreListeners = true;
         var _loc1_:Dictionary = new Dictionary();
         var _loc2_:Array = [];
         _loc2_.push(localize("new_furni_chooser.owner_selector.default"));
         for each(var _loc3_ in UnknownVarFromFurniView_FurniChooserWidget_1.items)
         {
            if(!(_loc3_.owner in _loc1_))
            {
               _loc2_.push(_loc3_.owner);
               _loc1_[_loc3_.owner] = true;
            }
         }
         if(usernameDropDown.numMenuItems != _loc2_.length || usernameDropDown.numMenuItems == 1 && usernameDropDown.enumerateSelection()[0] == "")
         {
            usernameDropDown.populate(_loc2_);
            usernameDropDown.selection = 0;
            if(_loc2_.length <= 2)
            {
               usernameDropDown.disable();
               usernameDropDown.blend = 0.5;
            }
            else
            {
               usernameDropDown.enable();
               usernameDropDown.blend = 1;
            }
         }
         _ignoreListeners = false;
      }
      
      private function populate(param1:Array) : void
      {
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc3_ in param1)
         {
            _loc2_.push(new FurniChooserTableObject(_loc3_));
         }
         UnknownVarFromFurniView_TableView_1.setObjects(_loc2_);
      }
      
      private function createTable() : void
      {
         UnknownVarFromFurniView_TableView_1 = new TableView(UnknownVarFromFurniView_FurniChooserWidget_1.windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn(COLUMN_FURNI_NAME,localize("new_furni_chooser.col.name"),0.5,"left"),new TableColumn(COLUMN_FURNI_OWNER,localize("new_furni_chooser.col.owner"),0.25,"left"),new TableColumn(COLUMN_ID,localize("new_furni_chooser.col.id"),0.25,"left")];
         UnknownVarFromFurniView_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,true);
         UnknownVarFromFurniView_TableView_1.onRowClickedCallback = onListItemClicked;
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            UnknownVarFromFurniView_TableView_1.dispose();
            UnknownVarFromFurniView_TableView_1 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function onListItemClicked(param1:FurniChooserTableObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:ChooserItem = param1.chooserItem;
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromFurniView_FurniChooserWidget_1.choose(_loc2_.id,_loc2_.category);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
         UnknownVarFromFurniView_FurniChooserWidget_1.windowManager.LilithCustomsInstance.OnFurniChooserClose();
      }
      
      public function localize(param1:String) : String
      {
         return UnknownVarFromFurniView_FurniChooserWidget_1.localizations.getLocalization(param1,param1);
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByTag("close");
      }
      
      private function get tableViewContainer() : IWindowController_1
      {
         return _window.findChildByName("table_container") as IWindowController_1;
      }
      
      private function get textPlaceholder() : ITextWindow
      {
         return _window.findChildByName("search_placeholder") as ITextWindow;
      }
      
      private function get searchTextInput() : ITextFieldWindow
      {
         return _window.findChildByName("text_input") as ITextFieldWindow;
      }
      
      private function get usernameDropDown() : IDropBaseController_1
      {
         return _window.findChildByName("username_dropdown") as IDropBaseController_1;
      }
      
      private function get clearButton() : IWindowController_1
      {
         return _window.findChildByName("clear_button") as IWindowController_1;
      }
      
      private function get amountIndicator() : ITextWindow
      {
         return _window.findChildByName("amount_indicator") as ITextWindow;
      }
   }
}

