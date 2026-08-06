package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetBadgeDetailsMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.FurniId;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class InfoStandFurniView
   {
      private static const UnknownConstFromInfoStandFurniView_Int_1:int = -12345678;
      
      private static const UnknownConstFromInfoStandFurniView_Int_2:int = -12345679;
      
      protected var _window:IItemListWindow;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowController_1_1:IWindowController_1;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_1:IWindowModel;
      
      protected var UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      protected var UnknownVarFromInfoStandFurniView_IItemListWindow_1:IItemListWindow;
      
      protected var _catalog:IHabboCatalog;
      
      protected var _habboTracking:IHabboTracking;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_2:IWindowModel;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_3:IWindowModel;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_4:IWindowModel;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_5:IWindowModel;
      
      protected var UnknownVarFromInfoStandFurniView_IWindowModel_6:IWindowModel;
      
      private var _pickupMode:int;
      
      private var UnknownVarFromInfoStandFurniView_Int_1:int = 0;
      
      protected var UnknownVarFromInfoStandFurniView_InfoStandWidget_1:InfoStandWidget;
      
      protected var UnknownVarFromInfoStandFurniView_IItemListWindow_2:IItemListWindow;
      
      private const UnknownConstFromInfoStandFurniView_Int_3:int = 0;
      
      private const UnknownConstFromInfoStandFurniView_Int_4:int = 1;
      
      private const UnknownConstFromInfoStandFurniView_Int_5:int = 2;
      
      public function InfoStandFurniView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         _pickupMode = UnknownConstFromInfoStandFurniView_Int_3;
         super();
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1 = param1;
         _catalog = param3;
         _habboTracking = HabboTracking.getInstance();
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         _catalog = null;
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1 = null;
         _window.dispose();
         _window = null;
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      protected function createWindow(param1:String) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc5_:int = 0;
         var _loc4_:XmlAsset = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("furni_view") as XmlAsset;
         _window = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 = _window.getListItemByName("info_border") as UnknownICoreWindowComponents6;
         UnknownVarFromInfoStandFurniView_IItemListWindow_1 = _window.getListItemByName("button_list") as IItemListWindow;
         UnknownVarFromInfoStandFurniView_IWindowController_1_1 = _window.getListItemByName("custom_variables") as IWindowController_1;
         if(!UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.sessionDataManager.hasSecurity(5))
         {
            UnknownVarFromInfoStandFurniView_IWindowController_1_1.dispose();
            UnknownVarFromInfoStandFurniView_IWindowController_1_1 = null;
         }
         if(UnknownVarFromInfoStandFurniView_IWindowController_1_1 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowController_1_1.procedure = customVarsWindowProcedure;
            UnknownVarFromInfoStandFurniView_IWindowModel_1 = IItemListWindow(UnknownVarFromInfoStandFurniView_IWindowController_1_1.findChildByName("variable_list")).removeListItemAt(0);
         }
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
         UnknownVarFromInfoStandFurniView_IWindowModel_3 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("bc_place_button");
         if(UnknownVarFromInfoStandFurniView_IWindowModel_3 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_3.addEventListener("WME_CLICK",onBcPlaceMoreButtonClicked);
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
         var _loc7_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("group_details_container");
         if(_loc7_)
         {
            _loc7_.addEventListener("WME_CLICK",onGroupInfoClicked);
         }
      }
      
      private function customVarsWindowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:Map = null;
         var _loc3_:IItemListWindow = null;
         var _loc4_:int = 0;
         var _loc6_:IWindowController_1 = null;
         if(param1.type != "WME_CLICK" || UnknownVarFromInfoStandFurniView_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc7_:* = param2.name;
         if("set_values" === _loc7_)
         {
            _loc5_ = new Map();
            _loc3_ = UnknownVarFromInfoStandFurniView_IWindowController_1_1.findChildByName("variable_list") as IItemListWindow;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.numListItems)
            {
               _loc6_ = _loc3_.getListItemAt(_loc4_) as IWindowController_1;
               _loc5_[_loc6_.name] = _loc6_.findChildByName("value").caption;
               _loc4_++;
            }
            UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.setObjectData(_loc5_);
         }
      }
      
      protected function onBuyoutButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IFurnitureData = null;
         if(_catalog != null && UnknownVarFromInfoStandFurniView_InfoStandWidget_1 && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData)
         {
            _loc2_ = getFurnitureData(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,true,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.id);
            }
         }
      }
      
      protected function onExtendButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:IFurnitureData = null;
         if(_catalog != null && UnknownVarFromInfoStandFurniView_InfoStandWidget_1 && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData)
         {
            _loc2_ = getFurnitureData(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData);
            if(_loc2_)
            {
               _catalog.openRentConfirmationWindow(_loc2_,false,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.id);
            }
         }
      }
      
      private function getRoomObject(param1:int) : IRoomObject
      {
         var _loc3_:int = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.roomSession.roomId;
         var _loc2_:IRoomObject = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.roomEngine.getRoomObject(_loc3_,param1,10);
         if(_loc2_ == null)
         {
            _loc2_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.roomEngine.getRoomObject(_loc3_,param1,20);
         }
         return _loc2_;
      }
      
      private function getFurnitureData(param1:InfoStandFurniData) : IFurnitureData
      {
         var _loc4_:IFurnitureData = null;
         var _loc2_:IRoomObject = getRoomObject(param1.id);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:* = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.category == 20;
         var _loc5_:int = _loc2_.getModel().getNumber("furniture_type_id");
         if(_loc3_)
         {
            _loc4_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.sessionDataManager.getWallItemData(_loc5_);
         }
         else
         {
            _loc4_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.sessionDataManager.getFloorItemData(_loc5_);
         }
         return _loc4_;
      }
      
      protected function onRentButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.rentOfferId,"NORMAL");
         }
      }
      
      protected function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.close();
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:ITextWindow = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("name_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.visible = true;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function set isNft(param1:Boolean) : void
      {
         var _loc2_:IBitmapWrapperController = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc3_:BitmapData = null;
         var _loc5_:IWindowController_1 = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("nft_indicator") as IWindowController_1;
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.height = param1 ? 22 : 0;
         _loc5_.visible = param1;
         if(param1)
         {
            _loc2_ = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("nft_icon") as IBitmapWrapperController;
            if(_loc2_ != null)
            {
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc4_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("icon_nft") as BitmapDataAsset;
               _loc3_ = _loc4_.content as BitmapData;
               _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
               _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            }
         }
         updateWindow();
      }
      
      public function set furniImage(param1:BitmapData) : void
      {
         setImage(param1,"image");
      }
      
      private function setImage(param1:BitmapData, param2:String) : void
      {
         var _loc3_:IBitmapWrapperController = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName(param2) as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            param1 = new BitmapData(_loc3_.width,40,true);
         }
         _loc3_.height = Math.min(param1.height,200);
         _loc3_.bitmap = param1.clone();
         _loc3_.visible = true;
         updateWindow();
      }
      
      public function set description(param1:String) : void
      {
         var _loc2_:ITextWindow = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("description_text") as ITextWindow;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.text = param1;
         _loc2_.height = _loc2_.textHeight + 5;
         updateWindow();
      }
      
      public function setOwnerInfo(param1:int, param2:String) : void
      {
         var _loc5_:IRegionWindow = null;
         var _loc6_:ITextWindow = null;
         var _loc3_:IWindowModel = null;
         var _loc7_:IWindowModel = null;
         var _loc4_:IWindowModel = null;
         UnknownVarFromInfoStandFurniView_Int_1 = param1;
         if(UnknownVarFromInfoStandFurniView_Int_1 == 0)
         {
            showWindow("owner_region",false);
            showWindow("owner_spacer",false);
         }
         else
         {
            _loc5_ = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("owner_region") as IRegionWindow;
            _loc6_ = _loc5_.findChildByName("owner_name") as ITextWindow;
            _loc3_ = _loc5_.findChildByName("owner_link");
            _loc7_ = _loc5_.findChildByName("bcw_icon");
            _loc4_ = _loc5_.findChildByName("temp_icon");
            if(UnknownVarFromInfoStandFurniView_Int_1 == -12345678)
            {
               _loc6_.text = "${builder.catalog.title}";
               _loc5_.toolTipCaption = "";
               _loc3_.visible = false;
               if(_loc7_ != null)
               {
                  _loc7_.visible = true;
               }
               if(_loc4_ != null)
               {
                  _loc4_.visible = false;
               }
            }
            else if(UnknownVarFromInfoStandFurniView_Int_1 == -12345679)
            {
               _loc6_.text = "${temp.catalog.title}";
               _loc5_.toolTipCaption = "";
               _loc3_.visible = false;
               if(_loc4_ != null)
               {
                  _loc4_.visible = true;
               }
               if(_loc7_ != null)
               {
                  _loc7_.visible = false;
               }
            }
            else
            {
               _loc6_.text = param2;
               _loc5_.toolTipCaption = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.localizations.getLocalization("infostand.profile.link.tooltip","");
               _loc5_.toolTipDelay = 100;
               _loc3_.visible = true;
               if(_loc7_ != null)
               {
                  _loc7_.visible = false;
               }
               if(_loc4_ != null)
               {
                  _loc4_.visible = false;
               }
            }
            showWindow("owner_region",true);
            showWindow("owner_spacer",true);
         }
         updateWindow();
      }
      
      private function set expiration(param1:int) : void
      {
         var _loc2_:IWindowModel = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("expiration_text");
         if(_loc2_ == null)
         {
            return;
         }
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.localizations.registerParameter("infostand.rent.expiration","time",FriendlyTime.getFriendlyTime(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.localization,param1));
         _loc2_.visible = param1 >= 0 && UnknownVarFromInfoStandFurniView_Int_1 == UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.sessionDataManager.userId;
         updateWindow();
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc4_:RoomWidgetMessage = null;
         var _loc5_:String = null;
         var _loc3_:String = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         switch(_loc2_.name)
         {
            case "rotate":
               _loc5_ = "RWFUAM_ROTATE";
               break;
            case "move":
               _loc5_ = "RWFAM_MOVE";
               break;
            case "pickup":
               if(_pickupMode == 2)
               {
                  _loc5_ = "RWFAM_PICKUP";
               }
               else
               {
                  _loc5_ = "RWFAM_EJECT";
               }
               UnknownVarFromInfoStandFurniView_InfoStandWidget_1.close();
               break;
            case "save_branding_configuration":
               if(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.sessionDataManager.hasSecurity(4))
               {
                  _loc5_ = "RWFAM_SAVE_STUFF_DATA";
                  _loc3_ = getVisibleAdFurnitureExtraParams();
                  break;
               }
            case "use":
               _loc5_ = "RWFAM_USE";
               break;
            case "wired_inspect":
               _loc5_ = "RWFAM_WIRED_INSPECT";
         }
         if(_loc5_ != null)
         {
            _loc4_ = new RoomWidgetFurniActionMessage(_loc5_,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.id,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.category,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.purchaseOfferId,_loc3_);
            UnknownVarFromInfoStandFurniView_InfoStandWidget_1.messageListener.processWidgetMessage(_loc4_);
         }
      }
      
      private function onGroupInfoClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.messageListener.processWidgetMessage(new RoomWidgetGetBadgeDetailsMessage(false,UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.groupId));
      }
      
      protected function onCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         if(_catalog != null)
         {
            _catalog.openCatalogPageByOfferId(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.purchaseOfferId,"NORMAL");
            if(_habboTracking && !_habboTracking.disposed)
            {
               _habboTracking.trackGoogle("infostandCatalogButton","offer",UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.purchaseOfferId);
            }
         }
      }
      
      protected function onBcPlaceMoreButtonClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.requestItemToMover();
      }
      
      protected function onOwnerRegion(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(UnknownVarFromInfoStandFurniView_Int_1 == -12345678)
            {
               if(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.availableForBuildersClub && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.purchaseOfferId >= 0)
               {
                  _catalog.openCatalogPageByOfferId(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.purchaseOfferId,"BUILDERS_CLUB");
               }
               else
               {
                  UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.catalog.toggleBuilderCatalog();
               }
            }
            else if(UnknownVarFromInfoStandFurniView_Int_1 != -12345679)
            {
               UnknownVarFromInfoStandFurniView_InfoStandWidget_1.messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",UnknownVarFromInfoStandFurniView_Int_1,"infoStand_furniView"));
            }
         }
         if(param1.type == "WME_OUT")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 21;
         }
         if(param1.type == "WME_OVER")
         {
            IIconWindow(IRegionWindow(param1.target).findChildByName("owner_link")).style = 22;
         }
      }
      
      protected function updateWindow() : void
      {
         if(UnknownVarFromInfoStandFurniView_IItemListWindow_2 == null || UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 == null || UnknownVarFromInfoStandFurniView_IItemListWindow_1 == null)
         {
            return;
         }
         UnknownVarFromInfoStandFurniView_IItemListWindow_2.arrangeListItems();
         UnknownVarFromInfoStandFurniView_IItemListWindow_1.width = UnknownVarFromInfoStandFurniView_IItemListWindow_1.scrollableRegion.width;
         UnknownVarFromInfoStandFurniView_IItemListWindow_2.height = UnknownVarFromInfoStandFurniView_IItemListWindow_2.scrollableRegion.height;
         UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.height = UnknownVarFromInfoStandFurniView_IItemListWindow_2.height + 20;
         _window.width = Math.max(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.width,UnknownVarFromInfoStandFurniView_IItemListWindow_1.width);
         _window.height = _window.scrollableRegion.height;
         if(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.width < UnknownVarFromInfoStandFurniView_IItemListWindow_1.width)
         {
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.x = _window.width - UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.width;
            UnknownVarFromInfoStandFurniView_IItemListWindow_1.x = 0;
         }
         else
         {
            UnknownVarFromInfoStandFurniView_IItemListWindow_1.x = _window.width - UnknownVarFromInfoStandFurniView_IItemListWindow_1.width;
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.x = 0;
         }
         if(UnknownVarFromInfoStandFurniView_IWindowController_1_1 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowController_1_1.x = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.x;
         }
         UnknownVarFromInfoStandFurniView_InfoStandWidget_1.refreshContainer();
      }
      
      private function set spacerColor(param1:uint) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("images_spacer");
         var _loc2_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("owner_spacer");
         var _loc5_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("group_details_spacer");
         var _loc4_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("furni_details_spacer");
         if(_loc3_ != null)
         {
            _loc3_.color = param1;
         }
         if(_loc2_ != null)
         {
            _loc2_.color = param1;
         }
         if(_loc5_ != null)
         {
            _loc5_.color = param1;
         }
         if(_loc4_ != null)
         {
            _loc4_.color = param1;
         }
      }
      
      public function update(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         if(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 != null)
         {
            if(FurniId.isBuilderClubId(param1.id))
            {
               UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.color = 3349504;
               spacerColor = 4283710744;
            }
            else if(FurniId.isTempId(param1.id))
            {
               UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.color = 1321796;
               spacerColor = 4281289835;
            }
            else
            {
               UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.color = 4013373;
               spacerColor = 4281545523;
            }
         }
         var _loc10_:IRoomSession = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.roomSession;
         var _loc4_:Boolean = _loc10_ != null && _loc10_.playTestMode;
         var _loc8_:Boolean = _loc10_ != null && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.roomEngine.activeRoomHasFreeFurniMovementsMode;
         name = param1.name;
         description = param1.description;
         furniImage = param1.image;
         expiration = param1.expiration;
         isNft = param1.isNft;
         if(FurniId.isBuilderClubId(param1.id))
         {
            setOwnerInfo(-12345678,param1.ownerName);
         }
         else if(FurniId.isTempId(param1.id))
         {
            setOwnerInfo(-12345679,param1.ownerName);
         }
         else
         {
            setOwnerInfo(param1.ownerId,param1.ownerName);
         }
         var _loc3_:Boolean = false;
         var _loc7_:* = false;
         var _loc9_:Boolean = false;
         var _loc2_:Boolean = false;
         if(_loc8_ || !_loc4_ && (param1.roomControllerLevel >= 1 || param1.isOwner || param1.isRoomOwner || param1.isAnyRoomController))
         {
            _loc3_ = true;
            _loc7_ = !param1.isWallItem;
         }
         if(param1.isAnyRoomController)
         {
            _loc9_ = true;
         }
         var _loc11_:* = param1.roomControllerLevel >= 1;
         var _loc5_:Boolean = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.config.getBoolean("infostand.use.button.enabled");
         if(_loc5_)
         {
            if(param1.usagePolicy == 2)
            {
               _loc2_ = true;
            }
            if(!_loc4_ && (param1.usagePolicy == 1 && _loc11_ || param1.extraParam == "RWEIEP_JUKEBOX" && _loc11_ || param1.extraParam == "RWEIEP_USABLE_PRODUCT" && _loc11_))
            {
               _loc2_ = true;
            }
            if(_loc8_)
            {
               _loc2_ = true;
            }
         }
         updatePickupMode(param1,_loc4_);
         showButton("move",_loc3_);
         showButton("rotate",_loc7_);
         showButton("use",_loc2_);
         showButton("wired_inspect",!_loc4_ && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.handler.container.userDefinedRoomEvents.showInspectButton());
         showAdFurnitureDetails(_catalog.windowManager.LilithCustomsInstance.ShowObjectsIds);
         showGroupInfo(param1.groupId > 0);
         updatePurchaseButtonVisibility(param1.isOwner,param1.expiration >= 0,param1.purchaseOfferId >= 0,param1.rentOfferId >= 0,param1.purchaseCouldBeUsedForBuyout,param1.rentCouldBeUsedForBuyout,param1.bcOfferId >= 0 && param1.availableForBuildersClub && _catalog.canPlaceWithBC());
         showLimitedItem(param1.stuffData.uniqueSerialNumber > 0,param1.stuffData);
         showRarityItem(param1.stuffData.rarityLevel >= 0,param1.stuffData);
         var _loc6_:IFurnitureData = getFurnitureData(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData);
         showChestData(_loc6_ != null && _loc6_.category == 24,_loc6_ != null && _loc6_.category == 25,param1.stuffData);
         UnknownVarFromInfoStandFurniView_IItemListWindow_1.visible = _loc3_ || _loc7_ || _pickupMode != 0 || _loc2_;
         updateCustomVarsWindow();
         updateWindow();
      }
      
      private function updateCustomVarsWindow() : void
      {
         var _loc1_:IWindowController_1 = null;
         if(UnknownVarFromInfoStandFurniView_IWindowController_1_1 == null || UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData == null)
         {
            return;
         }
         var _loc6_:IRoomObject = getRoomObject(UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.id);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc3_:Array = _loc6_.getModel().getStringArray("furniture_custom_variables");
         UnknownVarFromInfoStandFurniView_IWindowController_1_1.visible = _loc3_ != null && _loc3_.length > 0;
         if(!UnknownVarFromInfoStandFurniView_IWindowController_1_1.visible)
         {
            return;
         }
         var _loc5_:IItemListWindow = UnknownVarFromInfoStandFurniView_IWindowController_1_1.findChildByName("variable_list") as IItemListWindow;
         _loc5_.destroyListItems();
         var _loc4_:Map = _loc6_.getModel().getStringToStringMap("furniture_data");
         for each(var _loc2_ in _loc3_)
         {
            _loc1_ = UnknownVarFromInfoStandFurniView_IWindowModel_1.clone() as IWindowController_1;
            _loc1_.name = _loc2_;
            _loc1_.findChildByName("name").caption = _loc2_;
            _loc1_.findChildByName("value").caption = _loc4_[_loc2_];
            _loc5_.addListItem(_loc1_);
         }
      }
      
      private function updatePickupMode(param1:RoomWidgetFurniInfoUpdateEvent, param2:Boolean) : void
      {
         _pickupMode = 0;
         if(!param2)
         {
            if(param1.isOwner || param1.isAnyRoomController)
            {
               _pickupMode = 2;
            }
            else if(param1.isRoomOwner || param1.roomControllerLevel >= 3)
            {
               _pickupMode = 1;
            }
            if(param1.isStickie)
            {
               _pickupMode = 0;
            }
         }
         showButton("pickup",_pickupMode != 0);
         localizePickupButton(_pickupMode);
      }
      
      private function localizePickupButton(param1:int) : void
      {
         if(UnknownVarFromInfoStandFurniView_IItemListWindow_1 == null)
         {
            return;
         }
         var _loc2_:IWindowModel = UnknownVarFromInfoStandFurniView_IItemListWindow_1.getListItemByName("pickup");
         if(_loc2_ != null)
         {
            if(param1 == 1)
            {
               _loc2_.caption = "${infostand.button.eject}";
            }
            else
            {
               _loc2_.caption = "${infostand.button.pickup}";
            }
         }
      }
      
      private function createAdElement(param1:String, param2:String) : void
      {
         var _loc4_:XmlAsset = null;
         var _loc5_:IWindowController_1 = null;
         var _loc6_:IWindowModel = null;
         var _loc3_:IWindowModel = null;
         if(UnknownVarFromInfoStandFurniView_IItemListWindow_2 != null)
         {
            _loc4_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.assets.getAssetByName("furni_view_branding_element") as XmlAsset;
            if(_loc4_ != null)
            {
               _loc5_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.windowManager.buildFromXML(_loc4_.content as XML) as IWindowController_1;
               if(_loc5_ != null)
               {
                  _loc6_ = _loc5_.findChildByName("element_name");
                  if(_loc6_ != null)
                  {
                     _loc6_.caption = param1;
                  }
                  _loc3_ = _loc5_.findChildByName("element_value");
                  if(_loc3_ != null)
                  {
                     _loc3_.caption = param2;
                     _loc3_.addEventListener("WKE_KEY_DOWN",adElementKeyEventProc);
                  }
                  if(_loc6_ != null && _loc3_ != null)
                  {
                     UnknownVarFromInfoStandFurniView_IItemListWindow_2.addListItem(_loc5_);
                  }
               }
            }
         }
      }
      
      private function getAdFurnitureExtraParams() : Map
      {
         var _loc5_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc1_:Map = new Map();
         if(UnknownVarFromInfoStandFurniView_InfoStandWidget_1 != null)
         {
            _loc5_ = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.extraParam.substr("RWEIEP_BRANDING_OPTIONS".length);
            _loc3_ = _loc5_.split("\t");
            if(_loc3_ != null)
            {
               for each(var _loc2_ in _loc3_)
               {
                  _loc4_ = _loc2_.split("=",2);
                  if(_loc4_ != null && _loc4_.length == 2)
                  {
                     _loc7_ = _loc4_[0];
                     _loc6_ = _loc4_[1];
                     _loc1_.add(_loc7_,_loc6_);
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function getVisibleAdFurnitureExtraParams() : String
      {
         var _loc2_:Array = null;
         var _loc7_:IWindowModel = null;
         var _loc3_:IWindowModel = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         var _loc1_:String = "";
         if(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 != null)
         {
            _loc2_ = [];
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.groupChildrenWithTag("branding_element",_loc2_,-1);
            if(_loc2_.length > 0)
            {
               for each(var _loc6_ in _loc2_)
               {
                  _loc7_ = _loc6_.findChildByName("element_name");
                  _loc3_ = _loc6_.findChildByName("element_value");
                  if(_loc7_ != null && _loc3_ != null)
                  {
                     _loc5_ = trimAdFurnitureExtramParam(_loc7_.caption);
                     _loc4_ = trimAdFurnitureExtramParam(_loc3_.caption);
                     _loc1_ += _loc5_ + "=" + _loc4_ + "\t";
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function trimAdFurnitureExtramParam(param1:String) : String
      {
         if(param1 != null)
         {
            if(param1.indexOf("\t") != -1)
            {
               return param1.replace("\t","");
            }
         }
         return param1;
      }
      
      private function showAdFurnitureDetails(param1:Boolean) : void
      {
         var _loc5_:String = null;
         var _loc8_:Map = null;
         var _loc9_:String = null;
         if(UnknownVarFromInfoStandFurniView_InfoStandWidget_1 == null || UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1 == null)
         {
            return;
         }
         var _loc4_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("furni_details_spacer");
         if(_loc4_ != null)
         {
            _loc4_.visible = param1;
         }
         var _loc2_:Array = [];
         UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.groupChildrenWithTag("branding_element",_loc2_,-1);
         if(_loc2_.length > 0)
         {
            for each(var _loc6_ in _loc2_)
            {
               UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.removeChild(_loc6_);
               _loc6_.dispose();
            }
         }
         var _loc3_:Boolean = false;
         var _loc7_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("furni_details_text") as ITextWindow;
         if(_loc7_ != null)
         {
            _loc7_.visible = param1;
            _loc5_ = "ID: " + UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.id;
            _loc8_ = getAdFurnitureExtraParams();
            if(_loc8_.length > 0)
            {
               _loc3_ = true;
               for each(var _loc10_ in _loc8_.getKeys())
               {
                  _loc9_ = _loc8_.getValue(_loc10_);
                  createAdElement(_loc10_,_loc9_);
               }
            }
            _loc7_.caption = _loc5_;
         }
         showButton("save_branding_configuration",_loc3_);
      }
      
      private function showGroupInfo(param1:Boolean) : void
      {
         showWindow("group_details_spacer",param1);
         showWindow("group_details_container",param1);
         showWindow("group_badge_image",false);
         showWindow("group_name",false);
      }
      
      private function showWindow(param1:String, param2:Boolean) : void
      {
         var _loc3_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName(param1);
         if(_loc3_)
         {
            _loc3_.visible = param2;
         }
      }
      
      private function adElementKeyEventProc(param1:WindowEvent = null, param2:IWindowModel = null) : void
      {
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(UnknownVarFromInfoStandFurniView_IItemListWindow_1 == null)
         {
            return;
         }
         var _loc3_:IWindowModel = UnknownVarFromInfoStandFurniView_IItemListWindow_1.getListItemByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            UnknownVarFromInfoStandFurniView_IItemListWindow_1.arrangeListItems();
         }
      }
      
      private function updatePurchaseButtonVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean) : void
      {
         var _loc12_:* = false;
         var _loc10_:Boolean = param1 && param2;
         var _loc9_:Boolean = _loc10_ && param6;
         var _loc11_:Boolean = _loc10_ && param5;
         var _loc13_:Boolean = !_loc10_ && param3;
         var _loc15_:Boolean = param7 && UnknownVarFromInfoStandFurniView_InfoStandWidget_1.config.getBoolean("infostand.place_more.enabled");
         var _loc14_:Boolean = !_loc10_ && param4;
         if(UnknownVarFromInfoStandFurniView_IWindowModel_3 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_3.visible = _loc15_;
            if(!_loc12_)
            {
               _loc12_ = _loc15_;
            }
         }
         if(UnknownVarFromInfoStandFurniView_IWindowModel_2 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_2.visible = _loc13_;
            if(!_loc12_)
            {
               _loc12_ = _loc13_;
            }
         }
         if(UnknownVarFromInfoStandFurniView_IWindowModel_4 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_4.visible = _loc14_;
            if(!_loc12_)
            {
               _loc12_ = _loc14_;
            }
         }
         if(UnknownVarFromInfoStandFurniView_IWindowModel_5 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_5.visible = _loc9_;
            if(!_loc12_)
            {
               _loc12_ = _loc9_;
            }
         }
         if(UnknownVarFromInfoStandFurniView_IWindowModel_6 != null)
         {
            UnknownVarFromInfoStandFurniView_IWindowModel_6.visible = _loc11_;
            if(!_loc12_)
            {
               _loc12_ = _loc11_;
            }
         }
         var _loc8_:IItemListWindow = UnknownVarFromInfoStandFurniView_IItemListWindow_2.getListItemByName("purchase_buttons") as IItemListWindow;
         if(_loc8_ != null)
         {
            _loc8_.arrangeListItems();
            _loc8_.visible = _loc12_;
         }
         UnknownVarFromInfoStandFurniView_IItemListWindow_2.arrangeListItems();
      }
      
      public function set groupName(param1:String) : void
      {
         var _loc2_:IWindowModel = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("group_name");
         if(_loc2_)
         {
            _loc2_.caption = param1;
            _loc2_.visible = true;
         }
      }
      
      private function showLimitedItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:IWidgetWindowController = null;
         var _loc4_:ILimitedItemPreviewOverlayWidget = null;
         var _loc6_:IWindowController_1 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("unique_item_background_container") as IWindowController_1;
         var _loc5_:IWindowController_1 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("unique_item_overlay_container") as IWindowController_1;
         if(!_loc6_ || !_loc5_)
         {
            return;
         }
         if(!param1)
         {
            _loc6_.visible = false;
            _loc5_.visible = false;
         }
         else
         {
            _loc6_.visible = true;
            _loc5_.visible = true;
            _loc3_ = IWidgetWindowController(_loc5_.findChildByName("unique_item_plaque_widget"));
            _loc4_ = ILimitedItemPreviewOverlayWidget(_loc3_.widget);
            _loc4_.serialNumber = param2.uniqueSerialNumber;
            _loc4_.seriesSize = param2.uniqueSeriesSize;
         }
      }
      
      private function showChestData(param1:Boolean, param2:Boolean, param3:IStuffData) : void
      {
         if(UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("wired_chest_elements") == null)
         {
            return;
         }
         var _loc6_:MapStuffData = param3 as MapStuffData;
         if(!param1 && !param2 || _loc6_ == null)
         {
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("wired_chest_elements").visible = false;
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("name_extra_text").visible = false;
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("chest_item_count").visible = false;
            return;
         }
         var _loc7_:* = _loc6_.getValue("is_wired_enabled") == "1";
         UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("wired_chest_elements").visible = _loc7_;
         if(_loc7_)
         {
            UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("locked_icon").visible = _loc6_.getValue("locked") == "1";
         }
         var _loc4_:ITextWindow = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("name_extra_text") as ITextWindow;
         _loc4_.visible = param3.chestName != "";
         if(param3.chestName != "")
         {
            _loc4_.text = param3.chestName;
         }
         var _loc5_:ITextWindow = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("chest_item_count") as ITextWindow;
         _loc5_.visible = true;
         var _loc8_:String = "infostand.chest_contents." + (param1 ? "furni" : "coin");
         _loc5_.text = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.localizations.getLocalizationWithParams(_loc8_,"","amount",_loc6_.getValue("contents_count"));
      }
      
      private function showRarityItem(param1:Boolean, param2:IStuffData) : void
      {
         var _loc3_:IWidgetWindowController = null;
         var _loc4_:IRarityItemPreviewOverlayWidget = null;
         var _loc5_:IWindowController_1 = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("rarity_item_overlay_container") as IWindowController_1;
         if(!_loc5_)
         {
            return;
         }
         if(!param1)
         {
            _loc5_.visible = false;
         }
         else
         {
            _loc5_.visible = true;
            _loc3_ = IWidgetWindowController(_loc5_.findChildByName("rarity_item_overlay_widget"));
            _loc4_ = IRarityItemPreviewOverlayWidget(_loc3_.widget);
            _loc4_.rarityLevel = param2.rarityLevel;
         }
      }
      
      public function set groupBadgeId(param1:String) : void
      {
         var _loc3_:IWidgetWindowController = UnknownVarFromInfoStandFurniView_UnknownICoreWindowComponents6_1.findChildByName("group_badge_image") as IWidgetWindowController;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
         _loc2_.groupId = UnknownVarFromInfoStandFurniView_InfoStandWidget_1.furniData.groupId;
         _loc3_.visible = true;
      }
   }
}

