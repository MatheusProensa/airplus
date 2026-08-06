package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_2;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.guilds.GuildMembershipsController;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetGuildSelectedEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetToggleEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupEntryData;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class GuildSelectorCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const CATALOG_PAGE_LAYOUT_WIDGET_NAME:String = "guild_selector";
      
      private static const UnknownConstFromGuildSelectorCatalogWidget_String_1:String = "guild_selector_widget_item";
      
      private static const GUILD_COLORS_BMP_BORDER_COLOR:uint = 0;
      
      private static const GUILD_COLORS_BMP_BORDER_WIDTH:int = 1;
      
      private static const GUILD_COLORS_BMP_HEIGHT:int = 14;
      
      private static const GUILD_COLORS_BMP_WIDTH:int = 21;
      
      private var UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1:IDropBaseController_2;
      
      protected var UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1:GuildMembershipsController;
      
      private var UnknownVarFromGuildSelectorCatalogWidget_Array_1:Array;
      
      private var UnknownVarFromGuildSelectorCatalogWidget_IWindowModel_1:IWindowModel;
      
      private var _membersOnlyInfo:IWindowModel;
      
      private var UnknownVarFromGuildSelectorCatalogWidget_Int_1:int = -1;
      
      public function GuildSelectorCatalogWidget(param1:IWindowController_1, param2:GuildMembershipsController)
      {
         super(param1);
         UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1 = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
            page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(-1,"","",""));
            if(UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1)
            {
               UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.procedure = null;
               UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1 = null;
            }
            UnknownVarFromGuildSelectorCatalogWidget_IWindowModel_1 = null;
            _membersOnlyInfo = null;
            if(UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1)
            {
               UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1.unregisterGuildSelectorWidget(this);
               UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1 = null;
            }
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         attachWidgetView("guildSelectorWidget");
         UnknownVarFromGuildSelectorCatalogWidget_IWindowModel_1 = window.findChildByName("guild_selector");
         _membersOnlyInfo = window.findChildByName("members_only");
         var _loc1_:IWindowModel = window.findChildByName("find_groups_button");
         if(_loc1_)
         {
            _loc1_.addEventListener("WME_CLICK",onFindGroups);
         }
         UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1 = _window.findChildByName("guild_selector") as IDropBaseController_2;
         if(UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1)
         {
            UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.procedure = dropMenuEventProc;
         }
         else
         {
            Logger.log("ERROR: Missing \'guild_selector\' itemlist_dropmenu component from page layout xml");
         }
         UnknownVarFromGuildSelectorCatalogWidget_IWindowModel_1.visible = false;
         _membersOnlyInfo.visible = false;
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         UnknownVarFromGuildSelectorCatalogWidget_GuildMembershipsController_1.registerGuildSelectorWidget(this);
         events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
      }
      
      public function populateAndSelectFavorite(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:HabboGroupEntryData = null;
         var _loc2_:* = -1;
         UnknownVarFromGuildSelectorCatalogWidget_Array_1 = filterGroupMemberships(param1);
         var _loc3_:* = param1.length > 0;
         events.dispatchEvent(new CatalogWidgetToggleEvent("purchaseWidget",_loc3_));
         UnknownVarFromGuildSelectorCatalogWidget_IWindowModel_1.visible = _loc3_;
         _membersOnlyInfo.visible = !_loc3_;
         var _loc6_:int = UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.numMenuItems;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.removeMenuItemAt(0);
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromGuildSelectorCatalogWidget_Array_1.length)
         {
            _loc7_ = UnknownVarFromGuildSelectorCatalogWidget_Array_1[_loc5_];
            UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.addMenuItem(createDropmenuItemWindow(_loc7_));
            if(_loc7_.favourite)
            {
               _loc2_ = _loc5_;
            }
            _loc5_++;
         }
         if(UnknownVarFromGuildSelectorCatalogWidget_Int_1 == -1)
         {
            if(_loc2_ != -1)
            {
               UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.selection = _loc2_;
            }
            else if(UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.numMenuItems > 0)
            {
               UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.selection = 0;
            }
         }
         else
         {
            UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.selection = UnknownVarFromGuildSelectorCatalogWidget_Int_1;
         }
      }
      
      protected function filterGroupMemberships(param1:Array) : Array
      {
         return param1;
      }
      
      public function selectFirstOffer() : void
      {
         if(page && page.offers && page.offers.length > 0)
         {
            page.selectOffer(Offer(page.offers[0]).offerId);
         }
      }
      
      private function dropMenuEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:* = param1.type;
         if("WE_SELECTED" === _loc3_)
         {
            selectFromDropList(UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.selection);
            UnknownVarFromGuildSelectorCatalogWidget_Int_1 = UnknownVarFromGuildSelectorCatalogWidget_IDropBaseController_2_1.selection;
         }
      }
      
      private function selectFromDropList(param1:int) : void
      {
         var _loc2_:HabboGroupEntryData = null;
         if(param1 > -1)
         {
            _loc2_ = UnknownVarFromGuildSelectorCatalogWidget_Array_1[param1];
            selectGroup(_loc2_);
         }
      }
      
      protected function selectGroup(param1:HabboGroupEntryData) : void
      {
         page.dispatchWidgetEvent(new CatalogWidgetGuildSelectedEvent(param1.groupId,param1.primaryColor,param1.secondaryColor,param1.badgeCode));
         page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData(param1.groupId,param1.primaryColor,param1.secondaryColor,param1.badgeCode)));
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(param1.groupId.toString()));
      }
      
      private function createGuildColorsBitmap(param1:uint, param2:uint) : BitmapData
      {
         var _loc3_:BitmapData = new BitmapData(21,14,false,0);
         var _loc5_:int = _loc3_.width / 2 + 1;
         var _loc6_:Rectangle = new Rectangle();
         _loc6_.left = 1;
         _loc6_.top = 1;
         _loc6_.right = _loc5_;
         _loc6_.bottom = _loc3_.height - 1;
         var _loc4_:Rectangle = new Rectangle();
         _loc4_.left = _loc5_;
         _loc4_.top = 1;
         _loc4_.right = _loc3_.width - 1;
         _loc4_.bottom = _loc3_.height - 1;
         _loc3_.fillRect(_loc6_,param1);
         _loc3_.fillRect(_loc4_,param2);
         return _loc3_;
      }
      
      private function createDropmenuItemWindow(param1:HabboGroupEntryData) : IWindowModel
      {
         var _loc4_:BitmapData = createGuildColorsBitmap(parseInt(param1.primaryColor,16),parseInt(param1.secondaryColor,16));
         var _loc2_:XML = page.viewer.catalog.assets.getAssetByName("guild_selector_widget_item").content as XML;
         var _loc6_:IWindowController_1 = page.viewer.catalog.windowManager.buildFromXML(_loc2_) as IWindowController_1;
         var _loc3_:IBitmapWrapperController = _loc6_.findChildByName("guild_colors") as IBitmapWrapperController;
         var _loc5_:ILabelWindow = _loc6_.findChildByName("guild_name") as ILabelWindow;
         _loc3_.bitmap = _loc4_;
         _loc5_.caption = param1.groupName;
         return _loc6_;
      }
      
      private function onFindGroups(param1:WindowMouseEvent) : void
      {
         if(page && page.viewer && page.viewer.catalog && page.viewer.catalog.navigator)
         {
            page.viewer.catalog.navigator.performGuildBaseSearch();
         }
      }
      
      private function getPreviewerStuffData(param1:uint, param2:String, param3:String, param4:String) : IStuffData
      {
         var _loc5_:Array = [];
         _loc5_.push("0");
         _loc5_.push(param1.toString());
         _loc5_.push(param4);
         _loc5_.push(param2);
         _loc5_.push(param3);
         var _loc6_:StringArrayStuffData = new StringArrayStuffData();
         _loc6_.setArray(_loc5_);
         return _loc6_;
      }
   }
}

