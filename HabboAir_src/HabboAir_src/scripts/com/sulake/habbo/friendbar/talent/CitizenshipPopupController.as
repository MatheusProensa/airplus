package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CitizenshipPopupController implements IComponentInterfaceQueue
   {
      private var _habboTalent:HabboTalent;
      
      private var UnknownVarFromCitizenshipPopupController_IModalDialog_1:IModalDialog;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromCitizenshipPopupController_RoomEntryInfoMessageEvent_1:RoomEntryInfoMessageEvent;
      
      private var UnknownVarFromCitizenshipPopupController_Boolean_1:Boolean;
      
      public function CitizenshipPopupController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
         UnknownVarFromCitizenshipPopupController_RoomEntryInfoMessageEvent_1 = new RoomEntryInfoMessageEvent(onRoomEnter);
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(UnknownVarFromCitizenshipPopupController_RoomEntryInfoMessageEvent_1);
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         var _loc2_:Timer = null;
         if(_habboTalent.newIdentity && !UnknownVarFromCitizenshipPopupController_Boolean_1 && _habboTalent.getBoolean("new.user.citizenship.popup.enabled"))
         {
            _loc2_ = new Timer(10000,1);
            _loc2_.addEventListener("timer",onCitizenshipPopup);
            _loc2_.start();
         }
      }
      
      private function onCitizenshipPopup(param1:TimerEvent) : void
      {
         removeRoomEnterListener();
         show();
         UnknownVarFromCitizenshipPopupController_Boolean_1 = true;
      }
      
      private function removeRoomEnterListener() : void
      {
         if(_habboTalent != null && !_habboTalent.disposed)
         {
            _habboTalent.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromCitizenshipPopupController_RoomEntryInfoMessageEvent_1);
         }
         UnknownVarFromCitizenshipPopupController_RoomEntryInfoMessageEvent_1 = null;
      }
      
      public function show() : void
      {
         hide();
         UnknownVarFromCitizenshipPopupController_IModalDialog_1 = _habboTalent.getModalXmlWindow("citizenship_welcome");
         UnknownVarFromCitizenshipPopupController_IModalDialog_1.rootWindow.procedure = onWindowEvent;
         IWindowController_1(UnknownVarFromCitizenshipPopupController_IModalDialog_1.rootWindow).findChildByName("header_button_close").visible = false;
      }
      
      private function hide() : void
      {
         if(UnknownVarFromCitizenshipPopupController_IModalDialog_1 != null && !UnknownVarFromCitizenshipPopupController_IModalDialog_1.disposed)
         {
            UnknownVarFromCitizenshipPopupController_IModalDialog_1.dispose();
            UnknownVarFromCitizenshipPopupController_IModalDialog_1 = null;
         }
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            hide();
            removeRoomEnterListener();
            _habboTalent = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(UnknownVarFromCitizenshipPopupController_IModalDialog_1 == null || Boolean(UnknownVarFromCitizenshipPopupController_IModalDialog_1.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "postpone_citizenship":
               hide();
               break;
            case "show_citizenship":
               hide();
               _habboTalent.tracking.trackTalentTrackOpen("citizenship","citizenshippopup");
               _habboTalent.send(new GetTalentTrackMessageComposer("citizenship"));
         }
      }
   }
}

