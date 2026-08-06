package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.CameraStorageUrlMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraStorageUrlMessageEvent extends MessageEvent
   {
      public function CameraStorageUrlMessageEvent(param1:Function)
      {
         super(param1,CameraStorageUrlMessageParser);
      }
      
      public function getParser() : CameraStorageUrlMessageParser
      {
         return this._parser as CameraStorageUrlMessageParser;
      }
   }
}

