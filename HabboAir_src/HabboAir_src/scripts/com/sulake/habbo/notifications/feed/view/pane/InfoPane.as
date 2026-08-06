package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.notifications.feed.NotificationView;
   
   public class InfoPane extends AbstractPane
   {
      public function InfoPane(param1:String, param2:NotificationView, param3:IWindowController_1)
      {
         super(param1,param2,param3,2);
         (_window.findChildByName("info_ok") as UnknownICoreWindowComponents5).addEventListener("WME_CLICK",onOkClick);
      }
      
      override public function dispose() : void
      {
         var _loc1_:UnknownICoreWindowComponents5 = null;
         super.dispose();
         if(_window)
         {
            _loc1_ = _window.findChildByName("info_ok") as UnknownICoreWindowComponents5;
            if(_loc1_)
            {
               _loc1_.removeEventListener("WME_CLICK",onOkClick);
               _loc1_ = null;
            }
         }
      }
      
      private function onOkClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromAbstractPane_NotificationView_1.closePaneLevel(2);
      }
   }
}

