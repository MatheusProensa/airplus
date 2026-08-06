package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   
   public class BuilderAddonsCatalogWidget extends CatalogWidget implements ICatalogWidget, IComponentInterfaceQueue
   {
      private var _catalog:HabboCatalog;
      
      public function BuilderAddonsCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         var _loc3_:IWindowController_1 = null;
         if(!super.init())
         {
            return false;
         }
         _window.procedure = windowProcedure;
         var _loc5_:IItemListWindow = _window.findChildByName("addons_list") as IItemListWindow;
         var _loc2_:IWindowModel = _loc5_.removeListItemAt(0);
         var _loc6_:int = 0;
         var _loc4_:* = _catalog.builderSecondsLeft > 0;
         _window.findChildByName("trial_warning").visible = !_loc4_;
         for each(var _loc1_ in page.offers)
         {
            _loc3_ = _loc2_.clone() as IWindowController_1;
            _loc3_.findChildByName("item_header").caption = _loc1_.localizationName;
            _loc3_.findChildByName("item_price").caption = _loc1_.priceInCredits.toString();
            _loc3_.findChildByName("item_buy").id = _loc6_;
            if(_loc1_.priceInActivityPoints > 0)
            {
               _loc3_.findChildByName("diamonds_icon").visible = true;
               _loc3_.findChildByName("diamonds_price").visible = true;
               _loc3_.findChildByName("diamonds_price").caption = _loc1_.priceInActivityPoints.toString();
            }
            if(!_loc4_)
            {
               UnknownICoreWindowComponents4(_loc3_.findChildByName("item_buy")).disable();
            }
            _loc6_++;
            _loc5_.addListItem(_loc3_);
         }
         return true;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name == "item_buy")
         {
            _catalog.showPurchaseConfirmation(page.offers[param2.id],page.pageId);
         }
      }
   }
}

