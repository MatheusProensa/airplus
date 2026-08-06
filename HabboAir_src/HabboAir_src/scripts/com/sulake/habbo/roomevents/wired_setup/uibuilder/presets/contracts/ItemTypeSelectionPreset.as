package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.itemtable.ItemTypeTableObject;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   
   public class ItemTypeSelectionPreset extends WiredUIPreset
   {
      public static const COL_FURNI_CODE:String = "furni_code";
      
      public static const COL_FURNI_NAME:String = "furni_name";
      
      public static const COL_FURNI_TYPE:String = "furni_type";
      
      private static const TYPE_POSTER:String = "poster";
      
      private static const POSTER_IDS:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,83,500,501,502,503,504,505,506,507,508,509,510,511,512,513,514,515,516,517,518,520,521,522,523,1000,1001,1002,1003,1004,1005,1006,2000,2001,2002,2003,2004,2005,2006,2007,2008];
      
      private var _window:IItemListWindow;
      
      private var _allFurnis:Vector.<ItemTypeTableObject>;
      
      private var UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1:NamedTextInputPreset;
      
      private var UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2:NamedTextInputPreset;
      
      private var UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromItemTypeSelectionPreset_TableView_1:TableView;
      
      private var UnknownVarFromItemTypeSelectionPreset_TextPreset_1:TextPreset;
      
      private var _selectedItem:ChestItemType;
      
      private var _ignoreListeners:Boolean;
      
      private var UnknownVarFromItemTypeSelectionPreset_Boolean_1:Boolean = false;
      
      private var _listeners:Array = [];
      
      public function ItemTypeSelectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("vertical_list_view") as IItemListWindow;
         _window.spacing = param3.genericVerticalSpacing;
         createAllFurnis();
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1 = param2.createNamedTextInput(new TextInputParam("",-1,"${wiredcontracts.element.itemtype.furni_code.placeholder}",150,null,false),"${wiredcontracts.element.itemtype.furni_code}");
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2 = param2.createNamedTextInput(new TextInputParam("",220,"",150),"${wiredcontracts.element.itemtype.search}");
         UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1 = param2.createLayout("container_view") as IWindowController_1;
         UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1.width = 350;
         UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1.height = 234;
         var _loc4_:TextParam = new TextParam(1);
         UnknownVarFromItemTypeSelectionPreset_TextPreset_1 = param2.createText("-",_loc4_);
         UnknownVarFromItemTypeSelectionPreset_TextPreset_1.halfBlend();
         _window.addListItem(UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.window);
         _window.addListItem(UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2.window);
         _window.addListItem(UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1);
         _window.addListItem(UnknownVarFromItemTypeSelectionPreset_TextPreset_1.window);
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2.addEventListener("WE_CHANGE",onSearchChanged);
         createTableView();
         refreshShowCount();
      }
      
      private function refreshShowCount() : void
      {
         var _loc1_:String = localizations.getLocalizationWithParams("wiredcontracts.element.show_count","","amount",UnknownVarFromItemTypeSelectionPreset_TableView_1.rowCount);
         UnknownVarFromItemTypeSelectionPreset_TextPreset_1.text = _loc1_;
      }
      
      private function createAllFurnis() : void
      {
         var item:IFurnitureData;
         var tableObject:ItemTypeTableObject;
         var fullCode:String;
         var localizedName:String;
         var chestItemType:ChestItemType;
         var posterTypeId:int;
         var localization:IHabboLocalizationManager;
         var posterId:int;
         var key:String;
         _allFurnis = new Vector.<ItemTypeTableObject>();
         var sessionData:ISessionDataManager = _roomEvents.sessionDataManager;
         var allFloorItemData:Array = sessionData.getAllFloorItemDatas();
         var allWallItemData:Array = sessionData.getAllWallItemDatas();
         for each(item in allFloorItemData)
         {
            fullCode = item.fullName;
            if(fullCode != "")
            {
               localizedName = item.localizedName;
               if(localizedName == "")
               {
                  localizedName = fullCode;
               }
               chestItemType = new ChestItemType(false,item.id,null);
               tableObject = new ItemTypeTableObject(chestItemType,localizedName,fullCode);
               _allFurnis.push(tableObject);
            }
         }
         posterTypeId = -1;
         for each(item in allWallItemData)
         {
            if(fullCode != "")
            {
               if(item.className == "poster")
               {
                  posterTypeId = item.id;
               }
               else
               {
                  fullCode = item.fullName;
                  localizedName = item.localizedName;
                  if(localizedName == "")
                  {
                     localizedName = fullCode;
                  }
                  chestItemType = new ChestItemType(true,item.id,null);
                  tableObject = new ItemTypeTableObject(chestItemType,localizedName,fullCode);
                  _allFurnis.push(tableObject);
               }
            }
         }
         localization = _roomEvents.localization;
         if(posterTypeId != -1)
         {
            for each(posterId in POSTER_IDS)
            {
               fullCode = "poster*" + posterId;
               key = "poster_" + posterId + "_name";
               localizedName = localization.getLocalization(key,key);
               chestItemType = new ChestItemType(true,posterTypeId,String(posterId));
               tableObject = new ItemTypeTableObject(chestItemType,localizedName,fullCode);
               _allFurnis.push(tableObject);
            }
         }
         _allFurnis.sort(function(param1:ItemTypeTableObject, param2:ItemTypeTableObject):int
         {
            return param1.localizedName.localeCompare(param2.localizedName);
         });
      }
      
      private function createTableView() : void
      {
         UnknownVarFromItemTypeSelectionPreset_TableView_1 = new TableView(_roomEvents.windowManager,UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1,false,false);
         var _loc1_:Array = [new TableColumn("furni_name","${wiredcontracts.element.itemtype.col.furni_name}",0.5,"left"),new TableColumn("furni_code","${wiredcontracts.element.itemtype.col.furni_code}",0.3,"left"),new TableColumn("furni_type","${wiredcontracts.element.itemtype.col.furni_type}",0.2,"left")];
         UnknownVarFromItemTypeSelectionPreset_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,true);
         UnknownVarFromItemTypeSelectionPreset_TableView_1.onRowClickedCallback = onListItemClicked;
         UnknownVarFromItemTypeSelectionPreset_TableView_1.setObjects(Vector.<ITableObject>(_allFurnis));
         UnknownVarFromItemTypeSelectionPreset_Boolean_1 = true;
      }
      
      private function onListItemClicked(param1:ItemTypeTableObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         selectedItem = param1.chestItemType;
      }
      
      public function get selectedItem() : ChestItemType
      {
         return _selectedItem;
      }
      
      public function get furniDataForSelectedItem() : IFurnitureData
      {
         if(_selectedItem == null)
         {
            return null;
         }
         var _loc1_:ISessionDataManager = _roomEvents.sessionDataManager;
         if(_selectedItem.isWallItem)
         {
            return _loc1_.getWallItemData(_selectedItem.typeId);
         }
         return _loc1_.getFloorItemData(_selectedItem.typeId);
      }
      
      public function resetInteractions() : void
      {
         _ignoreListeners = true;
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2.text = "";
         _ignoreListeners = false;
         updateFilters();
         UnknownVarFromItemTypeSelectionPreset_TableView_1.resetScrollingNextUpdate();
      }
      
      private function onSearchChanged(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         updateFilters();
      }
      
      private function updateFilters() : void
      {
         var _loc2_:* = undefined;
         var _loc4_:Array = null;
         var _loc3_:String = UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2.text.toLowerCase();
         if(_loc3_.length < 2)
         {
            if(UnknownVarFromItemTypeSelectionPreset_Boolean_1)
            {
               return;
            }
            _loc2_ = _allFurnis;
            UnknownVarFromItemTypeSelectionPreset_Boolean_1 = true;
         }
         else
         {
            _loc4_ = _loc3_.split(" ");
            _loc2_ = new Vector.<ItemTypeTableObject>();
            loop0:
            for each(var _loc5_ in _allFurnis)
            {
               for each(var _loc1_ in _loc4_)
               {
                  if(_loc5_.matchesSubstring(_loc3_))
                  {
                     continue;
                  }
                  continue loop0;
               }
               _loc2_.push(_loc5_);
            }
            UnknownVarFromItemTypeSelectionPreset_Boolean_1 = false;
         }
         UnknownVarFromItemTypeSelectionPreset_TableView_1.setObjects(Vector.<ITableObject>(_loc2_));
         refreshShowCount();
      }
      
      public function set selectedItem(param1:ChestItemType) : void
      {
         var _loc3_:IFurnitureData = null;
         _selectedItem = param1;
         notifyListeners(param1);
         if(param1 == null)
         {
            UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.text = "";
            return;
         }
         var _loc2_:ISessionDataManager = _roomEvents.sessionDataManager;
         if(param1.isWallItem)
         {
            _loc3_ = _loc2_.getWallItemData(param1.typeId);
         }
         else
         {
            _loc3_ = _loc2_.getFloorItemData(param1.typeId);
         }
         if(_loc3_ == null)
         {
            _selectedItem = null;
            UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.text = "";
            notifyListeners(null);
            return;
         }
         if(param1.isWallItem && _loc3_.className == "poster")
         {
            UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.text = "poster*" + param1.legacyPosterId;
            return;
         }
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.text = _loc3_.fullName;
      }
      
      public function addListener(param1:Function) : void
      {
         _listeners.push(param1);
      }
      
      private function notifyListeners(param1:ChestItemType) : void
      {
         for each(var _loc2_ in _listeners)
         {
            _loc2_(param1);
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1.resizeToWidth(param1);
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2.resizeToWidth(param1);
         UnknownVarFromItemTypeSelectionPreset_TextPreset_1.resizeToWidth(param1);
         var _loc2_:int = int(UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1.width);
         var _loc3_:* = param1;
         if(_loc2_ != _loc3_)
         {
            UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1.width = _loc3_;
            UnknownVarFromItemTypeSelectionPreset_TableView_1.resizeHorizontally();
         }
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1,UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2,UnknownVarFromItemTypeSelectionPreset_TextPreset_1];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromItemTypeSelectionPreset_TableView_1 != null)
         {
            UnknownVarFromItemTypeSelectionPreset_TableView_1.dispose();
            UnknownVarFromItemTypeSelectionPreset_TableView_1 = null;
         }
         super.dispose();
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _allFurnis = null;
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_1 = null;
         UnknownVarFromItemTypeSelectionPreset_NamedTextInputPreset_2 = null;
         UnknownVarFromItemTypeSelectionPreset_IWindowController_1_1 = null;
         _selectedItem = null;
         UnknownVarFromItemTypeSelectionPreset_TextPreset_1 = null;
         _listeners = null;
      }
   }
}

