package com.sulake.habbo.window.utils
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class ConfirmDialog extends AlertDialog implements UnknownICoreWindowUtils2
   {
      public function ConfirmDialog(param1:IHabboWindowManagerComponent, param2:XML, param3:String, param4:String, param5:uint, param6:Function, param7:Boolean)
      {
         super(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function dialogEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:WindowEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "_alert_button_ok":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_OK",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
                  break;
               case "_alert_button_cancel":
               case "header_button_close":
                  if(_callback != null)
                  {
                     _loc3_ = WindowEvent.allocate("WE_CANCEL",null,null);
                     _callback(this,_loc3_);
                     _loc3_.recycle();
                  }
            }
         }
      }
   }
}

