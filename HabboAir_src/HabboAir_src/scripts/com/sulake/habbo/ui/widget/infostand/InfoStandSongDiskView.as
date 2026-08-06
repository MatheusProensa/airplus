package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandSongDiskView extends InfoStandFurniView
   {
      private var UnknownVarFromInfoStandSongDiskView_Int_1:int = -1;
      
      public function InfoStandSongDiskView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         UnknownVarFromInfoStandSongDiskView_Int_1 = getSongIdFromExtraParam(param1.extraParam);
      }
      
      public function updateSongInfo(param1:RoomWidgetSongUpdateEvent) : void
      {
         if(param1.type == "RWSUE_DATA_RECEIVED" && param1.songId == UnknownVarFromInfoStandSongDiskView_Int_1)
         {
            trackName = param1.songName;
            authorName = param1.songAuthor;
         }
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc7_:int = 0;
         var _loc5_:BitmapData = null;
         var _loc10_:BitmapDataAsset = null;
         var _loc4_:XmlAsset = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("songdisk_view") as XmlAsset;
         _window = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 = _window.getListItemByName("info_border") as UnknownICoreWindowComponents6;
         UnknownVarFromInfoStandFurniView_IItemListWindow_1 = _window.getListItemByName("button_list") as IItemListWindow;
         if(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 != null)
         {
            UnknownVarFromInfoStandFurniView_IItemListWindow_2 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.mainContainer.addChild(_window);
         var _loc3_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(UnknownVarFromInfoStandFurniView_IItemListWindow_1 != null)
         {
            _loc7_ = 0;
            while(_loc7_ < UnknownVarFromInfoStandFurniView_IItemListWindow_1.numListItems)
            {
               _loc2_ = UnknownVarFromInfoStandFurniView_IItemListWindow_1.getListItemAt(_loc7_);
               _loc2_.addEventListener("WME_CLICK",onButtonClicked);
               _loc7_++;
            }
         }
         UnknownVarFromInfoStandFurniView_IWindowModel_2 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByTag("catalog");
         if(UnknownVarFromInfoStandFurniView_IWindowModel_2 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_2.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         UnknownVarFromInfoStandFurniView_IWindowModel_4 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("rent_button");
         if(UnknownVarFromInfoStandFurniView_IWindowModel_4 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_4.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         UnknownVarFromInfoStandFurniView_IWindowModel_5 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("extend_button");
         if(UnknownVarFromInfoStandFurniView_IWindowModel_5 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_5.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         UnknownVarFromInfoStandFurniView_IWindowModel_6 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("buyout_button");
         if(UnknownVarFromInfoStandFurniView_IWindowModel_6 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_6.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:IBitmapWrapperController = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("icon_disc") as IBitmapWrapperController;
         if(_loc6_ != null)
         {
            _loc10_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset;
            _loc5_ = _loc10_.content as BitmapData;
            _loc6_.bitmap = _loc5_.clone();
         }
         var _loc9_:IBitmapWrapperController = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("icon_composer") as IBitmapWrapperController;
         if(_loc9_ != null)
         {
            _loc10_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset;
            _loc5_ = _loc10_.content as BitmapData;
            _loc9_.bitmap = _loc5_.clone();
         }
         var _loc8_:IRegionWindow = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("owner_region") as IRegionWindow;
         if(_loc8_ != null)
         {
            _loc8_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc8_.addEventListener("WME_OVER",onOwnerRegion);
            _loc8_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
      
      private function set trackName(param1:String) : void
      {
         var _loc2_:IWindowController_1 = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("trackname_container") as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         updateWindow();
      }
      
      private function set authorName(param1:String) : void
      {
         var _loc2_:IWindowController_1 = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("creatorname_container") as IWindowController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_creator_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
         updateWindow();
      }
      
      private function getSongIdFromExtraParam(param1:String) : int
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            _loc2_ = param1.substr("RWEIEP_SONGDISK".length,param1.length);
            return parseInt(_loc2_);
         }
         return -1;
      }
   }
}

