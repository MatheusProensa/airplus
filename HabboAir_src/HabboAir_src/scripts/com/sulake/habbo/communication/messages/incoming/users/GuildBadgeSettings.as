package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class GuildBadgeSettings
   {
      private var _partId:int;
      
      private var _colorId:int;
      
      private var _position:int;
      
      public function GuildBadgeSettings(param1:IMessageDataWrapper)
      {
         super();
         _partId = param1.readInteger();
         _colorId = param1.readInteger();
         _position = param1.readInteger();
      }
      
      public function get partId() : int
      {
         return _partId;
      }
      
      public function get colorId() : int
      {
         return _colorId;
      }
      
      public function get position() : int
      {
         return _position;
      }
   }
}

