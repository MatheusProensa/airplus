package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.Set;
   import com.sulake.habbo.notifications.HabboNotifications;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   
   public class HabboNotificationViewManager implements IProfiler_1
   {
      private static const SPACING:int = 4;
      
      private var UnknownVarFromHabboNotificationViewManager_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _toolbar:IHabboToolbar;
      
      private var _notifications:HabboNotifications;
      
      private var _styleConfig:Map;
      
      private var _viewConfig:Map;
      
      private var _disposed:Boolean = false;
      
      private var _viewItems:Array;
      
      public function HabboNotificationViewManager(param1:HabboNotifications, param2:IAssetLibraryCollection, param3:IHabboWindowManagerComponent, param4:IHabboToolbar, param5:Map, param6:Map)
      {
         super();
         _notifications = param1;
         UnknownVarFromHabboNotificationViewManager_IAssetLibraryCollection_1 = param2;
         _windowManager = param3;
         _toolbar = param4;
         _styleConfig = param5;
         _viewConfig = param6;
         _viewItems = [];
         if(_toolbar)
         {
            _toolbar.events.addEventListener("EVE_EXTENSION_VIEW_RESIZED",refreshTopMargin);
         }
         _notifications.registerUpdateReceiver(this,2);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function replaceIcon(param1:BadgeImageReadyEvent) : void
      {
         for each(var _loc2_ in _viewItems)
         {
            _loc2_.replaceIcon(param1);
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = int(_viewItems.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            (_viewItems.pop() as HabboNotificationItemView).dispose();
            _loc2_++;
         }
         UnknownVarFromHabboNotificationViewManager_IAssetLibraryCollection_1 = null;
         _windowManager = null;
         if(_styleConfig)
         {
            _styleConfig.dispose();
            _styleConfig = null;
         }
         if(_viewConfig)
         {
            _viewConfig.dispose();
            _viewConfig = null;
         }
         if(_toolbar)
         {
            _toolbar.events.removeEventListener("EVE_EXTENSION_VIEW_RESIZED",refreshTopMargin);
            _toolbar = null;
         }
         if(_notifications != null)
         {
            _notifications.removeUpdateReceiver(this);
            _notifications = null;
         }
         _disposed = true;
      }
      
      public function showItem(param1:HabboNotificationItem) : Boolean
      {
         var _loc2_:HabboNotificationItemView = null;
         if(!isSpaceAvailable())
         {
            return false;
         }
         if(countVisibleItems() >= getDuplicateFadeThreshold())
         {
            _loc2_ = findItemToReplace(param1);
            if(_loc2_ != null)
            {
               _loc2_.remove();
            }
         }
         var _loc5_:String = param1.style.customLayout == null ? "layout_notification_xml" : param1.style.customLayout;
         var _loc4_:String = param1.style.customView;
         var _loc6_:Map = _loc4_ == null ? _viewConfig["view"] : _viewConfig[_loc4_];
         var _loc3_:HabboNotificationItemView = new HabboNotificationItemView(_notifications.localization,UnknownVarFromHabboNotificationViewManager_IAssetLibraryCollection_1.getAssetByName(_loc5_),_windowManager,_styleConfig,_loc6_,param1);
         _loc3_.reposition(getNextAvailableVerticalPosition());
         _viewItems.push(_loc3_);
         _viewItems.sortOn("verticalPosition",16);
         return true;
      }
      
      public function isSpaceAvailable() : Boolean
      {
         return getNextAvailableVerticalPosition() + 70 < _windowManager.getDesktop(0).height;
      }
      
      public function hasNotificationId(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         for each(var _loc2_ in _viewItems)
         {
            if(_loc2_.notificationId == param1 && !_loc2_.readyOrFading)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeNotificationById(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_ in _viewItems)
         {
            if(_loc2_.notificationId == param1)
            {
               _loc2_.remove();
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:HabboNotificationItemView = null;
         var _loc3_:int = 0;
         updateVerticalTargets();
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            (_viewItems[_loc3_] as HabboNotificationItemView).update(param1);
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            _loc2_ = _viewItems[_loc3_] as HabboNotificationItemView;
            if(_loc2_.ready)
            {
               _loc2_.dispose();
               _viewItems.splice(_loc3_,1);
               _loc3_--;
            }
            _loc3_++;
         }
      }
      
      private function countVisibleItems() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _viewItems)
         {
            if(!_loc2_.readyOrFading)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      private function getDuplicateFadeThreshold() : int
      {
         var _loc1_:int = getVisibleCapacity();
         if(_loc1_ <= 0)
         {
            return 2147483647;
         }
         return Math.max(4,_loc1_ * 0.65);
      }
      
      private function getVisibleCapacity() : int
      {
         if(_windowManager == null || _toolbar == null || _toolbar.extensionView == null)
         {
            return 0;
         }
         var _loc1_:int = _toolbar.extensionView.screenHeight + 4;
         var _loc4_:int = int(_windowManager.getDesktop(0).height);
         var _loc2_:int = _loc4_ - _loc1_;
         if(_loc2_ <= 0)
         {
            return 0;
         }
         var _loc3_:int = int(_viewConfig["view"]["height"]);
         if(_loc3_ <= 0)
         {
            _loc3_ = 70;
         }
         return Math.max(0,int((_loc2_ + 4) / (_loc3_ + 4)));
      }
      
      private function findItemToReplace(param1:HabboNotificationItem) : HabboNotificationItemView
      {
         var _loc2_:Set = new Set();
         findAllItemsToReplace(param1,_viewItems.length - 1,_loc2_);
         for each(var _loc3_ in _viewItems)
         {
            if(_loc2_.contains(_loc3_))
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function findAllItemsToReplace(param1:HabboNotificationItem, param2:int, param3:Set) : void
      {
         var _loc4_:HabboNotificationItemView = null;
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ <= param2)
         {
            _loc4_ = _viewItems[_loc5_] as HabboNotificationItemView;
            if(!_loc4_.readyOrFading && _loc4_.styleName == param1.style.styleName && _loc4_.content == param1.content && !_loc4_.staysVisible)
            {
               param3.add(_loc4_);
               break;
            }
            _loc5_ += 1;
         }
         if(param2 >= 2)
         {
            findAllItemsToReplace(_viewItems[param2].item,param2 - 1,param3);
            return;
         }
         if(param3.isEmpty())
         {
            _loc5_ = 0;
            while(_loc5_ < _viewItems.length)
            {
               _loc4_ = _viewItems[_loc5_] as HabboNotificationItemView;
               if(!_loc4_.readyOrFading && !_loc4_.staysVisible)
               {
                  param3.add(_loc4_);
               }
               _loc5_++;
            }
         }
      }
      
      private function updateVerticalTargets() : void
      {
         var _loc3_:int = 0;
         var _loc1_:HabboNotificationItemView = null;
         if(!_toolbar || !_toolbar.extensionView)
         {
            return;
         }
         var _loc2_:int = _toolbar.extensionView.screenHeight + 4;
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            _loc1_ = _viewItems[_loc3_] as HabboNotificationItemView;
            if(!_loc1_.readyOrFading)
            {
               _loc1_.setVerticalTarget(_loc2_);
               _loc2_ += _loc1_.height + 4;
            }
            _loc3_++;
         }
      }
      
      private function getNextAvailableVerticalPosition() : int
      {
         var _loc3_:int = 0;
         var _loc1_:HabboNotificationItemView = null;
         if(!_toolbar)
         {
            return 4;
         }
         if(!_toolbar.extensionView)
         {
            return 4;
         }
         var _loc2_:int = _toolbar.extensionView.screenHeight + 4;
         if(_viewItems.length == 0)
         {
            return _loc2_;
         }
         var _loc4_:* = _loc2_;
         _loc3_ = 0;
         while(_loc3_ < _viewItems.length)
         {
            _loc1_ = _viewItems[_loc3_] as HabboNotificationItemView;
            if(_loc4_ + _loc1_.height < _loc1_.verticalPosition)
            {
               return _loc4_;
            }
            _loc4_ = _loc1_.verticalPosition + _loc1_.height + 4;
            _loc3_++;
         }
         return _loc4_;
      }
      
      public function refreshTopMargin(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc2_:HabboNotificationItemView = null;
         var _loc3_:int = _toolbar.extensionView.screenHeight + 4;
         _loc4_ = 0;
         while(_loc4_ < _viewItems.length)
         {
            _loc2_ = _viewItems[_loc4_] as HabboNotificationItemView;
            _loc2_.reposition(_loc3_);
            _loc3_ = _loc2_.verticalPosition + _loc2_.height + 4;
            _loc4_++;
         }
      }
   }
}

