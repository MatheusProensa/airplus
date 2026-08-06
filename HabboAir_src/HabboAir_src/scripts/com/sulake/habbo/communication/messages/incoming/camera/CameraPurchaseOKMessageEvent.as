package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraPurchaseOKMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraPurchaseOKMessageEvent extends MessageEvent
   {
      public function CameraPurchaseOKMessageEvent(param1:Function)
      {
         super(param1,CameraPurchaseOKMessageParser);
      }
      
      public function getParser() : CameraPurchaseOKMessageParser
      {
         return this._parser as CameraPurchaseOKMessageParser;
      }
   }
}

