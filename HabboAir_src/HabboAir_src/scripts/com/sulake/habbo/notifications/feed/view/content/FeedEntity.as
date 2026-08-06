package com.sulake.habbo.notifications.feed.view.content
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.feed.NotificationController;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class FeedEntity implements IFeedEntity
   {
      public static var UnknownConstFromWindowParser_String_2:IWindowController_1;
      
      public static var UnknownVarFromFeedEntity_IHabboLocalizationManager_1:IHabboLocalizationManager;
      
      public static var ASSETS:IAssetLibraryCollection;
      
      public static var FEED_CONTROLLER:NotificationController;
      
      protected static const LIST:String = "content_list";
      
      protected static const TITLE:String = "title";
      
      protected static const MESSAGE:String = "message";
      
      protected static const TIME:String = "time";
      
      protected static const ICON:String = "icon";
      
      protected static const DECORATION:String = "decoration";
      
      protected static const ACTION_BUTTON:String = "action_button";
      
      protected static const UNIT_MINUTES:String = "minutes";
      
      protected static const UNIT_HOURS:String = "hours";
      
      protected static const UnknownConstFromFeedEntity_String_1:String = "days";
      
      private static const BUTTON_HEIGHT:int = 25;
      
      private static const UnknownConstFromFeedEntity_Vector_1:Vector.<FeedEntity> = new Vector.<FeedEntity>();
      
      protected var _window:IWindowController_1;
      
      protected var _disposed:Boolean = false;
      
      protected var _recycled:Boolean = false;
      
      protected var _id:int = -1;
      
      protected var _minutesElapsed:int;
      
      protected var _iconFilePath:String;
      
      protected var _decorationFilePath:String;
      
      protected var UnknownVarFromFeedEntity_String_1:String;
      
      public function FeedEntity()
      {
         super();
         _window = UnknownConstFromWindowParser_String_2.clone() as IWindowController_1;
      }
      
      public static function assignHandles(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection, param3:IHabboLocalizationManager, param4:NotificationController) : void
      {
         UnknownConstFromWindowParser_String_2 = param1.buildFromXML(param2.getAssetByName("feed_entity_xml").content as XML) as IWindowController_1;
         ASSETS = param2;
         UnknownVarFromFeedEntity_IHabboLocalizationManager_1 = param3;
         FEED_CONTROLLER = param4;
      }
      
      public static function removeHandles() : void
      {
         if(UnknownConstFromWindowParser_String_2)
         {
            UnknownConstFromWindowParser_String_2.dispose();
            UnknownConstFromWindowParser_String_2 = null;
         }
         ASSETS = null;
         UnknownVarFromFeedEntity_IHabboLocalizationManager_1 = null;
         FEED_CONTROLLER = null;
      }
      
      public static function allocate() : FeedEntity
      {
         var _loc1_:FeedEntity = UnknownConstFromFeedEntity_Vector_1.length > 0 ? UnknownConstFromFeedEntity_Vector_1.pop() : new FeedEntity();
         _loc1_._recycled = false;
         return _loc1_;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set title(param1:String) : void
      {
         _window.findChildByName("title").caption = !!param1 ? param1 : "";
      }
      
      public function get title() : String
      {
         return !!_window ? _window.findChildByName("title").caption : null;
      }
      
      public function set message(param1:String) : void
      {
         _window.findChildByName("message").caption = !!param1 ? param1 : "";
      }
      
      public function get message() : String
      {
         return !!_window ? _window.findChildByName("message").caption : null;
      }
      
      public function setButton(param1:String, param2:String) : void
      {
         if(!_window)
         {
            return;
         }
         UnknownVarFromFeedEntity_String_1 = param1;
         var _loc3_:UnknownICoreWindowComponents4 = _window.findChildByName("action_button") as UnknownICoreWindowComponents4;
         if(UnknownVarFromFeedEntity_String_1 == null)
         {
            _loc3_.height = 0;
         }
         else
         {
            _loc3_.height = 25;
            _loc3_.caption = param2;
            _loc3_.addEventListener("WME_CLICK",onActionButton);
         }
      }
      
      public function set iconFilePath(param1:String) : void
      {
         var _loc2_:ISoundAsset = null;
         if(!param1)
         {
            return;
         }
         if(param1 != _iconFilePath)
         {
            _iconFilePath = param1;
            _loc2_ = ASSETS.getAssetByName(param1);
            if(_loc2_)
            {
               icon = _loc2_.content as BitmapData;
            }
            else
            {
               loadImageUrl(param1);
            }
         }
      }
      
      public function set decorationFilePath(param1:String) : void
      {
         var _loc2_:ISoundAsset = null;
         if(!param1)
         {
            return;
         }
         if(param1 != _decorationFilePath)
         {
            _decorationFilePath = param1;
            _loc2_ = ASSETS.getAssetByName(param1);
            if(_loc2_)
            {
               decoration = _loc2_.content as BitmapData;
            }
            else
            {
               loadImageUrl(param1);
            }
         }
      }
      
      public function set icon(param1:BitmapData) : void
      {
         if(disposed || !_window)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("icon") as IBitmapWrapperController;
         updateImage(_loc2_,param1);
         _iconFilePath = null;
      }
      
      public function set decoration(param1:BitmapData) : void
      {
         if(disposed || !_window)
         {
            return;
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("decoration") as IBitmapWrapperController;
         updateImage(_loc2_,param1);
         _decorationFilePath = null;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get recycled() : Boolean
      {
         return _recycled;
      }
      
      public function set minutesElapsed(param1:int) : void
      {
         var _loc4_:ITextWindow = _window.findChildByName("time") as ITextWindow;
         if(param1 < 0)
         {
            _loc4_.height = 0;
            return;
         }
         _minutesElapsed = param1;
         var _loc3_:String = "minutes";
         if(_minutesElapsed >= 1440)
         {
            _loc3_ = "days";
            param1 /= 1440;
         }
         else if(_minutesElapsed >= 60)
         {
            _loc3_ = "hours";
            param1 /= 60;
         }
         var _loc2_:ILocalization = UnknownVarFromFeedEntity_IHabboLocalizationManager_1.getLocalizationRaw("friendbar.stream." + _loc3_ + ".ago");
         _loc4_.caption = !!_loc2_ ? _loc2_.raw.replace("%value%",String(param1)) : "...?";
      }
      
      public function get minutesElapsed() : int
      {
         return _minutesElapsed;
      }
      
      public function updateContainerSize() : void
      {
         if(!_window || disposed)
         {
            return;
         }
         var _loc2_:IItemListWindow = _window.findChildByName("content_list") as IItemListWindow;
         var _loc1_:IWindowModel = _loc2_.getListItemAt(_loc2_.numListItems - 1) as IWindowModel;
         _loc2_.height = !!_loc1_ ? _loc1_.y + _loc1_.height : 0;
      }
      
      public function recycle() : void
      {
         if(!_recycled)
         {
            if(!_disposed)
            {
               _window.parent = null;
               IBitmapWrapperController(_window.findChildByName("decoration")).bitmap = null;
               IBitmapWrapperController(_window.findChildByName("icon")).bitmap = null;
               (_window.findChildByName("action_button") as UnknownICoreWindowComponents4).removeEventListener("WME_CLICK",onActionButton);
               _decorationFilePath = null;
               _recycled = true;
               UnknownConstFromFeedEntity_Vector_1.push(this);
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window)
            {
               _window.dispose();
               _window = null;
            }
            if(_recycled)
            {
               UnknownConstFromFeedEntity_Vector_1.splice(UnknownConstFromFeedEntity_Vector_1.indexOf(this),1);
               _recycled = false;
            }
            _disposed = true;
         }
      }
      
      protected function onActionButton(param1:WindowMouseEvent) : void
      {
         FEED_CONTROLLER.executeAction(UnknownVarFromFeedEntity_String_1);
      }
      
      private function updateImage(param1:IBitmapWrapperController, param2:BitmapData) : void
      {
         if(param2 == null)
         {
            param1.bitmap = null;
            param1.height = 0;
            return;
         }
         var _loc4_:Number = param1.x + param1.width / 2;
         var _loc3_:Number = param1.y + param1.height / 2;
         param1.bitmap = param2;
         param1.x = _loc4_ - param2.width / 2;
         param1.y = _loc3_ - param2.height / 2;
         param1.width = param2.width;
         param1.height = param2.height;
      }
      
      private function loadImageUrl(param1:String) : void
      {
         var _loc2_:AssetLoaderStruct = ASSETS.loadAssetFromFile(param1,new URLRequest(param1));
         _loc2_.addEventListener("AssetLoaderEventComplete",onImageFileLoaded);
         _loc2_.addEventListener("AssetLoaderEventError",onImageFileLoaded);
      }
      
      private function onImageFileLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:ISoundAsset = null;
         if(param1.type == "AssetLoaderEventComplete")
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_.assetName == _decorationFilePath)
            {
               _loc3_ = ASSETS.getAssetByName(_decorationFilePath);
               if(_loc3_)
               {
                  decoration = _loc3_.content as BitmapData;
               }
            }
            else if(_loc2_.assetName == _iconFilePath)
            {
               _loc3_ = ASSETS.getAssetByName(_iconFilePath);
               if(_loc3_)
               {
                  icon = _loc3_.content as BitmapData;
               }
            }
            updateContainerSize();
         }
      }
   }
}

