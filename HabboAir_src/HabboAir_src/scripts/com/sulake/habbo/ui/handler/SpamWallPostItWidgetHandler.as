package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.RequestSpamWallPostItMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.AddSpamWallPostItMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RequestSpamWallPostItMessageParser;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSpamWallPostItEditEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetSpamWallPostItFinishEditingMessage;
   import flash.events.Event;
   
   public class SpamWallPostItWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1:IConnection = null;
      
      private var UnknownVarFromSpamWallPostItWidgetHandler_IMessageEvent_1:IMessageEvent;
      
      public function SpamWallPostItWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_SPAMWALL_POSTIT_WIDGET";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function set connection(param1:IConnection) : void
      {
         UnknownVarFromSpamWallPostItWidgetHandler_IMessageEvent_1 = new RequestSpamWallPostItMessageEvent(onSpamWallPostItRequest);
         UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1 = param1;
         UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1.addMessageEvent(UnknownVarFromSpamWallPostItWidgetHandler_IMessageEvent_1);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1.removeMessageEvent(UnknownVarFromSpamWallPostItWidgetHandler_IMessageEvent_1);
            UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1 = null;
         }
      }
      
      private function onSpamWallPostItRequest(param1:RequestSpamWallPostItMessageEvent) : void
      {
         var _loc7_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:RequestSpamWallPostItMessageParser = param1.getParser();
         var _loc2_:int = _loc5_.itemId;
         var _loc6_:String = _loc5_.location;
         var _loc3_:* = "post_it";
         var _loc4_:IFurnitureItem = null;
         if(_container.inventory != null)
         {
            _loc4_ = _container.inventory.getWallItemById(_loc2_);
         }
         if(_loc4_ != null && _container.roomEngine != null)
         {
            _loc7_ = _container.roomEngine.getWallItemType(_loc4_.type);
            if(_loc7_.match("post_it_"))
            {
               _loc3_ = _loc7_;
            }
         }
         if(_container != null)
         {
            if(_container.events != null)
            {
               _container.events.dispatchEvent(new RoomWidgetSpamWallPostItEditEvent("RWSWPUE_OPEN_EDITOR",_loc2_,_loc6_,_loc3_));
            }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWSWPUE_OPEN_EDITOR","RWSWPFEE_SEND_POSTIT_DATA"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetSpamWallPostItFinishEditingMessage = null;
         var _loc3_:AddSpamWallPostItMessageComposer = null;
         var _loc4_:* = param1.type;
         if("RWSWPFEE_SEND_POSTIT_DATA" === _loc4_)
         {
            _loc2_ = param1 as RoomWidgetSpamWallPostItFinishEditingMessage;
            if(_loc2_ != null)
            {
               if(UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1 != null)
               {
                  _loc3_ = new AddSpamWallPostItMessageComposer(_loc2_.objectId,_loc2_.location,_loc2_.colorHex,_loc2_.text);
                  UnknownVarFromSpamWallPostItWidgetHandler_IConnection_1.send(_loc3_);
               }
            }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

