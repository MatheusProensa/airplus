package login
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.net.URLRequest;
   
   public class ImageLoader extends EventDispatcher
   {
      private var UnknownVarFromImageLoader_Loader_1:Loader;
      
      private var UnknownVarFromImageLoader_String_1:String;
      
      public function ImageLoader(param1:Loader, param2:String)
      {
         super();
         UnknownVarFromImageLoader_Loader_1 = param1;
         UnknownVarFromImageLoader_String_1 = param2;
         var _loc3_:URLRequest = new URLRequest(param2);
         param1.load(_loc3_);
         param1.contentLoaderInfo.addEventListener("complete",avatarImageLoadCompleteHandler);
         param1.contentLoaderInfo.addEventListener("error",onImageError);
         param1.contentLoaderInfo.addEventListener("ioError",onImageError);
         param1.contentLoaderInfo.addEventListener("securityError",onImageError);
      }
      
      public static function CreateLoader(param1:Loader, param2:String, param3:Function) : ImageLoader
      {
         var _loc4_:ImageLoader = new ImageLoader(param1,param2);
         _loc4_.addEventListener("complete",param3);
         return _loc4_;
      }
      
      private function avatarImageLoadCompleteHandler(param1:Event) : void
      {
         Logger.log("[ImageLoader] Loaded image " + UnknownVarFromImageLoader_String_1);
         dispatchEvent(new ImageLoaderEvent("complete",UnknownVarFromImageLoader_Loader_1,UnknownVarFromImageLoader_String_1));
      }
      
      private function onImageError(param1:ErrorEvent) : void
      {
         Logger.log("[ImageLoader] Failed to load image " + param1.text);
      }
   }
}

