package com.sulake.core.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   
   public class LibraryLoaderQueue extends EventDispatcherWrapper implements IComponentInterfaceQueue
   {
      protected static const MAX_SIMULTANEOUS_DOWNLOADS:int = 4;
      
      private var UnknownVarFromLibraryLoaderQueue_Boolean_1:Boolean = false;
      
      private var UnknownVarFromLibraryLoaderQueue_Array_1:Array = [];
      
      private var _loaders:Array = [];
      
      public function LibraryLoaderQueue(param1:Boolean = false)
      {
         UnknownVarFromLibraryLoaderQueue_Boolean_1 = param1;
         super();
      }
      
      public function get length() : int
      {
         return UnknownVarFromLibraryLoaderQueue_Array_1.length + _loaders.length;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = null;
         if(!disposed)
         {
            for each(_loc1_ in _loaders)
            {
               _loc1_.dispose();
            }
            for each(_loc1_ in UnknownVarFromLibraryLoaderQueue_Array_1)
            {
               _loc1_.dispose();
            }
            _loaders = null;
            UnknownVarFromLibraryLoaderQueue_Array_1 = null;
            super.dispose();
         }
      }
      
      public function push(param1:LibraryLoader) : void
      {
         if(!disposed && !isUrlInQueue(param1.url) && !findLibraryLoaderByURL(param1.url))
         {
            if(param1.paused)
            {
               UnknownVarFromLibraryLoaderQueue_Array_1.push(param1);
            }
            else
            {
               _loaders.push(param1);
            }
            param1.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",libraryLoadedHandler);
            param1.addEventListener("LIBRARY_LOADER_EVENT_PROGRESS",loadProgressHandler);
            param1.addEventListener("LIBRARY_LOADER_EVENT_DISPOSE",loaderDisposeHandler);
            param1.addEventListener("LIBRARY_LOADER_EVENT_ERROR",loadErrorHandler);
            next();
         }
      }
      
      private function next() : void
      {
         var _loc1_:LibraryLoader = null;
         if(!disposed)
         {
            while(_loaders.length < 4 && UnknownVarFromLibraryLoaderQueue_Array_1.length > 0)
            {
               _loc1_ = UnknownVarFromLibraryLoaderQueue_Array_1.shift();
               _loaders.push(_loc1_);
               _loc1_.resume();
            }
         }
      }
      
      private function libraryLoadedHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         if(_loc2_)
         {
            removeLoader(_loc2_);
         }
         next();
      }
      
      private function loadProgressHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
      }
      
      private function loaderDisposeHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         removeLoader(_loc2_);
         next();
      }
      
      private function loadErrorHandler(param1:LibraryLoaderEvent) : void
      {
         var _loc2_:LibraryLoader = param1.target as LibraryLoader;
         if(_loc2_)
         {
            removeLoader(_loc2_);
         }
         next();
      }
      
      private function removeLoader(param1:LibraryLoader) : void
      {
         var _loc2_:int = 0;
         param1.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",libraryLoadedHandler);
         param1.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS",loadProgressHandler);
         param1.removeEventListener("LIBRARY_LOADER_EVENT_DISPOSE",loaderDisposeHandler);
         param1.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",loadErrorHandler);
         try
         {
            _loc2_ = int(UnknownVarFromLibraryLoaderQueue_Array_1.indexOf(param1));
            if(_loc2_ > -1)
            {
               UnknownVarFromLibraryLoaderQueue_Array_1.splice(_loc2_,1);
            }
            _loc2_ = int(_loaders.indexOf(param1));
            if(_loc2_ > -1)
            {
               _loaders.splice(_loc2_,1);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function isUrlInQueue(param1:String, param2:Boolean = true) : Boolean
      {
         if(!disposed)
         {
            if(param2 && param1.indexOf("?") > -1)
            {
               param1 = param1.slice(0,param1.indexOf("?"));
            }
            for each(var _loc3_ in UnknownVarFromLibraryLoaderQueue_Array_1)
            {
               if(param2)
               {
                  if(_loc3_.url.indexOf(param1) == 0)
                  {
                     return true;
                  }
               }
               else if(_loc3_.url == param1)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function findLibraryLoaderByURL(param1:String, param2:Boolean = true) : LibraryLoader
      {
         if(!disposed)
         {
            if(param2 && param1.indexOf("?") > -1)
            {
               param1 = param1.slice(0,param1.indexOf("?"));
            }
            for each(var _loc3_ in _loaders)
            {
               if(param2)
               {
                  if(_loc3_.url.indexOf(param1) == 0)
                  {
                     return _loc3_;
                  }
               }
               else if(_loc3_.url == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
   }
}

