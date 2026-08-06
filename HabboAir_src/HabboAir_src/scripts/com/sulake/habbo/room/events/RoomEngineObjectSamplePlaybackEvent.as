package com.sulake.habbo.room.events
{
   public class RoomEngineObjectSamplePlaybackEvent extends RoomEngineObjectEvent
   {
      public static const ROOM_OBJECT_INITIALIZED:String = "REOSPE_ROOM_OBJECT_INITIALIZED";
      
      public static const ROOM_OBJECT_DISPOSED:String = "REOSPE_ROOM_OBJECT_DISPOSED";
      
      public static const PLAY_SAMPLE:String = "REOSPE_PLAY_SAMPLE";
      
      public static const CHANGE_PITCH:String = "REOSPE_CHANGE_PITCH";
      
      private var _sampleId:int;
      
      private var _pitch:Number;
      
      public function RoomEngineObjectSamplePlaybackEvent(param1:String, param2:int, param3:int, param4:int, param5:int, param6:Number = 1, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param3,param4);
         _sampleId = param5;
         _pitch = param6;
      }
      
      public function get sampleId() : int
      {
         return _sampleId;
      }
      
      public function get pitch() : Number
      {
         return _pitch;
      }
   }
}

