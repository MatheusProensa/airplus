package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class OfficialRoomImageLoader implements IComponentInterfaceQueue
   {
      private var _navigator:IHabboNavigator_2;
      
      private var UnknownVarFromOfficialRoomImageLoader_String_1:String;
      
      private var UnknownVarFromOfficialRoomImageLoader_String_2:String;
      
      private var UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _disposed:Boolean;
      
      public function OfficialRoomImageLoader(param1:IHabboNavigator_2, param2:String, param3:IBitmapWrapperController)
      {
         super();
         _navigator = param1;
         UnknownVarFromOfficialRoomImageLoader_String_1 = param2;
         UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1 = param3;
         var _loc4_:String = _navigator.getProperty("image.library.url");
         UnknownVarFromOfficialRoomImageLoader_String_2 = _loc4_ + UnknownVarFromOfficialRoomImageLoader_String_1;
         Logger.log("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + UnknownVarFromOfficialRoomImageLoader_String_2);
      }
      
      public function startLoad() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:AssetLoaderStruct = null;
         if(_navigator.assets.hasAsset(UnknownVarFromOfficialRoomImageLoader_String_1))
         {
            setImage();
         }
         else
         {
            _loc1_ = new URLRequest(UnknownVarFromOfficialRoomImageLoader_String_2);
            _loc2_ = _navigator.assets.loadAssetFromFile(UnknownVarFromOfficialRoomImageLoader_String_1,_loc1_,"image/gif");
            _loc2_.addEventListener("AssetLoaderEventComplete",onImageReady);
            _loc2_.addEventListener("AssetLoaderEventError",onLoadError);
         }
      }
      
      private function onImageReady(param1:AssetLoaderEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            Logger.log("Loading pic from url: " + UnknownVarFromOfficialRoomImageLoader_String_2 + " failed. loaderStruct == null");
            return;
         }
         setImage();
      }
      
      private function setImage() : void
      {
         var _loc1_:BitmapData = null;
         if(_navigator && !_navigator.disposed && UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1 && !UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.disposed)
         {
            _loc1_ = _navigator.getButtonImage(UnknownVarFromOfficialRoomImageLoader_String_1,"");
            if(_loc1_)
            {
               UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.disposesBitmap = false;
               UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.bitmap = _loc1_;
               UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.width = _loc1_.width;
               UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.height = _loc1_.height;
               UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1.visible = true;
            }
            else
            {
               Logger.log("OfficialRoomImageLoader - Image not found: " + UnknownVarFromOfficialRoomImageLoader_String_1);
            }
         }
         dispose();
      }
      
      private function onLoadError(param1:AssetLoaderEvent) : void
      {
         Logger.log("Error loading image: " + UnknownVarFromOfficialRoomImageLoader_String_2 + ", " + param1);
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         UnknownVarFromOfficialRoomImageLoader_IBitmapWrapperController_1 = null;
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

