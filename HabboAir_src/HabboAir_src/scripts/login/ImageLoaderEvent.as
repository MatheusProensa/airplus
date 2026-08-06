package login
{
   import flash.display.Loader;
   import flash.events.Event;
   
   public class ImageLoaderEvent extends Event
   {
      private var _loader:Loader;
      
      private var _url:String;
      
      public function ImageLoaderEvent(param1:String, param2:Loader, param3:String)
      {
         _loader = param2;
         _url = param3;
         super(param1,false,false);
      }
      
      public function get loader() : Loader
      {
         return _loader;
      }
      
      public function get url() : String
      {
         return _url;
      }
   }
}

