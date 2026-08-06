package com.sulake.habbo.moderation
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class OpenExternalLink
   {
      private var UnknownVarFromOpenExternalLink_String_1:String;
      
      public function OpenExternalLink(param1:ModerationManager, param2:IWindowModel, param3:String)
      {
         super();
         param2.procedure = onClick;
         UnknownVarFromOpenExternalLink_String_1 = param3;
      }
      
      private function onClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         navigateToURL(new URLRequest(UnknownVarFromOpenExternalLink_String_1),"_blank");
      }
   }
}

