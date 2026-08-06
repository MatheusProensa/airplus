package com.sulake.habbo.communication.messages.incoming.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.camera.ThumbnailStatusMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThumbnailStatusMessageEvent extends MessageEvent
   {
      public function ThumbnailStatusMessageEvent(param1:Function)
      {
         super(param1,ThumbnailStatusMessageParser);
      }
      
      public function getParser() : ThumbnailStatusMessageParser
      {
         return this._parser as ThumbnailStatusMessageParser;
      }
   }
}

