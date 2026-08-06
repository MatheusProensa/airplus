package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraPublishStatusMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraPublishStatusMessageEvent extends MessageEvent
   {
      public function CameraPublishStatusMessageEvent(param1:Function)
      {
         super(param1,CameraPublishStatusMessageParser);
      }
      
      public function getParser() : CameraPublishStatusMessageParser
      {
         return this._parser as CameraPublishStatusMessageParser;
      }
   }
}

