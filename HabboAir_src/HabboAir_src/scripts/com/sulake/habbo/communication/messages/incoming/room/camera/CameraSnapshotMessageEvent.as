package com.sulake.habbo.communication.messages.incoming.room.camera
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.camera.CameraSnapshotMessageParser;
   
   [SecureSWF(rename="true")]
   public class CameraSnapshotMessageEvent extends MessageEvent
   {
      public function CameraSnapshotMessageEvent(param1:Function)
      {
         super(param1,CameraSnapshotMessageParser);
      }
      
      public function getParser() : CameraSnapshotMessageParser
      {
         return _parser as CameraSnapshotMessageParser;
      }
   }
}

