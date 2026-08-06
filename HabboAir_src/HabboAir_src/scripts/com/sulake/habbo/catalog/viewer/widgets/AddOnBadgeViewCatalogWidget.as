package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class AddOnBadgeViewCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      public function AddOnBadgeViewCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("addOnBadgeViewWidget");
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:IBadgeImageWidget = null;
         if(!disposed && param1.offer.badgeCode)
         {
            _loc2_ = IWidgetWindowController(_window.findChildByName("badge")).widget as IBadgeImageWidget;
            if(_loc2_ != null)
            {
               _loc2_.badgeId = param1.offer.badgeCode;
            }
         }
      }
   }
}

