package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   
   public class StartPanelCtrl implements IComponentInterfaceQueue
   {
      private var _main:ModerationManager;
      
      private var _frame:IFrameController;
      
      private var UnknownVarFromStartPanelCtrl_Int_1:int;
      
      private var _isGuestRoom:Boolean;
      
      private var UnknownVarFromStartPanelCtrl_Int_2:int;
      
      private var _disposed:Boolean = false;
      
      public function StartPanelCtrl(param1:ModerationManager)
      {
         super();
         _main = param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _main = null;
            if(_frame)
            {
               _frame.dispose();
               _frame = null;
            }
         }
      }
      
      public function userSelected(param1:int, param2:String) : void
      {
         if(_frame == null)
         {
            return;
         }
         UnknownVarFromStartPanelCtrl_Int_1 = param1;
         _frame.findChildByName("userinfo_but").enable();
         (IWindowController_1(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         IWindowController_1(_frame.findChildByName("userinfo_but")).findChildByName("offence_name").caption = "User info: " + param2;
      }
      
      public function guestRoomEntered(param1:RoomEntryInfoMessageParser) : void
      {
         if(_frame == null || param1 == null)
         {
            return;
         }
         _frame.findChildByName("room_tool_but").enable();
         (IWindowController_1(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         enableChatlogButton();
         _isGuestRoom = true;
         UnknownVarFromStartPanelCtrl_Int_2 = param1.guestRoomId;
      }
      
      public function roomExited() : void
      {
         if(_frame == null)
         {
            return;
         }
         _frame.findChildByName("room_tool_but").disable();
         _frame.findChildByName("chatlog_but").disable();
      }
      
      public function show() : void
      {
         if(_frame == null)
         {
            _frame = IFrameController(_main.getXmlWindow("start_panel"));
            _frame.findChildByName("room_tool_but").addEventListener("WME_CLICK",onRoomToolButton);
            _frame.findChildByName("chatlog_but").addEventListener("WME_CLICK",onChatlogButton);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_CLICK",onTicketQueueButton);
            _frame.findChildByName("userinfo_but").addEventListener("WME_CLICK",onUserinfoButton);
            _frame.findChildByName("room_tool_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("chatlog_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("userinfo_but").addEventListener("WME_OVER",onMouseOver);
            _frame.findChildByName("room_tool_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("chatlog_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("ticket_queue_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("userinfo_but").addEventListener("WME_OUT",onMouseOut);
            _frame.findChildByName("userinfo_but").disable();
            _frame.findChildByName("room_tool_but").disable();
            _frame.findChildByName("chatlog_but").disable();
            _main.initMsg.cfhPermission ? null : _frame.findChildByName("ticket_queue_but").disable();
            _main.initMsg.chatlogsPermission ? null : _frame.findChildByName("chatlog_but").disable();
            (IWindowController_1(_frame.findChildByName("userinfo_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
            (IWindowController_1(_frame.findChildByName("room_tool_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
            (IWindowController_1(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 6710886;
         }
         _frame.visible = true;
      }
      
      private function enableChatlogButton() : void
      {
         if(_main.initMsg.chatlogsPermission)
         {
            _frame.findChildByName("chatlog_but").enable();
            (IWindowController_1(_frame.findChildByName("chatlog_but")).findChildByName("offence_name") as ILabelWindow).textColor = 0;
         }
      }
      
      private function onMouseOver(param1:WindowEvent) : void
      {
         if(!param1.window.isEnabled())
         {
            return;
         }
         (param1.window as IWindowController_1).findChildByName("mouseover").visible = true;
      }
      
      private function onMouseOut(param1:WindowEvent) : void
      {
         (param1.window as IWindowController_1).findChildByName("mouseover").visible = false;
      }
      
      private function onRoomToolButton(param1:WindowEvent) : void
      {
         _main.windowTracker.show(new RoomToolCtrl(_main,UnknownVarFromStartPanelCtrl_Int_2),_frame,false,false,true);
      }
      
      private function onChatlogButton(param1:WindowEvent) : void
      {
         _main.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(_isGuestRoom ? 0 : 1,UnknownVarFromStartPanelCtrl_Int_2),_main,4,UnknownVarFromStartPanelCtrl_Int_2),_frame,false,false,true);
      }
      
      private function onUserinfoButton(param1:WindowEvent) : void
      {
         _main.windowTracker.show(new UserInfoFrameCtrl(_main,UnknownVarFromStartPanelCtrl_Int_1),_frame,false,false,true);
      }
      
      private function onTicketQueueButton(param1:WindowEvent) : void
      {
         _main.issueManager.init();
      }
   }
}

