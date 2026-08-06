package com.sulake.habbo.ui.widget.chooser.users
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
   
   public class UsersView
   {
      public static var COLUMN_USER_NAME:String = "name";
      
      public static var COLUMN_TYPE:String = "type";
      
      private var UnknownVarFromUsersView_UsersChooserWidget_1:UsersChooserWidget;
      
      private var UnknownVarFromUsersView_String_1:String;
      
      private var UnknownVarFromUsersView_TableView_1:TableView;
      
      private var _window:IFrameController;
      
      private var _ignoreListeners:Boolean;
      
      public function UsersView(param1:UsersChooserWidget, param2:String)
      {
         super();
         UnknownVarFromUsersView_UsersChooserWidget_1 = param1;
         UnknownVarFromUsersView_String_1 = param2;
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
         var _loc1_:XmlAsset = XmlAsset(UnknownVarFromUsersView_UsersChooserWidget_1.assets.getAssetByName("new_user_chooser_view"));
         if(_loc1_ == null)
         {
            return;
         }
         _window = UnknownVarFromUsersView_UsersChooserWidget_1.windowManager.buildFromXML(_loc1_.content as XML) as IFrameController;
         if(_window == null)
         {
            return;
         }
         _window.caption = UnknownVarFromUsersView_String_1;
         createTable();
         closeButton.addEventListener("WME_CLICK",onClose);
         searchTextInput.addEventListener("WE_CHANGE",onSearchChanged);
         typeDropdown.addEventListener("WE_SELECTED",onTypeChanged);
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
      
      private function onTypeChanged(param1:WindowEvent) : void
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
         if(UnknownVarFromUsersView_UsersChooserWidget_1 == null)
         {
            return;
         }
         if(_window == null)
         {
            createWindow();
         }
         populateWithFilters();
      }
      
      private function populateWithFilters() : void
      {
         var _loc3_:String = searchTextInput.text.toLowerCase();
         var _loc2_:int = typeDropdown.selection;
         if(_loc2_ == 3)
         {
            _loc2_ = 4;
         }
         var _loc1_:Array = [];
         for each(var _loc4_ in UnknownVarFromUsersView_UsersChooserWidget_1.items)
         {
            if(!(_loc3_.length > 0 && _loc4_.lowerCaseName.indexOf(_loc3_) == -1))
            {
               if(!(_loc2_ > 0 && _loc4_.type != _loc2_))
               {
                  _loc1_.push(_loc4_);
               }
            }
         }
         populate(_loc1_);
         amountIndicator.text = UnknownVarFromUsersView_UsersChooserWidget_1.localizations.getLocalizationWithParams("new_user_chooser.amount_indicator","","amount",_loc1_.length);
      }
      
      private function populate(param1:Array) : void
      {
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc3_ in param1)
         {
            _loc2_.push(new UsersChooserTableObject(_loc3_));
         }
         UnknownVarFromUsersView_TableView_1.setObjects(_loc2_);
      }
      
      private function createTable() : void
      {
         UnknownVarFromUsersView_TableView_1 = new TableView(UnknownVarFromUsersView_UsersChooserWidget_1.windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn(COLUMN_USER_NAME,localize("new_user_chooser.col.name"),0.65,"left"),new TableColumn(COLUMN_TYPE,localize("new_user_chooser.col.type"),0.35,"left")];
         UnknownVarFromUsersView_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,true);
         UnknownVarFromUsersView_TableView_1.onRowClickedCallback = onListItemClicked;
      }
      
      private function hideWindow() : void
      {
         if(_window != null)
         {
            UnknownVarFromUsersView_TableView_1.dispose();
            UnknownVarFromUsersView_TableView_1 = null;
            _window.dispose();
            _window = null;
         }
      }
      
      private function onListItemClicked(param1:UsersChooserTableObject) : void
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
         UnknownVarFromUsersView_UsersChooserWidget_1.choose(_loc2_.id,_loc2_.category);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
         UnknownVarFromUsersView_UsersChooserWidget_1.windowManager.LilithCustomsInstance.OnUserChooserClose();
      }
      
      public function localize(param1:String) : String
      {
         return UnknownVarFromUsersView_UsersChooserWidget_1.localizations.getLocalization(param1,param1);
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
      
      private function get typeDropdown() : IDropBaseController_1
      {
         return _window.findChildByName("type_dropdown") as IDropBaseController_1;
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

