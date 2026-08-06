package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events
{
   import flash.events.Event;
   
   public class PathResetEvent extends Event
   {
      public static const MOVING_OBJECT_PATH_RESET:String = "LWMOPRE_MOVING_OBJECT_PATH_RESET";
      
      private var _objectId:int;
      
      public function PathResetEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         _objectId = param2;
         super("LWMOPRE_MOVING_OBJECT_PATH_RESET",param3,param4);
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

