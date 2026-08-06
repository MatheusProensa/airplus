package com.sulake.habbo.ui.widget.camera
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class CameraFxPreloader
   {
      private static var ASSETS:Dictionary;
      
      private static var instance:CameraFxPreloader;
      
      private static var _urls:Array;
      
      private static var UnknownVarFromCameraFxPreloader_String_1:String;
      
      private var UnknownVarFromCameraFxPreloader_Loader_1:Loader;
      
      private var UnknownVarFromCameraFxPreloader_Boolean_1:Boolean = false;
      
      public function CameraFxPreloader()
      {
         super();
         UnknownVarFromCameraFxPreloader_Loader_1 = new Loader();
         UnknownVarFromCameraFxPreloader_Loader_1.contentLoaderInfo.addEventListener("complete",assetLoaded);
         UnknownVarFromCameraFxPreloader_Loader_1.contentLoaderInfo.addEventListener("ioError",loadFailed);
         loadNextImage();
      }
      
      public static function init(param1:String, param2:Array) : void
      {
         if(!instance)
         {
            ASSETS = new Dictionary();
            UnknownVarFromCameraFxPreloader_String_1 = param1;
            _urls = param2;
            instance = new CameraFxPreloader();
         }
      }
      
      public static function preloadFinished() : Boolean
      {
         return instance != null ? instance.UnknownVarFromCameraFxPreloader_Boolean_1 : false;
      }
      
      public static function getImage(param1:String) : BitmapData
      {
         return ASSETS != null ? ASSETS[param1] : null;
      }
      
      private function loadNextImage() : void
      {
         var _loc1_:String = null;
         if(_urls.length > 0)
         {
            _loc1_ = UnknownVarFromCameraFxPreloader_String_1 + "Habbo-Stories/" + _urls[0] + ".png";
            UnknownVarFromCameraFxPreloader_Loader_1.load(new URLRequest(_loc1_));
         }
         else
         {
            UnknownVarFromCameraFxPreloader_Boolean_1 = true;
         }
      }
      
      private function assetLoaded(param1:Event) : void
      {
         ASSETS[_urls.shift()] = Bitmap(UnknownVarFromCameraFxPreloader_Loader_1.content).bitmapData.clone();
         loadNextImage();
      }
      
      private function loadFailed(param1:Event) : void
      {
         Logger.log("Camera Fx preloading failed for " + UnknownVarFromCameraFxPreloader_Loader_1.contentLoaderInfo.loaderURL);
         _urls.shift();
         loadNextImage();
      }
   }
}

