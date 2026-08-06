package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils6;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class AlertDialogWithLink extends AlertDialog implements UnknownICoreWindowUtils6
   {
      protected var _linkTitle:String = "";
      
      protected var _linkUrl:String = "";
      
      public function AlertDialogWithLink(param1:IHabboWindowManagerComponent, param2:XML, param3:String, param4:String, param5:String, param6:String, param7:uint, param8:Function)
      {
         super(param1,param2,param3,param4,param7,param8,false);
         this.linkTitle = param5;
         this.linkUrl = param6;
      }
      
      override protected function dialogEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            var _loc3_:* = param2.name;
            if("_alert_button_link" === _loc3_)
            {
               HabboWebTools.navigateToURL(_linkUrl,"_empty");
               return;
            }
         }
         super.dialogEventProc(param1,param2);
      }
      
      public function set linkTitle(param1:String) : void
      {
         _linkTitle = param1;
         if(_window)
         {
            UnknownICoreWindowComponents4(_window.findChildByTag("LINK")).caption = _linkTitle;
         }
      }
      
      public function get linkTitle() : String
      {
         return _linkTitle;
      }
      
      public function set linkUrl(param1:String) : void
      {
         _linkUrl = param1;
      }
      
      public function get linkUrl() : String
      {
         return _linkUrl;
      }
   }
}

