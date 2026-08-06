package com.sulake.habbo.ui.widget.roomqueue
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class RoomQueueWidget extends RoomWidgetBase
   {
      private var _window:IFrameController;
      
      private var _config:IComponent_1;
      
      private var UnknownVarFromRoomQueueWidget_Int_1:int;
      
      private var UnknownVarFromRoomQueueWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromRoomQueueWidget_String_1:String;
      
      private var UnknownVarFromRoomQueueWidget_Boolean_2:Boolean;
      
      public function RoomQueueWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1)
      {
         super(param1,param2,param3,param4);
         _config = param5;
      }
      
      override public function dispose() : void
      {
         removeWindow();
         _config = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.addEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWRQUE_VISITOR_QUEUE_STATUS",onQueueStatus);
         param1.removeEventListener("RWRQUE_SPECTATOR_QUEUE_STATUS",onQueueStatus);
      }
      
      private function removeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onQueueStatus(param1:RoomWidgetRoomQueueUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.isActive)
         {
            UnknownVarFromRoomQueueWidget_String_1 = param1.type;
            UnknownVarFromRoomQueueWidget_Int_1 = param1.position;
         }
         UnknownVarFromRoomQueueWidget_Boolean_1 = param1.hasHabboClub;
         UnknownVarFromRoomQueueWidget_Boolean_2 = param1.isClubQueue;
         localizations.registerParameter("room.queue.position","position",UnknownVarFromRoomQueueWidget_Int_1.toString());
         localizations.registerParameter("room.queue.position.hc","position",UnknownVarFromRoomQueueWidget_Int_1.toString());
         localizations.registerParameter("room.queue.spectator.position","position",UnknownVarFromRoomQueueWidget_Int_1.toString());
         localizations.registerParameter("room.queue.spectator.position.hc","position",UnknownVarFromRoomQueueWidget_Int_1.toString());
         showInterface();
      }
      
      private function createWindow() : Boolean
      {
         if(_window != null)
         {
            return true;
         }
         var _loc2_:XmlAsset = assets.getAssetByName("room_queue") as XmlAsset;
         _window = windowManager.buildFromXML(_loc2_.content as XML) as IFrameController;
         if(_window == null)
         {
            return false;
         }
         _window.visible = false;
         var _loc1_:IWindowModel = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("cancel_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",exitQueue);
         }
         _loc1_ = _window.findChildByName("link_text");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",openLink);
         }
         _loc1_ = _window.findChildByName("change_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",changeQueue);
         }
         return true;
      }
      
      private function showInterface() : void
      {
         if(!createWindow())
         {
            return;
         }
         var _loc2_:ITextWindow = _window.findChildByName("info_text") as ITextWindow;
         if(_loc2_ != null)
         {
            switch(UnknownVarFromRoomQueueWidget_String_1)
            {
               case "RWRQUE_VISITOR_QUEUE_STATUS":
                  _loc2_.caption = UnknownVarFromRoomQueueWidget_Boolean_2 ? "${room.queue.position.hc}" : "${room.queue.position}";
                  break;
               case "RWRQUE_SPECTATOR_QUEUE_STATUS":
                  _loc2_.caption = UnknownVarFromRoomQueueWidget_Boolean_2 ? "${room.queue.spectator.position.hc}" : "${room.queue.spectator.position}";
            }
         }
         var _loc1_:IWindowController_1 = _window.findChildByName("club_container") as IWindowController_1;
         if(_loc1_ != null)
         {
            _loc1_.visible = !UnknownVarFromRoomQueueWidget_Boolean_1;
         }
         _window.visible = true;
      }
      
      private function exitQueue(param1:WindowMouseEvent) : void
      {
         if(messageListener == null)
         {
            return;
         }
         var _loc2_:RoomWidgetRoomQueueMessage = new RoomWidgetRoomQueueMessage("RWRQM_EXIT_QUEUE");
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
      
      private function openLink(param1:WindowMouseEvent) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetRoomQueueMessage("RWRQM_CLUB_LINK"));
      }
      
      private function changeQueue(param1:WindowMouseEvent) : void
      {
         var _loc2_:RoomWidgetRoomQueueMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(UnknownVarFromRoomQueueWidget_String_1 == "RWRQUE_VISITOR_QUEUE_STATUS")
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
         }
         else
         {
            _loc2_ = new RoomWidgetRoomQueueMessage("RWRQM_CHANGE_TO_VISITOR_QUEUE");
         }
         messageListener.processWidgetMessage(_loc2_);
         removeWindow();
      }
   }
}

