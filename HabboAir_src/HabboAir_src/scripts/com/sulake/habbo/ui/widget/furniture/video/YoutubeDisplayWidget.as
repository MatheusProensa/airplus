package com.sulake.habbo.ui.widget.furniture.video
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylist;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureYoutubeDisplayWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class YoutubeDisplayWidget extends RoomWidgetBase
   {
      private static const UnknownConstFromYoutubeDisplayWidget_Uint_1:uint = 4291611903;
      
      private static const UnknownConstFromYoutubeDisplayWidget_Uint_2:uint = 4294967295;
      
      private var _habboTracking:IHabboTracking;
      
      private var UnknownVarFromYoutubeDisplayWidget_Object_1:Object;
      
      private var _window:IWindowController_1;
      
      private var _roomObject:IRoomObject;
      
      private var UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromYoutubeDisplayWidget_IWindowModel_1:IWindowModel;
      
      private var _queuedVideoParams:Object;
      
      private var UnknownVarFromYoutubeDisplayWidget_String_1:String;
      
      private var _canControlPlayback:Boolean;
      
      private var UnknownVarFromYoutubeDisplayWidget_Int_1:int = -1;
      
      public function YoutubeDisplayWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IHabboTracking)
      {
         super(param1,param2,param3,param4);
         _habboTracking = param5;
         ownHandler.widget = this;
      }
      
      private function get ownHandler() : FurnitureYoutubeDisplayWidgetHandler
      {
         return _widgetHandler as FurnitureYoutubeDisplayWidgetHandler;
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _window;
      }
      
      public function show(param1:IRoomObject, param2:Boolean) : void
      {
         _roomObject = param1;
         _canControlPlayback = param2;
         createWindow(param2);
         _window.visible = true;
      }
      
      private function createWindow(param1:Boolean) : void
      {
         if(_window != null)
         {
            return;
         }
         _window = windowManager.buildFromXML(XML(assets.getAssetByName("video_viewer_xml").content)) as IWindowController_1;
         if(param1)
         {
            UnknownVarFromYoutubeDisplayWidget_IWindowModel_1 = IItemListWindow(_window.findChildByName("playlists")).removeListItemAt(0);
         }
         else
         {
            _window.findChildByName("right_pane").dispose();
            _window.findChildByName("video_background").width = _window.width - 20;
            _window.findChildByName("video_background").setParamFlag(128);
            _window.width -= 250;
         }
         _window.procedure = windowProcedure;
         _window.center();
      }
      
      private function onPlayerLoaderInit(param1:Event) : void
      {
         var _loc2_:Loader = null;
         if(_window == null)
         {
            return;
         }
         var _loc3_:LoaderInfo = param1.target as LoaderInfo;
         if(_loc3_)
         {
            _loc2_ = _loc3_.loader;
            IDisplayObjectWrapperController(_window.findChildByName("video_wrapper")).setDisplayObject(_loc2_);
            _loc2_.content.addEventListener("onReady",onPlayerReady);
            _loc2_.content.addEventListener("onStateChange",onPlayerStateChange);
            _loc2_.content.addEventListener("mouseUp",onVideoMouseEvent);
            _loc2_.content.addEventListener("mouseMove",onVideoMouseEvent);
         }
      }
      
      private function onVideoMouseEvent(param1:MouseEvent) : void
      {
         if(_window != null && _canControlPlayback)
         {
            DisplayObject(param1.target).stage.dispatchEvent(new MouseEvent(param1.type));
            if(UnknownVarFromYoutubeDisplayWidget_Object_1 && param1.type == "mouseUp" && UnknownVarFromYoutubeDisplayWidget_String_1 != "")
            {
               if(UnknownVarFromYoutubeDisplayWidget_Object_1.getPlayerState() == 1)
               {
                  ownHandler.pauseVideo(_roomObject.getId());
               }
               else if(UnknownVarFromYoutubeDisplayWidget_Object_1.getPlayerState() == 2)
               {
                  ownHandler.continueVideo(_roomObject.getId());
               }
            }
         }
      }
      
      private function onPlayerReady(param1:Event) : void
      {
         var _loc2_:IWindowModel = null;
         UnknownVarFromYoutubeDisplayWidget_Object_1 = param1.target;
         if(_window != null)
         {
            _loc2_ = _window.findChildByName("video_wrapper");
            UnknownVarFromYoutubeDisplayWidget_Object_1.setSize(_loc2_.width,_loc2_.height);
            if(_queuedVideoParams != null)
            {
               loadVideo(_queuedVideoParams);
               _queuedVideoParams = null;
            }
         }
         else
         {
            UnknownVarFromYoutubeDisplayWidget_Object_1.destroy();
         }
      }
      
      private function onPlayerStateChange(param1:Event) : void
      {
         UnknownVarFromYoutubeDisplayWidget_Object_1 = param1.target;
         if(_window != null)
         {
            switch(UnknownVarFromYoutubeDisplayWidget_Object_1.getPlayerState())
            {
               case -1:
               case 1:
                  if(UnknownVarFromYoutubeDisplayWidget_Int_1 == 2)
                  {
                     UnknownVarFromYoutubeDisplayWidget_Object_1.pauseVideo();
                  }
            }
         }
      }
      
      public function hide(param1:IRoomObject) : void
      {
         if(_roomObject != param1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromYoutubeDisplayWidget_IWindowModel_1 != null)
         {
            UnknownVarFromYoutubeDisplayWidget_IWindowModel_1.dispose();
            UnknownVarFromYoutubeDisplayWidget_IWindowModel_1 = null;
         }
         if(UnknownVarFromYoutubeDisplayWidget_Object_1 != null)
         {
            UnknownVarFromYoutubeDisplayWidget_Object_1.destroy();
            UnknownVarFromYoutubeDisplayWidget_Object_1 = null;
         }
         if(UnknownVarFromYoutubeDisplayWidget_String_1 != null)
         {
            _habboTracking.trackEventLog("YouTubeTVs",UnknownVarFromYoutubeDisplayWidget_String_1,"video.closed");
         }
         _queuedVideoParams = null;
         UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 = null;
         _roomObject = null;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide(_roomObject);
         _habboTracking = null;
         super.dispose();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:IWindowModel = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:IWindowModel = null;
         var _loc9_:IItemListWindow = null;
         var _loc7_:int = 0;
         var _loc4_:IWindowController_1 = null;
         switch(param1.type)
         {
            case "WME_CLICK":
               switch(param2.name)
               {
                  case "header_button_close":
                     hide(_roomObject);
                     break;
                  case "playlist_prev":
                     ownHandler.switchToPreviousVideo(_roomObject.getId());
                     break;
                  case "playlist_next":
                     ownHandler.switchToNextVideo(_roomObject.getId());
                     break;
                  default:
                     if(param2 is IRegionWindow)
                     {
                        if(UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 != null)
                        {
                           UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1.findChildByName("item_background").color = 4294967295;
                        }
                        if(UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 == param2)
                        {
                           UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 = null;
                           ownHandler.selectPlaylist(_roomObject.getId(),"");
                        }
                        else
                        {
                           UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 = param2 as IWindowController_1;
                           UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1.findChildByName("item_background").color = 4291611903;
                           ownHandler.selectPlaylist(_roomObject.getId(),UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1.name);
                        }
                        updateButtons();
                     }
               }
               break;
            case "WE_RESIZE":
               switch(param2.name)
               {
                  case "video_viewer":
                     if(_window != null)
                     {
                        _loc5_ = _window.findChildByName("right_pane");
                        if(_loc5_ != null)
                        {
                           _loc6_ = _window.width - 29;
                           _loc3_ = _loc6_ * 0.66;
                           _loc8_ = _window.findChildByName("video_background");
                           _loc8_.width = _loc3_;
                           _loc5_.x = _loc8_.right + 9;
                           _loc5_.width = _loc6_ - _loc3_;
                        }
                     }
                     break;
                  case "playlists":
                     _loc9_ = param2 as IItemListWindow;
                     if(_loc9_ != null)
                     {
                        _loc7_ = 0;
                        while(_loc7_ < _loc9_.numListItems)
                        {
                           _loc4_ = _loc9_.getListItemAt(_loc7_) as IWindowController_1;
                           _loc4_.findChildByName("item_background").width = _loc9_.width;
                           _loc4_.findChildByName("item_contents").width = _loc9_.width;
                           _loc4_.findChildByName("item_description").width = _loc9_.width - 22;
                           _loc7_++;
                        }
                     }
                     break;
                  case "video_wrapper":
                     if(UnknownVarFromYoutubeDisplayWidget_Object_1 != null)
                     {
                        UnknownVarFromYoutubeDisplayWidget_Object_1.setSize(param2.width,param2.height);
                     }
               }
         }
      }
      
      public function showVideo(param1:int, param2:String, param3:int, param4:int, param5:int) : void
      {
         if(_roomObject == null || _roomObject.getId() != param1)
         {
            return;
         }
         var _loc6_:Object = param3 > 0 || param4 > 0 ? {
            "videoId":param2,
            "startSeconds":param3,
            "endSeconds":param4,
            "suggestedQuality":"large"
         } : {
            "videoId":param2,
            "suggestedQuality":"large"
         };
         if(UnknownVarFromYoutubeDisplayWidget_Object_1 != null)
         {
            loadVideo(_loc6_);
            _queuedVideoParams = null;
         }
         else
         {
            _queuedVideoParams = _loc6_;
         }
         UnknownVarFromYoutubeDisplayWidget_Int_1 = param5;
      }
      
      public function controlVideo(param1:int, param2:int) : void
      {
         if(_roomObject == null || _roomObject.getId() != param1)
         {
            return;
         }
         if(_window != null)
         {
            if(UnknownVarFromYoutubeDisplayWidget_Object_1)
            {
               switch(param2 - 1)
               {
                  case 0:
                     UnknownVarFromYoutubeDisplayWidget_Int_1 = 1;
                     UnknownVarFromYoutubeDisplayWidget_Object_1.playVideo();
                     break;
                  case 1:
                     UnknownVarFromYoutubeDisplayWidget_Int_1 = 2;
                     UnknownVarFromYoutubeDisplayWidget_Object_1.pauseVideo();
               }
            }
         }
      }
      
      private function loadVideo(param1:Object) : void
      {
         UnknownVarFromYoutubeDisplayWidget_String_1 = param1.videoId;
         var _loc2_:* = UnknownVarFromYoutubeDisplayWidget_String_1 != "";
         if(_loc2_)
         {
            UnknownVarFromYoutubeDisplayWidget_Object_1.loadVideoById(param1);
            _habboTracking.trackEventLog("YouTubeTVs",UnknownVarFromYoutubeDisplayWidget_String_1,"video.started");
         }
         else
         {
            UnknownVarFromYoutubeDisplayWidget_Object_1.stopVideo();
         }
         if(_window != null)
         {
            _window.findChildByName("no_videos_label").visible = !_loc2_;
            _window.findChildByName("video_wrapper").visible = _loc2_;
         }
      }
      
      public function populatePlaylists(param1:int, param2:Vector.<YoutubeDisplayPlaylist>, param3:String) : void
      {
         var _loc4_:IWindowController_1 = null;
         if(_roomObject == null || _roomObject.getId() != param1 || _window == null || UnknownVarFromYoutubeDisplayWidget_IWindowModel_1 == null)
         {
            return;
         }
         var _loc6_:IItemListWindow = _window.findChildByName("playlists") as IItemListWindow;
         if(_loc6_ == null)
         {
            return;
         }
         _loc6_.destroyListItems();
         UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 = null;
         for each(var _loc5_ in param2)
         {
            _loc4_ = UnknownVarFromYoutubeDisplayWidget_IWindowModel_1.clone() as IWindowController_1;
            _loc4_.name = _loc5_.playlistId;
            _loc4_.findChildByName("item_background").width = _loc6_.width;
            if(_loc5_.playlistId == param3)
            {
               _loc4_.findChildByName("item_background").color = 4291611903;
               UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 = _loc4_;
            }
            _loc4_.findChildByName("item_contents").width = _loc6_.width;
            _loc4_.findChildByName("item_title").caption = _loc5_.title;
            _loc4_.findChildByName("item_description").caption = _loc5_.description.replace(/\r/g,"");
            _loc4_.findChildByName("item_description").width = _loc6_.width - 22;
            _loc6_.addListItem(_loc4_);
         }
         updateButtons();
      }
      
      private function updateButtons() : void
      {
         if(_window == null)
         {
            return;
         }
         if(UnknownVarFromYoutubeDisplayWidget_IWindowController_1_1 != null)
         {
            _window.findChildByName("playlist_prev").enable();
            _window.findChildByName("playlist_next").enable();
         }
         else
         {
            _window.findChildByName("playlist_prev").disable();
            _window.findChildByName("playlist_next").disable();
         }
      }
   }
}

