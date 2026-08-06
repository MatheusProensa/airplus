package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniCancelLockMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniOtherLockConfirmedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendfurni.FriendFurniStartConfirmationMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendfurni.FriendFurniConfirmLockMessageComposer;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class FriendFurniConfirmWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1:FriendFurniConfirmWidget;
      
      private var UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1:IConnection;
      
      private var UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1:IMessageEvent = null;
      
      private var UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_2:IMessageEvent = null;
      
      private var UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_3:IMessageEvent = null;
      
      public function FriendFurniConfirmWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set widget(param1:FriendFurniConfirmWidget) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1 = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1 && UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1)
            {
               UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1);
               UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_2);
               UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_3);
               UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1 = null;
            }
            UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1 = null;
            _container = null;
            _disposed = true;
         }
      }
      
      public function set connection(param1:IConnection) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1 = param1;
         if(!UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1)
         {
            UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1 = new FriendFurniStartConfirmationMessageEvent(onStartConfirmation);
            UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_2 = new FriendFurniOtherLockConfirmedMessageEvent(onOtherLockConfirmed);
            UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_3 = new FriendFurniCancelLockMessageEvent(onCancelLock);
            UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_1);
            UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_2);
            UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromFriendFurniConfirmWidgetHandler_IMessageEvent_3);
         }
      }
      
      public function sendLockConfirm(param1:int, param2:Boolean) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_IConnection_1.send(new FriendFurniConfirmLockMessageComposer(param1,param2));
      }
      
      private function onStartConfirmation(param1:FriendFurniStartConfirmationMessageEvent) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1.open(param1.getParser().stuffId,param1.getParser().isOwner);
      }
      
      private function onOtherLockConfirmed(param1:FriendFurniOtherLockConfirmedMessageEvent) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1.otherConfirmed(param1.getParser().stuffId);
      }
      
      private function onCancelLock(param1:FriendFurniCancelLockMessageEvent) : void
      {
         UnknownVarFromFriendFurniConfirmWidgetHandler_FriendFurniConfirmWidget_1.close(param1.getParser().stuffId);
      }
      
      public function get type() : String
      {
         return "";
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function update() : void
      {
      }
   }
}

