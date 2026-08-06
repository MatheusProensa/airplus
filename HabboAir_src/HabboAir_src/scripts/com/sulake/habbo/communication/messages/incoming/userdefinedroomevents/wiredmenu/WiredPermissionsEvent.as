package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredPermissionsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredPermissionsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredPermissionsEvent(param1:Function)
      {
         super(param1,WiredPermissionsMessageParser);
      }
      
      public function getParser() : WiredPermissionsMessageParser
      {
         return this._parser as WiredPermissionsMessageParser;
      }
   }
}

