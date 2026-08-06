package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class HabboNotificationItemView implements IProfiler_1
   {
      public static const MAX_HEIGHT:int = 70;
      
      public static const SIDE_MARGIN:int = 5;
      
      private static const MOVE_DURATION_MS:int = 220;
      
      private static const STATE_IDLE:int = 0;
      
      private static const STATE_FADE_IN:int = 1;
      
      private static const STATE_DISPLAY:int = 2;
      
      private static const STATE_FADE_OUT:int = 3;
      
      private static const STATE_SWIPE_OUT:int = 4;
      
      private var UnknownVarFromHabboNotificationItemView_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      private var _window:IWindowModel;
      
      private var _item:HabboNotificationItem;
      
      private var _hovering:Boolean = false;
      
      private var _styleConfig:Map;
      
      private var _viewConfig:Map;
      
      private var UnknownVarFromHabboNotificationItemView_Uint_1:uint;
      
      private var UnknownVarFromHabboNotificationItemView_Uint_2:uint;
      
      private var UnknownVarFromHabboNotificationItemView_Uint_3:uint;
      
      private var UnknownVarFromHabboNotificationItemView_Uint_4:uint;
      
      private var _margin:int;
      
      private var _targetMargin:int;
      
      private var UnknownVarFromHabboNotificationItemView_Number_1:Number;
      
      private var _resizeMargin:int;
      
      private var UnknownVarFromHabboNotificationItemView_Int_1:int;
      
      private var UnknownVarFromHabboNotificationItemView_Int_2:int;
      
      private var UnknownVarFromHabboNotificationItemView_Int_3:int;
      
      private var _toggleButtonCallback:Function = null;
      
      private var UnknownVarFromHabboNotificationItemView_Boolean_1:Boolean = false;
      
      public function HabboNotificationItemView(param1:IHabboLocalizationManager, param2:ISoundAsset, param3:IHabboWindowManagerComponent, param4:Map, param5:Map, param6:HabboNotificationItem)
      {
         super();
         UnknownVarFromHabboNotificationItemView_IHabboLocalizationManager_1 = param1;
         _styleConfig = param4;
         _viewConfig = param5;
         var _loc7_:XmlAsset = param2 as XmlAsset;
         if(_loc7_ == null)
         {
            return;
         }
         _window = param3.buildFromXML(_loc7_.content as XML,1);
         _window.tags.push("notificationview");
         _window.context.getDesktopWindow().addEventListener("WE_RESIZED",onRoomViewResized);
         _window.procedure = onWindowEvent;
         _window.blend = 0;
         _window.visible = false;
         var _loc8_:ITextWindow = IWindowController_1(_window).findChildByTag("notification_text") as ITextWindow;
         if(_loc8_ != null)
         {
            _resizeMargin = _window.height - _loc8_.bottom;
         }
         else
         {
            _resizeMargin = 15;
         }
         UnknownVarFromHabboNotificationItemView_Int_1 = _window.height;
         _margin = 4;
         _targetMargin = _margin;
         UnknownVarFromHabboNotificationItemView_Number_1 = 0;
         UnknownVarFromHabboNotificationItemView_Int_2 = 0;
         if(param6.style.styleName == "nft_opening")
         {
            showNftOpeningNotification(param6);
         }
         else if(param6.style.styleName == "treasure_hunt")
         {
            showTreasureHuntNotification(param6);
         }
         else if(param6.style.styleName == "wired")
         {
            showWiredNotification(param6);
         }
         else
         {
            showNormalNotification(param6);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get ready() : Boolean
      {
         return UnknownVarFromHabboNotificationItemView_Int_2 == 0;
      }
      
      public function get readyOrFading() : Boolean
      {
         return UnknownVarFromHabboNotificationItemView_Int_2 == 0 || UnknownVarFromHabboNotificationItemView_Int_2 == 3;
      }
      
      public function get verticalPosition() : int
      {
         return _margin;
      }
      
      public function get notificationId() : String
      {
         if(_item == null)
         {
            return null;
         }
         return _item.notificationId;
      }
      
      public function get content() : String
      {
         return _item?.content;
      }
      
      public function get styleName() : String
      {
         return _item == null || _item.style == null ? null : _item.style.styleName;
      }
      
      private function showTreasureHuntNotification(param1:HabboNotificationItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         _window.findChildByName("treasure_hunt_image").visible = param1.style.icon == null;
         showNormalNotification(param1);
      }
      
      private function showWiredNotification(param1:HabboNotificationItem) : void
      {
         var _loc2_:UnknownICoreWindowComponents4 = null;
         if(param1 == null)
         {
            return;
         }
         if("toggle_callback" in param1.style.extraData)
         {
            _toggleButtonCallback = param1.style.extraData["toggle_callback"];
            _loc2_ = _window.findChildByTag("button") as UnknownICoreWindowComponents4;
            UnknownVarFromHabboNotificationItemView_Boolean_1 = false;
            _loc2_.caption = "${notification.stop}";
            _loc2_.visible = true;
            _loc2_.addEventListener("WME_CLICK",onToggleButtonClicked);
         }
         showNormalNotification(param1);
      }
      
      private function onToggleButtonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabboNotificationItemView_Int_2 != 2)
         {
            return;
         }
         var _loc2_:UnknownICoreWindowComponents4 = _window.findChildByTag("button") as UnknownICoreWindowComponents4;
         if(UnknownVarFromHabboNotificationItemView_Boolean_1)
         {
            UnknownVarFromHabboNotificationItemView_Boolean_1 = false;
            _loc2_.caption = "${notification.stop}";
         }
         else
         {
            UnknownVarFromHabboNotificationItemView_Boolean_1 = true;
            _loc2_.caption = "${notification.resume}";
         }
         _toggleButtonCallback(UnknownVarFromHabboNotificationItemView_Boolean_1);
      }
      
      private function showNftOpeningNotification(param1:HabboNotificationItem) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc6_:String = param1.content;
         setNotificationText(_loc6_);
         var _loc2_:IProductDisplayInfo = param1.style.extraData["product"];
         var _loc7_:String = param1.style.extraData["rarity"];
         var _loc5_:uint = uint(param1.style.extraData["rarity_color"]);
         var _loc3_:IProductIconWidget = (_window.findChildByName("icon_widget") as IWidgetWindowController).widget as IProductIconWidget;
         _loc3_.productInfo = _loc2_;
         var _loc4_:UnknownICoreWindowComponents4 = _window.findChildByName("rarity_text") as UnknownICoreWindowComponents4;
         _loc4_.caption = UnknownVarFromHabboNotificationItemView_IHabboLocalizationManager_1.getLocalization("collectibles.item.rarity") + ": " + _loc7_;
         _loc4_.color = _loc5_;
         _item = param1;
         reposition();
         startFadeIn();
      }
      
      private function showNormalNotification(param1:HabboNotificationItem) : void
      {
         var _loc2_:BitmapData = null;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:String = param1.content;
         setNotificationText(_loc3_);
         if(param1.style.iconAssetUri == null)
         {
            _loc2_ = param1.style.icon;
            setNotificationIcon(_loc2_);
         }
         else
         {
            IStaticBitmapWrapperWindow(IWindowController_1(_window).findChildByTag("notification_icon_static")).assetUri = param1.style.iconAssetUri;
         }
         _item = param1;
         reposition();
         startFadeIn();
      }
      
      public function replaceIcon(param1:BadgeImageReadyEvent) : void
      {
         if(param1.badgeId != _item.style.iconSrc)
         {
            return;
         }
         if(param1.badgeImage != null)
         {
            setNotificationIcon(param1.badgeImage);
         }
      }
      
      private function get displayTime() : int
      {
         if("time_display" in _item.style.extraData)
         {
            return _item.style.extraData["time_display"];
         }
         return int(_viewConfig["time_display"]);
      }
      
      public function get staysVisible() : Boolean
      {
         return _item != null && _item.style != null && _item.style.extraData != null && "stay" in _item.style.extraData;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         animatePosition(param1);
         switch(UnknownVarFromHabboNotificationItemView_Int_2)
         {
            case 0:
               break;
            case 1:
               UnknownVarFromHabboNotificationItemView_Uint_1 += param1;
               _loc3_ = UnknownVarFromHabboNotificationItemView_Uint_1 / Number(_viewConfig["time_fade_in"]);
               if(UnknownVarFromHabboNotificationItemView_Uint_1 > int(_viewConfig["time_fade_in"]))
               {
                  startDisplay();
               }
               adjustBlend(_loc3_);
               break;
            case 2:
               UnknownVarFromHabboNotificationItemView_Uint_4 += param1;
               if(UnknownVarFromHabboNotificationItemView_Uint_4 > displayTime && !_hovering && !staysVisible)
               {
                  startFadeOut();
               }
               break;
            case 3:
               UnknownVarFromHabboNotificationItemView_Uint_2 += param1;
               _loc4_ = 1 - UnknownVarFromHabboNotificationItemView_Uint_2 / Number(_viewConfig["time_fade_out"]);
               adjustBlend(_loc4_);
               if(UnknownVarFromHabboNotificationItemView_Uint_2 > int(_viewConfig["time_fade_out"]))
               {
                  startIdling();
               }
               break;
            case 4:
               UnknownVarFromHabboNotificationItemView_Uint_3 += param1;
               _loc2_ = UnknownVarFromHabboNotificationItemView_Uint_3 / Number(_viewConfig["time_swipe_out"]);
               adjustSwipeOut(_loc2_);
               if(UnknownVarFromHabboNotificationItemView_Uint_3 > int(_viewConfig["time_swipe_out"]))
               {
                  startIdling();
                  break;
               }
         }
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_item != null)
         {
            _item.dispose();
            _item = null;
         }
      }
      
      private function setNotificationText(param1:String) : void
      {
         var _loc2_:ITextWindow = IWindowController_1(_window).findChildByTag("notification_text") as ITextWindow;
         if(_loc2_ == null || param1 == null)
         {
            return;
         }
         if(_viewConfig.hasKey("height"))
         {
            _window.height = 0;
            _loc2_.text = param1;
            _loc2_.height = _loc2_.textHeight + _resizeMargin;
            if(_window.height < UnknownVarFromHabboNotificationItemView_Int_1)
            {
               _window.height = UnknownVarFromHabboNotificationItemView_Int_1;
            }
         }
         else
         {
            _loc2_.text = param1;
         }
      }
      
      private function setNotificationIcon(param1:BitmapData) : void
      {
         var _loc6_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:IBitmapWrapperController = IWindowController_1(_window).findChildByTag("notification_icon") as IBitmapWrapperController;
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == null)
         {
            _loc4_.bitmap = null;
            return;
         }
         if(param1.width < _loc4_.width && param1.height < _loc4_.height)
         {
            _loc6_ = new BitmapData(_loc4_.width,_loc4_.height,true,0);
            _loc2_ = (_loc4_.width - param1.width) / 2;
            _loc3_ = (_loc4_.height - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
         }
         else if(param1.width < param1.height)
         {
            _loc6_ = new BitmapData(param1.height,param1.height,true,0);
            _loc5_ = (param1.height - param1.width) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(_loc5_,0));
         }
         else if(param1.width > param1.height)
         {
            _loc6_ = new BitmapData(param1.width,param1.width,true,0);
            _loc5_ = (param1.width - param1.height) / 2;
            _loc6_.copyPixels(param1,param1.rect,new Point(0,_loc5_));
         }
         else
         {
            _loc6_ = new BitmapData(param1.width,param1.height);
            _loc6_.copyPixels(param1,param1.rect,new Point(0,0));
         }
         _loc4_.bitmap = _loc6_;
      }
      
      private function startFadeIn() : void
      {
         UnknownVarFromHabboNotificationItemView_Uint_1 = 0;
         UnknownVarFromHabboNotificationItemView_Int_2 = 1;
         _window.visible = true;
      }
      
      private function startFadeOut() : void
      {
         UnknownVarFromHabboNotificationItemView_Uint_2 = 0;
         UnknownVarFromHabboNotificationItemView_Int_2 = 3;
      }
      
      public function remove() : void
      {
         if(_window == null || UnknownVarFromHabboNotificationItemView_Int_2 == 0 || UnknownVarFromHabboNotificationItemView_Int_2 == 3)
         {
            return;
         }
         _hovering = false;
         startFadeOut();
      }
      
      private function startSwipeOut() : void
      {
         UnknownVarFromHabboNotificationItemView_Uint_3 = 0;
         UnknownVarFromHabboNotificationItemView_Int_2 = 4;
      }
      
      private function startDisplay() : void
      {
         UnknownVarFromHabboNotificationItemView_Uint_4 = 0;
         UnknownVarFromHabboNotificationItemView_Int_2 = 2;
      }
      
      private function startIdling() : void
      {
         UnknownVarFromHabboNotificationItemView_Int_2 = 0;
         _window.visible = false;
      }
      
      public function reposition(param1:int = -1) : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc2_:IDesktopController = _window.context.getDesktopWindow();
         if(_loc2_ == null)
         {
            return;
         }
         if(param1 != -1)
         {
            _margin = param1;
            _targetMargin = param1;
         }
         _window.x = _loc2_.width - _window.width - 5;
         _window.y = _margin;
         UnknownVarFromHabboNotificationItemView_Int_3 = _window.x;
      }
      
      public function setVerticalTarget(param1:int) : void
      {
         _targetMargin = param1;
      }
      
      public function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "WME_CLICK" && param1.target.tags.indexOf("slide_notification_away") != -1)
         {
            if(!staysVisible)
            {
               startSwipeOut();
            }
            return;
         }
         if(param1.type == "WME_OVER")
         {
            _hovering = true;
         }
         else if(param1.type == "WME_OUT")
         {
            _hovering = false;
         }
         else if(param1.type == "WME_CLICK")
         {
            if(_item != null)
            {
               _item.ExecuteUiLinks();
               if(!staysVisible)
               {
                  startFadeOut();
               }
            }
         }
      }
      
      private function onRoomViewResized(param1:WindowEvent) : void
      {
         reposition();
      }
      
      private function adjustBlend(param1:Number) : void
      {
         UnknownVarFromHabboNotificationItemView_Number_1 = param1;
         if(UnknownVarFromHabboNotificationItemView_Number_1 > 1)
         {
            UnknownVarFromHabboNotificationItemView_Number_1 = 1;
         }
         if(UnknownVarFromHabboNotificationItemView_Number_1 < 0)
         {
            UnknownVarFromHabboNotificationItemView_Number_1 = 0;
         }
         _window.blend = UnknownVarFromHabboNotificationItemView_Number_1;
      }
      
      private function adjustSwipeOut(param1:Number) : void
      {
         _window.x = UnknownVarFromHabboNotificationItemView_Int_3 + param1 * _viewConfig["distance_swipe_out"];
      }
      
      private function animatePosition(param1:uint) : void
      {
         if(_window == null || _margin == _targetMargin)
         {
            return;
         }
         var _loc3_:int = _targetMargin - _margin;
         var _loc4_:Number = param1 / 220;
         if(_loc4_ > 1)
         {
            _loc4_ = 1;
         }
         var _loc2_:Number = 1 - (1 - _loc4_) * (1 - _loc4_);
         var _loc5_:int = Math.round(_loc3_ * _loc2_);
         if(_loc5_ == 0)
         {
            _loc5_ = _loc3_ > 0 ? 1 : -1;
         }
         if(Math.abs(_loc5_) >= Math.abs(_loc3_))
         {
            _margin = _targetMargin;
         }
         else
         {
            _margin += _loc5_;
         }
         _window.y = _margin;
      }
      
      public function get height() : int
      {
         if(_viewConfig.hasKey("height"))
         {
            return int(_viewConfig["height"]);
         }
         return _window.height;
      }
      
      public function get item() : HabboNotificationItem
      {
         return _item;
      }
   }
}

