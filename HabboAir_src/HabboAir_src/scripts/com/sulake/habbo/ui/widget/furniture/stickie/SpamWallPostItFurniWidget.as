package com.sulake.habbo.ui.widget.furniture.stickie
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetStickieDataUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class SpamWallPostItFurniWidget extends StickieFurniWidget
   {
      private var UnknownVarFromSpamWallPostItFurniWidget_String_1:String = "";
      
      public function SpamWallPostItFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null)
      {
         _windowName = "spamwall_postit_container";
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         UnknownVarFromStickieFurniWidget_Int_1 = -1;
         UnknownVarFromSpamWallPostItFurniWidget_String_1 = "";
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         param1.addEventListener("RWSWPUE_OPEN_EDITOR",onEditPostItRequest);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWSWPUE_OPEN_EDITOR",onEditPostItRequest);
      }
      
      override protected function onObjectUpdate(param1:RoomWidgetStickieDataUpdateEvent) : void
      {
      }
      
      private function onEditPostItRequest(param1:RoomWidgetSpamWallPostItEditEvent) : void
      {
         hideInterface(false);
         UnknownVarFromStickieFurniWidget_Int_1 = param1.objectId;
         UnknownVarFromSpamWallPostItFurniWidget_String_1 = param1.location;
         UnknownVarFromStickieFurniWidget_String_1 = param1.objectType;
         _text = "";
         UnknownVarFromStickieFurniWidget_String_2 = "FFFF33";
         UnknownVarFromStickieFurniWidget_Boolean_1 = true;
         showInterface();
      }
      
      override protected function sendUpdate() : void
      {
         var _loc1_:RoomWidgetSpamWallPostItFinishEditingMessage = null;
         if(UnknownVarFromStickieFurniWidget_Int_1 != -1)
         {
            storeTextFromField();
            Logger.log("Spamwall Post-It Widget Send Update");
            if(messageListener != null)
            {
               _loc1_ = new RoomWidgetSpamWallPostItFinishEditingMessage("RWSWPFEE_SEND_POSTIT_DATA",UnknownVarFromStickieFurniWidget_Int_1,UnknownVarFromSpamWallPostItFurniWidget_String_1,_text,UnknownVarFromStickieFurniWidget_String_2);
               messageListener.processWidgetMessage(_loc1_);
            }
            hideInterface(false);
         }
      }
      
      override protected function sendSetColor(param1:uint) : void
      {
         storeTextFromField();
         var _loc2_:String = param1.toString(16).toUpperCase();
         if(_loc2_.length > 6)
         {
            _loc2_ = _loc2_.slice(_loc2_.length - 6,_loc2_.length);
         }
         if(_loc2_ == UnknownVarFromStickieFurniWidget_String_2)
         {
            return;
         }
         UnknownVarFromStickieFurniWidget_String_2 = _loc2_;
         showInterface();
      }
      
      override protected function sendDelete() : void
      {
         hideInterface(false);
      }
   }
}

