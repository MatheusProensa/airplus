package com.sulake.core.utils
{
   import flash.events.Event;
   
   [SecureSWF(rename="true")]
   public class LibraryLoaderEvent extends Event
   {
      public static const LIBRARY_LOADER_EVENT_COMPLETE:String = "LIBRARY_LOADER_EVENT_COMPLETE";
      
      public static const LIBRARY_LOADER_EVENT_PROGRESS:String = "LIBRARY_LOADER_EVENT_PROGRESS";
      
      public static const LIBRARY_LOADER_EVENT_UNLOAD:String = "LIBRARY_LOADER_EVENT_UNLOAD";
      
      public static const LIBRARY_LOADER_EVENT_STATUS:String = "LIBRARY_LOADER_EVENT_STATUS";
      
      public static const LIBRARY_LOADER_EVENT_ERROR:String = "LIBRARY_LOADER_EVENT_ERROR";
      
      public static const LIBRARY_LOADER_EVENT_DEBUG:String = "LIBRARY_LOADER_EVENT_DEBUG";
      
      public static const LIBRARY_LOADER_EVENT_DISPOSE:String = "LIBRARY_LOADER_EVENT_DISPOSE";
      
      private var _status:int;
      
      private var _bytesTotal:uint;
      
      private var _bytesLoaded:uint;
      
      private var _elapsedTime:uint;
      
      public function LibraryLoaderEvent(param1:String, param2:int, param3:uint, param4:uint, param5:uint)
      {
         _status = param2;
         _bytesTotal = param3;
         _bytesLoaded = param4;
         _elapsedTime = param5;
         super(param1,false,false);
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get bytesTotal() : uint
      {
         return _bytesTotal;
      }
      
      public function get bytesLoaded() : uint
      {
         return _bytesLoaded;
      }
      
      public function get elapsedTime() : uint
      {
         return _elapsedTime;
      }
      
      override public function clone() : Event
      {
         return new LibraryLoaderEvent(type,_status,_bytesTotal,_bytesLoaded,elapsedTime);
      }
   }
}

