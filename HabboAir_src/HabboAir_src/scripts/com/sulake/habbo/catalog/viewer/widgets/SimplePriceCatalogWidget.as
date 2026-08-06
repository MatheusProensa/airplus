package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   
   public class SimplePriceCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromSimplePriceCatalogWidget_IWindowModel_1:IWindowModel;
      
      public function SimplePriceCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         UnknownVarFromSimplePriceCatalogWidget_IWindowModel_1 = _catalog.utils.showPriceOnProduct(param1.offer,_window as IWindowController_1,UnknownVarFromSimplePriceCatalogWidget_IWindowModel_1,_window.findChildByName("fake_productimage"),0,true,0);
      }
   }
}

