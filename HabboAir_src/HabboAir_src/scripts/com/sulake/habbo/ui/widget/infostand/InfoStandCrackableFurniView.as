package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.object.data.CrackableStuffData;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   
   public class InfoStandCrackableFurniView extends InfoStandFurniView
   {
      public function InfoStandCrackableFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         super.update(param1);
         var _loc2_:CrackableStuffData = param1.stuffData as CrackableStuffData;
         showButton("use",true);
         UnknownVarFromInfoStandFurniView_IItemListWindow_1.visible = true;
         setHitsAndTarget(_loc2_.hits,_loc2_.target);
      }
      
      private function setHitsAndTarget(param1:int, param2:int) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("hits_remaining");
         if(_loc3_ == null)
         {
            return;
         }
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.localizations.registerParameter("infostand.crackable_furni.hits_remaining","hits",String(param1));
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.localizations.registerParameter("infostand.crackable_furni.hits_remaining","target",String(param2));
         _loc3_.visible = true;
         updateWindow();
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc5_:int = 0;
         var _loc4_:XmlAsset = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("crackable_furni_view") as XmlAsset;
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
            _loc5_ = 0;
            while(_loc5_ < UnknownVarFromInfoStandFurniView_IItemListWindow_1.numListItems)
            {
               _loc2_ = UnknownVarFromInfoStandFurniView_IItemListWindow_1.getListItemAt(_loc5_);
               _loc2_.addEventListener("WME_CLICK",onButtonClicked);
               _loc5_++;
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
         var _loc6_:IRegionWindow = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("owner_region") as IRegionWindow;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc6_.addEventListener("WME_OVER",onOwnerRegion);
            _loc6_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
   }
}

