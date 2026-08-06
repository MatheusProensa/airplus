package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class SpecialInfoWidget extends CatalogWidget implements ICatalogWidget
   {
      public function SpecialInfoWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("specialInfoWidget");
         _window.findChildByName("ctlg_special_txt").caption = "";
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         _window.visible = false;
      }
   }
}

