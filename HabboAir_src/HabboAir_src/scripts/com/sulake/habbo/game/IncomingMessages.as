package com.sulake.habbo.game
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   
   public class IncomingMessages implements IComponentInterfaceQueue
   {
      private var _gameManager:HabboGameManager;
      
      private var _disposed:Boolean = false;
      
      public function IncomingMessages(param1:HabboGameManager)
      {
         super();
         _gameManager = param1;
         var _loc2_:IHabboCommunicationManager = _gameManager.communication;
         _loc2_.addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
      }
      
      public function dispose() : void
      {
         _gameManager = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         _gameManager.hotelClosed = true;
      }
   }
}

