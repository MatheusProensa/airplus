package login
{
   import com.sulake.habbo.communication.login.IWebApiLoginProvider;
   import com.sulake.habbo.communication.login.UnknownIHabboCommunicationLogin1;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.LocationChangeEvent;
   import flash.geom.Rectangle;
   import flash.media.StageWebView;
   
   public class WebCaptchaView extends Sprite implements UnknownIHabboCommunicationLogin1
   {
      private static var UnknownVarFromWebCaptchaView_StageWebView_1:StageWebView;
      
      private static const CAPTCHA_ENDPOINT:String = "/api/public/captcha";
      
      private static const TOKEN_KEY:String = "token=";
      
      private var UnknownVarFromWebCaptchaView_IWebApiLoginProvider_1:IWebApiLoginProvider;
      
      public function WebCaptchaView(param1:IWebApiLoginProvider)
      {
         super();
         UnknownVarFromWebCaptchaView_IWebApiLoginProvider_1 = param1;
         addEventListener("addedToStage",onAddedToStage);
      }
      
      private static function resolveToken(param1:String) : String
      {
         var _loc2_:int = int(param1 != null ? param1.indexOf("token=") : -1);
         if(_loc2_ < 0)
         {
            return null;
         }
         return param1.substr(_loc2_ + "token=".length);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:String = UnknownVarFromWebCaptchaView_IWebApiLoginProvider_1.getProperty("web.api") + "/api/public/captcha";
         Logger.log("[WebCaptchaView] Initialize url: " + _loc2_);
         this.width = stage.stageWidth;
         this.height = stage.stageHeight;
         if(UnknownVarFromWebCaptchaView_StageWebView_1 == null)
         {
            UnknownVarFromWebCaptchaView_StageWebView_1 = new StageWebView(true);
            UnknownVarFromWebCaptchaView_StageWebView_1.stage = this.stage;
            UnknownVarFromWebCaptchaView_StageWebView_1.viewPort = new Rectangle(0,100,stage.width,stage.height - 100);
            UnknownVarFromWebCaptchaView_StageWebView_1.loadURL(_loc2_);
            UnknownVarFromWebCaptchaView_StageWebView_1.addEventListener("locationChange",onLocationChange);
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromWebCaptchaView_IWebApiLoginProvider_1 = null;
         if(UnknownVarFromWebCaptchaView_StageWebView_1)
         {
            UnknownVarFromWebCaptchaView_StageWebView_1.removeEventListener("locationChange",onLocationChange);
            UnknownVarFromWebCaptchaView_StageWebView_1.dispose();
         }
      }
      
      private function onLocationChange(param1:LocationChangeEvent) : void
      {
         var _loc2_:String = resolveToken(param1.location);
         if(_loc2_ != null)
         {
            UnknownVarFromWebCaptchaView_IWebApiLoginProvider_1.handleCaptchaResult(_loc2_);
         }
      }
   }
}

