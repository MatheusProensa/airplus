package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.InitCameraMessageParser;
   
   [SecureSWF(rename="true")]
   public class InitCameraMessageEvent extends MessageEvent
   {
      public function InitCameraMessageEvent(param1:Function)
      {
         super(param1,InitCameraMessageParser);
      }
      
      public function getParser() : InitCameraMessageParser
      {
         return this._parser as InitCameraMessageParser;
      }
   }
}

