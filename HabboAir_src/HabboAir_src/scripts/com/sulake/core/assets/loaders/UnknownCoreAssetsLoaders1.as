package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   
   internal class UnknownCoreAssetsLoaders1 extends EventDispatcherWrapper implements IComponentInterfaceQueue
   {
      public static const NONE:uint = 0;
      
      public static const IO_ERROR:uint = 1;
      
      public static const UnknownConstFromUnknownCoreAssetsLoaders1_Uint_1:uint = 2;
      
      protected var _status:int = 0;
      
      protected var _retries:int = 0;
      
      protected var UnknownVarFromUnknownCoreAssetsLoaders1_Int_1:int = 2;
      
      protected var _errorCode:uint = 0;
      
      public function UnknownCoreAssetsLoaders1()
      {
         super();
      }
      
      public function get errorCode() : uint
      {
         return _errorCode;
      }
      
      protected function loadEventHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case "httpStatus":
               _status = HTTPStatusEvent(param1).status;
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventStatus",_status));
               break;
            case "complete":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventComplete",_status));
               break;
            case "unload":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventUnload",_status));
               break;
            case "open":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventOpen",_status));
               break;
            case "progress":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventProgress",_status));
               break;
            case "ioError":
               _errorCode = 1;
               if(!retry())
               {
                  dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError",_status));
               }
               break;
            case "securityError":
               _errorCode = 2;
               if(!retry())
               {
                  dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError",_status));
               }
         }
      }
      
      protected function retry() : Boolean
      {
         return false;
      }
   }
}

