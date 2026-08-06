package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.listitem
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoListItem;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   
   public class ExtraInfoBundlesInfoItem extends ExtraInfoListItem
   {
      private var _catalog:HabboCatalog;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromExtraInfoBundlesInfoItem_BundlePurchaseExtraInfoWidget_1:BundlePurchaseExtraInfoWidget;
      
      public function ExtraInfoBundlesInfoItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:HabboCatalog)
      {
         super(param1,param2,param3,2,true);
         _catalog = param4;
         UnknownVarFromExtraInfoBundlesInfoItem_BundlePurchaseExtraInfoWidget_1 = param1;
      }
      
      override public function getRenderedWindow() : IWindowController_1
      {
         if(_window == null)
         {
            createWindow();
         }
         return _window;
      }
      
      private function createWindow() : void
      {
         _window = IWindowController_1(_catalog.utils.createWindow("bundlesInfoItem"));
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromExtraInfoBundlesInfoItem_BundlePurchaseExtraInfoWidget_1.events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_ITEM_CLICKED",data,id));
         }
      }
   }
}

