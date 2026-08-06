package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.RemoveBotFromFlatMessageComposer;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class InfoStandRentableBotView
   {
      private static const STATUS_BAR_WIDTH:int = 162;
      
      private static const STATUS_BAR_HEIGHT:int = 16;
      
      private static const ITEM_SPACER:int = 5;
      
      private static const STATUS_BAR_HIGHLIGHT_HEIGHT:int = 4;
      
      private static const STATUS_BAR_BORDER_COLOR:uint = 14342874;
      
      private static const STATUS_BAR_BG_COLOR:uint = 3815994;
      
      private static const STATUS_BAR_EXPIRE_HIGHLIGHT_COLOR:uint = 2085362;
      
      private static const STATUS_BAR_EXPIRE_CONTENT_COLOR:uint = 39616;
      
      private static const FIELD_NAME:String = "name_text";
      
      private static const FIELD_DESCRIPTION:String = "description_text";
      
      private static const FIELD_HAND_ITEM:String = "handitem_text";
      
      private static const FIELD_OWNER:String = "owner_text";
      
      private static const FIELD_EXPIRE_TIME:String = "expire_time_left";
      
      private static const FIELD_EXPIRE_HEADER:String = "expire_time_info";
      
      private static const UnknownConstFromInfoStandRentableBotView_String_1:String = "handitem_spacer";
      
      private static const BUTTONS_MAX_WIDTH:int = 250;
      
      private static const BUTTON_HEIGHT:int = 25;
      
      private static const BUTTON_MARGIN:int = 5;
      
      private var _catalog:IHabboCatalog;
      
      private var _habboTracking:IHabboTracking;
      
      private var UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1:InfoStandWidget;
      
      private var _window:IItemListWindow;
      
      private var UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var _buttonsContainer:IWindowController_1;
      
      private var UnknownVarFromInfoStandRentableBotView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromInfoStandRentableBotView_String_1:String;
      
      private var UnknownVarFromInfoStandRentableBotView_Int_1:int;
      
      private var UnknownVarFromInfoStandRentableBotView_Int_2:int;
      
      private var _disposed:Boolean;
      
      public function InfoStandRentableBotView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super();
         UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1 = param1;
         _catalog = param3;
         _habboTracking = HabboTracking.getInstance();
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1 = null;
         _catalog = null;
         _habboTracking = null;
         UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1 = null;
         _buttonsContainer = null;
         UnknownVarFromInfoStandRentableBotView_IItemListWindow_1 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         _disposed = true;
      }
      
      public function get window() : IItemListWindow
      {
         return _window;
      }
      
      private function updateWindow() : void
      {
         if(UnknownVarFromInfoStandRentableBotView_IItemListWindow_1 == null || UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1 == null || _buttonsContainer == null)
         {
            return;
         }
         _buttonsContainer.width = _buttonsContainer.width;
         _buttonsContainer.visible = _buttonsContainer.width > 0;
         UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.height = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.scrollableRegion.height;
         UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.height = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.height + 20;
         _window.width = Math.max(UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.width,_buttonsContainer.width);
         _window.height = _window.scrollableRegion.height;
         if(UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.width < _buttonsContainer.width)
         {
            UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.x = _window.width - UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.width;
            _buttonsContainer.x = 0;
         }
         else
         {
            _buttonsContainer.x = _window.width - _buttonsContainer.width;
            UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.x = 0;
         }
         UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.refreshContainer();
      }
      
      public function update(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         UnknownVarFromInfoStandRentableBotView_Int_1 = param1.webID;
         UnknownVarFromInfoStandRentableBotView_Int_2 = param1.userRoomId;
         setFieldText("name_text",true,param1.name);
         setFieldText("description_text",true,param1.motto);
         if(param1.ownerId > -1)
         {
            UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.localizations.registerParameter("infostand.text.botowner","name",param1.ownerName);
            setFieldText("owner_text",true,UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.localizations.getLocalization("infostand.text.botowner"));
         }
         else
         {
            setFieldText("owner_text",false,"");
         }
         var _loc5_:IRoomSession = UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.handler.container.roomSession;
         var _loc3_:Boolean = _loc5_ != null && _loc5_.playTestMode;
         updateRentExpireField();
         setCarryItem(param1.carryItem);
         var _loc2_:Array = param1.badges;
         setBadge(_loc2_ && _loc2_.length > 0 ? _loc2_[0] : null);
         setFigure(param1.figure);
         var _loc4_:Boolean = param1.ownerId > -1 && (param1.amIOwner || param1.amIAnyRoomController);
         var _loc6_:Boolean = param1.ownerId > -1 && (!_loc3_ && (param1.myRoomControllerLevel >= 1 || param1.amIOwner || param1.amIAnyRoomController));
         showButton("whisper",false);
         showButton("ignore",false);
         showButton("unignore",false);
         showButton("move",_loc6_);
         showButton("rotate",_loc6_);
         showButton("pick",_loc4_);
         updateWindow();
      }
      
      private function updateRentExpireField() : void
      {
         setFieldText("expire_time_left",false,"N/A");
         setFieldText("expire_time_info",false,"");
      }
      
      public function setCarryItem(param1:int) : void
      {
         var _loc2_:String = null;
         var _loc6_:ITextWindow = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.getListItemByName("handitem_text") as ITextWindow;
         var _loc3_:IWindowController_1 = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.getListItemByName("handitem_spacer") as IWindowController_1;
         if(_loc6_ == null || _loc3_ == null)
         {
            return;
         }
         if(param1 > 0 && param1 < 999999)
         {
            _loc2_ = UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.localizations.getLocalization("handitem" + param1,"handitem" + param1);
            UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.localizations.registerParameter("infostand.text.handitem","item",_loc2_);
         }
         _loc6_.height = _loc6_.textHeight + 5;
         var _loc4_:Boolean = Boolean(_loc6_.visible);
         var _loc5_:Boolean = param1 > 0 && param1 < 999999;
         _loc6_.visible = _loc5_;
         _loc3_.visible = _loc5_;
         if(_loc5_ != _loc4_)
         {
            UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.arrangeListItems();
         }
         updateWindow();
      }
      
      private function createPercentageBar(param1:int, param2:int, param3:uint, param4:uint) : BitmapData
      {
         param2 = Math.max(param2,1);
         param1 = Math.max(param1,0);
         if(param1 > param2)
         {
            param1 = param2;
         }
         var _loc10_:Number = param1 / param2;
         var _loc9_:int = 1;
         var _loc7_:BitmapData = new BitmapData(162,16,false);
         _loc7_.fillRect(new Rectangle(0,0,_loc7_.width,_loc7_.height),14342874);
         var _loc8_:Rectangle = new Rectangle(_loc9_,_loc9_,_loc7_.width - _loc9_ * 2,_loc7_.height - _loc9_ * 2);
         _loc7_.fillRect(_loc8_,3815994);
         var _loc6_:Rectangle = new Rectangle(_loc9_,_loc9_ + 4,_loc7_.width - _loc9_ * 2,_loc7_.height - _loc9_ * 2 - 4);
         _loc6_.width = _loc10_ * _loc6_.width;
         _loc7_.fillRect(_loc6_,param3);
         var _loc5_:Rectangle = new Rectangle(_loc9_,_loc9_,_loc7_.width - _loc9_ * 2,4);
         _loc5_.width = _loc10_ * _loc5_.width;
         _loc7_.fillRect(_loc5_,param4);
         return _loc7_;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc5_:XmlAsset = UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.assets.getAssetByName("rentable_bot_view") as XmlAsset;
         _window = UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.windowManager.buildFromXML(_loc5_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1 = _window.getListItemByName("info_border") as UnknownICoreWindowComponents6;
         if(UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1 != null)
         {
            UnknownVarFromInfoStandRentableBotView_IItemListWindow_1 = UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.mainContainer.addChild(_window);
         var _loc4_:IWindowModel = UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.findChildByTag("close");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onClose);
         }
         _buttonsContainer = _window.getListItemByName("button_list") as IWindowController_1;
         if(_buttonsContainer == null)
         {
            return;
         }
         var _loc3_:Array = [];
         _buttonsContainer.groupChildrenWithTag("CMD_BUTTON",_loc3_,-1);
         for each(var _loc2_ in _loc3_)
         {
            _loc2_.addEventListener("WME_CLICK",onButtonClicked);
         }
         for each(var _loc6_ in _loc3_)
         {
            if(_loc6_.parent)
            {
               _loc6_.parent.width = _loc6_.width;
            }
            _loc6_.addEventListener("WE_RESIZED",onButtonResized);
         }
      }
      
      private function setFieldText(param1:String, param2:Boolean, param3:String) : void
      {
         var _loc5_:IWindowController_1 = null;
         if(UnknownVarFromInfoStandRentableBotView_IItemListWindow_1 == null)
         {
            return;
         }
         var _loc4_:ITextWindow = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.getListItemByName(param1) as ITextWindow;
         if(_loc4_ == null)
         {
            _loc5_ = UnknownVarFromInfoStandRentableBotView_IItemListWindow_1.getListItemByName("description_container") as IWindowController_1;
            if(_loc5_ == null)
            {
               return;
            }
            _loc4_ = _loc5_.findChildByName(param1) as ITextWindow;
            if(!_loc4_)
            {
               return;
            }
         }
         _loc4_.text = param3;
         _loc4_.visible = param2;
      }
      
      private function setFigure(param1:String) : void
      {
         var _loc2_:IAvatarImageWidget = IWidgetWindowController(UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.findChildByName("avatar_image")).widget as IAvatarImageWidget;
         _loc2_.figure = param1;
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc2_:IBadgeImageWidget = IWidgetWindowController(UnknownVarFromInfoStandRentableBotView_UnknownICoreWindowComponents6_1.findChildByName("badge")).widget as IBadgeImageWidget;
         _loc2_.badgeId = param1;
      }
      
      protected function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetMessage = null;
         switch(param1.target.name)
         {
            case "move":
               _loc2_ = new RoomWidgetFurniActionMessage("RWFAM_MOVE",UnknownVarFromInfoStandRentableBotView_Int_2,100);
               break;
            case "rotate":
               _loc2_ = new RoomWidgetFurniActionMessage("RWFUAM_ROTATE",UnknownVarFromInfoStandRentableBotView_Int_2,100);
               break;
            case "pick":
               UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.handler.container.connection.send(new RemoveBotFromFlatMessageComposer(UnknownVarFromInfoStandRentableBotView_Int_1));
         }
         if(_loc2_ != null)
         {
            UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         UnknownVarFromInfoStandRentableBotView_InfoStandWidget_1.close();
      }
      
      protected function showButton(param1:String, param2:Boolean) : void
      {
         if(_buttonsContainer == null)
         {
            return;
         }
         var _loc3_:IWindowModel = _buttonsContainer.getChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.visible = param2;
            arrangeButtons();
         }
      }
      
      protected function onButtonResized(param1:WindowEvent) : void
      {
         var _loc2_:IWindowModel = param1.window.parent;
         if(_loc2_ && _loc2_.tags.indexOf("CMD_BUTTON_REGION") > -1)
         {
            _loc2_.width = param1.window.width;
         }
      }
      
      private function arrangeButtons() : void
      {
         var _loc5_:int = 250;
         _buttonsContainer.width = _loc5_;
         var _loc2_:Array = [];
         _buttonsContainer.groupChildrenWithTag("CMD_BUTTON_REGION",_loc2_,-1);
         _loc2_ = _loc2_.reverse();
         var _loc1_:* = _loc5_;
         var _loc3_:int = 0;
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_.visible)
            {
               if(_loc1_ - _loc4_.width < 0)
               {
                  _loc1_ = _loc5_;
                  _loc3_ += 25 + 5;
               }
               _loc4_.x = _loc1_ - _loc4_.width;
               _loc4_.y = _loc3_;
               _loc1_ = _loc4_.x - 5;
            }
         }
         _buttonsContainer.height = _loc3_ + 25;
         updateWindow();
      }
   }
}

