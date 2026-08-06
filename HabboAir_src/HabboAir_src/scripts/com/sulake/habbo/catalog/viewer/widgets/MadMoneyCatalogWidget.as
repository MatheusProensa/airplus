package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   
   public class MadMoneyCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      public function MadMoneyCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
            UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1.removeEventListener("WME_CLICK",eventProc);
            UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1 = _window.findChildByName("ctlg_madmoney_button") as UnknownICoreWindowComponents4;
         if(UnknownVarFromMadMoneyCatalogWidget_UnknownICoreWindowComponents4_1 != null)
         {
         }
         return true;
      }
      
      private function eventProc(param1:WindowMouseEvent) : void
      {
         var event:WindowMouseEvent = param1;
         page.viewer.catalog.windowManager.alert("TODO","Fix in MadMoneyCatalogWidget.as",0,function(param1:UnknownICoreWindowUtils1, param2:WindowEvent):void
         {
            param1.dispose();
         });
      }
   }
}

