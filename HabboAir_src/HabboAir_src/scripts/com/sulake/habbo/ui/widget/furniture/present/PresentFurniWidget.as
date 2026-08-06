package com.sulake.habbo.ui.widget.furniture.present
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class PresentFurniWidget extends RoomWidgetBase implements UnknownIHabboAvatar1
   {
      private static const UnknownConstFromPresentFurniWidget_String_1:String = "floor";
      
      private static const TYPE_WALLPAPER:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
      
      private var UnknownVarFromPresentFurniWidget_IComponent_1_1:IComponent_1;
      
      private var _catalog:IHabboCatalog;
      
      private var _inventory:IHabboInventory;
      
      private var _roomEngine:IRoomEngine;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromPresentFurniWidget_Int_1:int = -1;
      
      private var UnknownVarFromPresentFurniWidget_Int_2:int = 0;
      
      private var UnknownVarFromPresentFurniWidget_String_1:String;
      
      private var _text:String;
      
      private var UnknownVarFromPresentFurniWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromPresentFurniWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromPresentFurniWidget_String_2:String;
      
      private var _senderName:String;
      
      private var UnknownVarFromPresentFurniWidget_Int_3:int = -1;
      
      private var UnknownVarFromPresentFurniWidget_String_3:String = "";
      
      private var _placedInRoom:Boolean = false;
      
      private var UnknownVarFromPresentFurniWidget_Boolean_3:Boolean = false;
      
      public function PresentFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1, param6:IHabboCatalog, param7:IHabboInventory, param8:IRoomEngine)
      {
         super(param1,param2,param3,param4);
         UnknownVarFromPresentFurniWidget_IComponent_1_1 = param5;
         _catalog = param6;
         _inventory = param7;
         _roomEngine = param8;
      }
      
      override public function dispose() : void
      {
         hideInterface();
         UnknownVarFromPresentFurniWidget_IComponent_1_1 = null;
         _catalog = null;
         _inventory = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.removeEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case "RWPDUE_PACKAGEINFO":
               hideInterface();
               UnknownVarFromPresentFurniWidget_Boolean_2 = false;
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               _senderName = param1.purchaserName;
               UnknownVarFromPresentFurniWidget_String_2 = param1.purchaserFigure;
               UnknownVarFromPresentFurniWidget_Boolean_3 = param1.trustedSender;
               showInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_FLOOR":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               UnknownVarFromPresentFurniWidget_Int_2 = param1.classId;
               UnknownVarFromPresentFurniWidget_String_1 = param1.itemType;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               UnknownVarFromPresentFurniWidget_Int_3 = param1.placedItemId;
               UnknownVarFromPresentFurniWidget_String_3 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_floor");
               break;
            case "RWPDUE_CONTENTS_LANDSCAPE":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               UnknownVarFromPresentFurniWidget_Int_2 = param1.classId;
               UnknownVarFromPresentFurniWidget_String_1 = param1.itemType;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               UnknownVarFromPresentFurniWidget_Int_3 = param1.placedItemId;
               UnknownVarFromPresentFurniWidget_String_3 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_landscape");
               break;
            case "RWPDUE_CONTENTS_WALLPAPER":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               UnknownVarFromPresentFurniWidget_Int_2 = param1.classId;
               UnknownVarFromPresentFurniWidget_String_1 = param1.itemType;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               UnknownVarFromPresentFurniWidget_Int_3 = param1.placedItemId;
               UnknownVarFromPresentFurniWidget_String_3 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_wallpaper");
               break;
            case "RWPDUE_CONTENTS_CLUB":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               UnknownVarFromPresentFurniWidget_Int_2 = param1.classId;
               UnknownVarFromPresentFurniWidget_String_1 = param1.itemType;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_hc");
               break;
            case "RWPDUE_CONTENTS":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               UnknownVarFromPresentFurniWidget_Int_1 = param1.objectId;
               UnknownVarFromPresentFurniWidget_Int_2 = param1.classId;
               UnknownVarFromPresentFurniWidget_String_1 = param1.itemType;
               _text = param1.text;
               UnknownVarFromPresentFurniWidget_Boolean_1 = param1.controller;
               UnknownVarFromPresentFurniWidget_Int_3 = param1.placedItemId;
               UnknownVarFromPresentFurniWidget_String_3 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_IMAGE":
               if(!UnknownVarFromPresentFurniWidget_Boolean_2)
               {
                  return;
               }
               showIcon(param1.iconBitmapData);
               break;
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == UnknownVarFromPresentFurniWidget_Int_1)
         {
            hideInterface();
         }
         if(param1.id == UnknownVarFromPresentFurniWidget_Int_3)
         {
            if(_placedInRoom)
            {
               _placedInRoom = false;
               updateRoomAndInventoryButtons();
            }
         }
      }
      
      private function onEcotronUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWEBDUE_PACKAGEINFO" === _loc2_)
         {
            hideInterface();
         }
      }
      
      private function showCustomIcon(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapDataAsset = assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
         }
         showIcon(_loc2_);
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("gift_image") as IBitmapWrapperController;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_);
      }
      
      private function showGiftOpenedInterface() : void
      {
         var _loc11_:String = null;
         var _loc3_:BitmapDataAsset = null;
         var _loc1_:BitmapData = null;
         var _loc2_:String = null;
         var _loc10_:Boolean = false;
         var _loc4_:String = null;
         if(UnknownVarFromPresentFurniWidget_Int_1 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc9_:XmlAsset = assets.getAssetByName("packagecard_new_opened") as XmlAsset;
         _window = windowManager.buildFromXML(_loc9_.content as XML) as IFrameController;
         _window.center();
         if(!isUnknownSender())
         {
            _loc11_ = "widget.furni.present.window.title_from";
            _localizations.registerParameter(_loc11_,"name",_senderName);
            _window.caption = _localizations.getLocalization(_loc11_,_senderName);
         }
         var _loc6_:IWindowModel = _window.findChildByName("header_button_close");
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onClose);
         }
         var _loc7_:IBitmapWrapperController = _window.findChildByName("image_bg") as IBitmapWrapperController;
         if(_loc7_ != null)
         {
            _loc3_ = assets.getAssetByName("gift_icon_background") as BitmapDataAsset;
            if(_loc3_ != null)
            {
               _loc1_ = _loc3_.content as BitmapData;
               if(_loc7_.bitmap)
               {
                  _loc7_.bitmap.dispose();
               }
               _loc7_.bitmap = _loc1_.clone();
            }
         }
         var _loc5_:ITextWindow = _window.findChildByName("gift_message") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.text = "";
            if(_text != null)
            {
               _loc2_ = "widget.furni.present.message_opened";
               _loc10_ = isSpacesItem();
               if(_loc10_)
               {
                  _loc2_ = "widget.furni.present.spaces.message_opened";
               }
               _localizations.registerParameter(_loc2_,"product",_text);
               if(UnknownVarFromPresentFurniWidget_String_1 == "h")
               {
                  _loc5_.text = _text;
               }
               else
               {
                  _loc5_.text = _localizations.getLocalization(_loc2_,_text);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
         }
         var _loc8_:IWindowModel = _window.findChildByName("give_gift_button");
         if(_loc8_ != null)
         {
            if(!isUnknownSender())
            {
               _loc4_ = "widget.furni.present.give_gift";
               _localizations.registerParameter(_loc4_,"name",_senderName);
               _loc8_.caption = _localizations.getLocalization(_loc4_,_senderName);
               _loc8_.addEventListener("WME_CLICK",onGiveGiftOpened);
            }
            else
            {
               _loc8_.visible = false;
            }
         }
         prepareAvatarImageContainer();
         updateGiftDialogAvatarImage(UnknownVarFromPresentFurniWidget_String_2);
         updateRoomAndInventoryButtons();
         selectGiftedObject();
      }
      
      private function isSpacesItem() : Boolean
      {
         var _loc2_:IFurnitureData = null;
         var _loc3_:String = null;
         var _loc1_:Boolean = false;
         if(UnknownVarFromPresentFurniWidget_String_1 == "i")
         {
            _loc2_ = (_widgetHandler as FurniturePresentWidgetHandler).container.sessionDataManager.getWallItemData(UnknownVarFromPresentFurniWidget_Int_2);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.className;
               _loc1_ = _loc3_ == "floor" || _loc2_.className == "landscape" || _loc2_.className == "wallpaper";
            }
         }
         return _loc1_;
      }
      
      private function isClubItem() : Boolean
      {
         return UnknownVarFromPresentFurniWidget_String_1 == "h";
      }
      
      private function updateRoomAndInventoryButtons() : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = isSpacesItem();
         var _loc7_:Boolean = isClubItem();
         var _loc10_:IWindowModel = _window.findChildByName("keep_in_room_button");
         if(_loc10_ != null)
         {
            _loc10_.addEventListener("WME_CLICK",onKeepInRoom);
            _loc10_.visible = _placedInRoom;
            if(_loc4_ || _loc7_)
            {
               _loc10_.visible = false;
            }
         }
         var _loc1_:IWindowModel = _window.findChildByName("place_in_room_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onPlaceInRoom);
            _loc1_.visible = !_placedInRoom;
            if(_loc4_)
            {
               _loc1_.disable();
            }
            if(_loc4_ || _loc7_)
            {
               _loc1_.visible = false;
            }
         }
         var _loc2_:IWindowModel = _window.findChildByName("put_in_inventory_button");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPutInInventory);
            _loc2_.enable();
            if(_loc4_ || _loc7_)
            {
               _loc2_.visible = false;
            }
         }
         var _loc8_:IWindowModel = _window.findChildByName("separator");
         if(_loc8_ != null)
         {
            _loc8_.visible = isUnknownSender();
         }
         var _loc5_:IWindowModel = _window.findChildByName("give_container") as IWindowModel;
         if(_loc5_ != null)
         {
            _loc5_.visible = !isUnknownSender();
         }
         var _loc6_:IItemListWindow = _window.findChildByName("button_list") as IItemListWindow;
         if(_loc6_ != null)
         {
            _loc6_.arrangeListItems();
         }
         var _loc3_:IItemListWindow = _window.findChildByName("give_element_list") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.arrangeListItems();
         }
         var _loc9_:IItemListWindow = _window.findChildByName("element_list") as IItemListWindow;
         if(_loc9_ != null)
         {
            _loc9_.arrangeListItems();
         }
         _window.resizeToFitContent();
      }
      
      private function resetAndHideInterface() : void
      {
         UnknownVarFromPresentFurniWidget_Boolean_2 = false;
         UnknownVarFromPresentFurniWidget_Int_3 = -1;
         _placedInRoom = false;
         hideInterface();
      }
      
      private function onKeepInRoom(param1:WindowEvent) : void
      {
         resetAndHideInterface();
      }
      
      private function onPlaceInRoom(param1:WindowEvent) : void
      {
         var _loc3_:IFurnitureItem = null;
         var _loc2_:IWindowModel = param1.target;
         _loc2_.disable();
         if(UnknownVarFromPresentFurniWidget_Int_3 > 0 && !_placedInRoom)
         {
            _loc3_ = null;
            switch(UnknownVarFromPresentFurniWidget_String_3)
            {
               case "s":
                  _loc3_ = _inventory.getFloorItemById(-UnknownVarFromPresentFurniWidget_Int_3);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(UnknownVarFromPresentFurniWidget_Int_3);
                  }
                  break;
               case "i":
                  _loc3_ = _inventory.getWallItemById(UnknownVarFromPresentFurniWidget_Int_3);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(UnknownVarFromPresentFurniWidget_Int_3);
                  }
                  break;
               case "p":
                  if(_inventory.placePetToRoom(UnknownVarFromPresentFurniWidget_Int_3,false))
                  {
                     _inventory.removeUnseenPetCounter(UnknownVarFromPresentFurniWidget_Int_3);
                  }
            }
         }
         resetAndHideInterface();
      }
      
      public function requestSelectedFurniPlacement(param1:IFurnitureItem) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         if(param1.category == 3 || param1.category == 2 || param1.category == 4)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = _inventory.requestSelectedFurniToMover(param1);
         }
         return _loc2_;
      }
      
      private function onPutInInventory(param1:WindowEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc2_:IWindowModel = param1.target;
         _loc2_.disable();
         if(UnknownVarFromPresentFurniWidget_Int_3 > 0 && _placedInRoom)
         {
            if(UnknownVarFromPresentFurniWidget_String_3 == "p")
            {
               (_widgetHandler as FurniturePresentWidgetHandler).container.roomSession.pickUpPet(UnknownVarFromPresentFurniWidget_Int_3);
            }
            else
            {
               _loc4_ = (_widgetHandler as FurniturePresentWidgetHandler).container.roomSession.roomId;
               _loc5_ = 10;
               _loc3_ = _roomEngine.getRoomObject(_loc4_,UnknownVarFromPresentFurniWidget_Int_3,_loc5_);
               if(_loc3_ != null)
               {
                  _roomEngine.modifyRoomObject(_loc3_.getId(),_loc5_,"OBJECT_PICKUP");
               }
            }
         }
         resetAndHideInterface();
      }
      
      private function showInterface() : void
      {
         var _loc7_:String = null;
         var _loc15_:String = null;
         var _loc9_:UnknownICoreWindowComponents6 = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc13_:String = null;
         var _loc16_:ITextWindow = null;
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc2_:String = null;
         var _loc4_:IWindowModel = null;
         var _loc10_:String = null;
         var _loc8_:IWindowModel = null;
         if(UnknownVarFromPresentFurniWidget_Int_1 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc12_:XmlAsset = assets.getAssetByName("packagecard_new") as XmlAsset;
         _window = windowManager.buildFromXML(_loc12_.content as XML) as IFrameController;
         _window.center();
         if(!isUnknownSender())
         {
            _loc7_ = "widget.furni.present.window.title_from";
            _localizations.registerParameter(_loc7_,"name",_senderName);
            _window.caption = _localizations.getLocalization(_loc7_,_senderName);
         }
         var _loc11_:IWindowModel = _window.findChildByName("header_button_close");
         if(_loc11_ != null)
         {
            _loc11_.addEventListener("WME_CLICK",onClose);
         }
         var _loc6_:IStaticBitmapWrapperWindow = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
         if(_loc6_)
         {
            _loc15_ = UnknownVarFromPresentFurniWidget_IComponent_1_1.getProperty("catalog.gift_wrapping_new.gift_card");
            if(_loc15_ != "")
            {
               _loc6_.assetUri = "${image.library.url}Giftcards/" + _loc15_ + ".png";
            }
         }
         prepareAvatarImageContainer();
         if(isUnknownSender())
         {
            updateUnknownSenderAvatarImage();
         }
         else
         {
            updateGiftDialogAvatarImage(UnknownVarFromPresentFurniWidget_String_2);
         }
         if(!UnknownVarFromPresentFurniWidget_Boolean_3)
         {
            _loc9_ = _window.findChildByName("warning_foreground_border") as UnknownICoreWindowComponents6;
            if(_loc9_ != null)
            {
               _loc9_.color = 11599948;
            }
            _loc14_ = _window.findChildByName("warning_icon") as IStaticBitmapWrapperWindow;
            if(_loc14_ != null)
            {
               _loc14_.assetUri = "catalogue_icon_alert_s";
               _loc14_.width = 26;
               _loc14_.height = 26;
               _loc14_.x = 22;
               _loc14_.y = 12;
            }
            _loc13_ = "gift.untrusted.banner.text";
            _localizations.registerParameter(_loc13_,"name","not trusted gift sender");
            _loc16_ = _window.findChildByName("warning_text") as ITextWindow;
            if(_loc16_ != null)
            {
               _loc16_.text = _localizations.getLocalization(_loc13_,_senderName);
            }
         }
         else
         {
            _loc3_ = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
            _loc3_.assetUri = "catalogue_giftcard_staff";
         }
         var _loc1_:ITextWindow = _window.findChildByName("message_text") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = _text;
         }
         var _loc18_:ITextWindow = _window.findChildByName("message_from") as ITextWindow;
         if(_loc18_ != null)
         {
            _loc18_.text = "";
            if(!isUnknownSender())
            {
               _loc2_ = "widget.furni.present.message_from";
               _localizations.registerParameter(_loc2_,"name",_senderName);
               _loc18_.text = _localizations.getLocalization(_loc2_,_senderName);
               _loc18_.addEventListener("WME_CLICK",onSenderNameClick);
            }
            else
            {
               _loc18_.visible = false;
            }
         }
         var _loc5_:IItemListWindow = _window.findChildByName("button_list") as IItemListWindow;
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.getListItemByName("give_gift_button");
            if(_loc4_ != null)
            {
               if(!isUnknownSender())
               {
                  _loc10_ = "widget.furni.present.give_gift";
                  _localizations.registerParameter(_loc10_,"name",_senderName);
                  _loc4_.caption = _localizations.getLocalization(_loc10_,_senderName);
               }
               if(UnknownVarFromPresentFurniWidget_Boolean_1)
               {
                  _loc4_.addEventListener("WME_CLICK",onGiveGift);
               }
               if(!UnknownVarFromPresentFurniWidget_Boolean_1 || isUnknownSender())
               {
                  _loc4_.visible = false;
               }
            }
            _loc8_ = _window.findChildByName("open_gift_button");
            if(_loc8_ != null)
            {
               if(UnknownVarFromPresentFurniWidget_Boolean_1)
               {
                  _loc8_.addEventListener("WME_CLICK",onOpenGift);
               }
               else
               {
                  _loc8_.visible = false;
               }
            }
            _loc5_.arrangeListItems();
         }
         var _loc17_:IItemListWindow = _window.findChildByName("element_list") as IItemListWindow;
         _loc17_.x = _loc17_.spacing;
         _window.resizeToFitContent();
         _loc17_.parent.height = _loc17_.x + _loc17_.height;
      }
      
      private function isUnknownSender() : Boolean
      {
         return _senderName == null || _senderName.length == 0;
      }
      
      private function onClose(param1:WindowEvent) : void
      {
         UnknownVarFromPresentFurniWidget_Boolean_2 = false;
         hideInterface();
      }
      
      private function onGiveGift(param1:WindowEvent) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_open_giftcard.clicked");
      }
      
      private function onGiveGiftOpened(param1:WindowEvent) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_opened_present.clicked");
      }
      
      private function openGiftShop() : void
      {
         if(!isUnknownSender())
         {
            _catalog.giftReceiver = _senderName;
         }
         _catalog.openCatalogPage("gift_shop");
      }
      
      private function send(param1:IMessageComposer) : void
      {
         var _loc2_:IConnection = null;
         if(_catalog != null)
         {
            _loc2_ = _catalog.connection;
            if(_loc2_ != null)
            {
               _loc2_.send(param1);
            }
         }
      }
      
      private function getExtendedProfile() : void
      {
         if(!isUnknownSender())
         {
            send(new GetExtendedProfileByNameMessageComposer(_senderName));
         }
      }
      
      private function onSenderImageClick(param1:WindowEvent) : void
      {
         getExtendedProfile();
      }
      
      private function onSenderNameClick(param1:WindowEvent) : void
      {
         getExtendedProfile();
      }
      
      private function onOpenGift(param1:WindowEvent) : void
      {
         sendOpen();
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc3_:IAvatarRenderManager = (_widgetHandler as FurniturePresentWidgetHandler).container.avatarRenderManager;
         if(_loc3_ == null || param1 == null || param1.length == 0)
         {
            return null;
         }
         var _loc2_:BitmapData = null;
         var _loc4_:IAvatarImage_2 = _loc3_.createAvatarImage(param1,"h",null,this);
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         if(param1 == UnknownVarFromPresentFurniWidget_String_2)
         {
            updateGiftDialogAvatarImage(param1);
         }
      }
      
      private function prepareAvatarImageContainer() : void
      {
         var _loc1_:IRegionWindow = _window.findChildByName("avatar_image_region") as IRegionWindow;
         if(_loc1_ != null)
         {
            if(!isUnknownSender())
            {
               _loc1_.addEventListener("WME_CLICK",onSenderImageClick);
            }
            else
            {
               _loc1_.disable();
            }
         }
      }
      
      private function updateGiftDialogAvatarImage(param1:String) : void
      {
         var _loc2_:BitmapData = getAvatarFaceBitmap(param1);
         if(_loc2_ != null)
         {
            updateAvatarImageContainer(_loc2_);
         }
      }
      
      private function updateUnknownSenderAvatarImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapDataAsset = _assets.getAssetByName("gift_incognito") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.content as BitmapData;
            if(_loc1_ != null)
            {
               updateAvatarImageContainer(_loc1_.clone());
            }
         }
      }
      
      private function updateAvatarImageContainer(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _window.findChildByName("avatar_image") as IBitmapWrapperController;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:IWindowController_1 = _window.findChildByName("staff_image") as IWindowController_1;
         var _loc4_:IWindowController_1 = _window.findChildByName("avatar_image_container") as IWindowController_1;
         if(UnknownVarFromPresentFurniWidget_Boolean_3 && isUnknownSender())
         {
            _loc3_.disable();
            if(_loc2_ != null)
            {
               _loc2_.y = _loc4_.height / 2 - _loc3_.height / 2;
            }
         }
         else
         {
            _loc3_.bitmap = param1;
            _loc3_.width = param1.width;
            _loc3_.height = param1.height;
            _loc3_.x = _loc4_.width / 2 - _loc3_.width / 2;
            _loc3_.y = _loc4_.height / (UnknownVarFromPresentFurniWidget_Boolean_3 ? 1.5 : 2) - _loc3_.height / 2;
         }
         if(!UnknownVarFromPresentFurniWidget_Boolean_3)
         {
            if(_loc2_ != null)
            {
               (_loc2_.parent as IWindowController_1).removeChild(_loc2_);
            }
         }
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(!UnknownVarFromPresentFurniWidget_Boolean_2)
         {
            UnknownVarFromPresentFurniWidget_Int_1 = -1;
         }
         _text = "";
         UnknownVarFromPresentFurniWidget_Boolean_1 = false;
      }
      
      private function sendOpen() : void
      {
         var _loc1_:RoomWidgetPresentOpenMessage = null;
         if(UnknownVarFromPresentFurniWidget_Boolean_2 || UnknownVarFromPresentFurniWidget_Int_1 == -1 || !UnknownVarFromPresentFurniWidget_Boolean_1)
         {
            return;
         }
         UnknownVarFromPresentFurniWidget_Boolean_2 = true;
         hideInterface();
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetPresentOpenMessage("RWPOM_OPEN_PRESENT",UnknownVarFromPresentFurniWidget_Int_1);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      private function selectGiftedObject() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc1_:IUserData = null;
         if(UnknownVarFromPresentFurniWidget_Int_3 > 0 && _placedInRoom)
         {
            _loc5_ = _roomEngine.activeRoomId;
            if(UnknownVarFromPresentFurniWidget_String_3 == "p")
            {
               _loc3_ = _roomEngine.getRoomObjectCount(_loc5_,100);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = _roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
                  _loc1_ = (_widgetHandler as FurniturePresentWidgetHandler).container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
                  if(_loc1_ != null && _loc1_.webID == UnknownVarFromPresentFurniWidget_Int_3)
                  {
                     _roomEngine.selectRoomObject(_loc5_,_loc1_.roomObjectId,100);
                     break;
                  }
                  _loc4_++;
               }
            }
            else
            {
               _roomEngine.selectRoomObject(_loc5_,UnknownVarFromPresentFurniWidget_Int_3,10);
            }
         }
      }
   }
}

