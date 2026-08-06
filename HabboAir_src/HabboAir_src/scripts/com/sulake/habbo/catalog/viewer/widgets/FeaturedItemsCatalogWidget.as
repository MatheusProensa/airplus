package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
   
   public class FeaturedItemsCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromFeaturedItemsCatalogWidget_IWindowController_1_1:IWindowController_1;
      
      public function FeaturedItemsCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _catalog = null;
            UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1.dispose();
            UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1 = null;
            UnknownVarFromFeaturedItemsCatalogWidget_IWindowController_1_1.dispose();
            UnknownVarFromFeaturedItemsCatalogWidget_IWindowController_1_1 = null;
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         var _loc2_:int = 0;
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1 = window.findChildByName("itemlist_featured") as IItemListWindow;
         UnknownVarFromFeaturedItemsCatalogWidget_IWindowController_1_1 = UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1.getListItemByName("featured_item_template") as IWindowController_1;
         UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1.removeListItems();
         if(_catalog.frontPageItems == null || _catalog.frontPageItems.length == 0)
         {
            return true;
         }
         var _loc1_:IWindowController_1 = _window.findChildByName("firstitem") as IWindowController_1;
         populateItem(_catalog.frontPageItems[0],_loc1_);
         _loc2_ = 1;
         while(_loc2_ < Math.min(4,_catalog.frontPageItems.length))
         {
            UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1.addListItem(createItemFromTemplate(_catalog.frontPageItems[_loc2_]));
            _loc2_++;
         }
         return true;
      }
      
      private function createItemFromTemplate(param1:FrontPageItem) : IWindowController_1
      {
         return populateItem(param1,UnknownVarFromFeaturedItemsCatalogWidget_IWindowController_1_1.clone() as IWindowController_1);
      }
      
      private function populateItem(param1:FrontPageItem, param2:IWindowController_1) : IWindowController_1
      {
         var _loc3_:String = null;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc5_:ITextWindow = param2.findChildByName("item_title") as ITextWindow;
         _loc5_.text = param1.itemName;
         if(param1.itemPromoImage != null && param1.itemPromoImage != "")
         {
            _loc3_ = _catalog.context.configuration.getProperty("image.library.url");
            _loc4_ = param2.findChildByName("item_image") as IStaticBitmapWrapperWindow;
            _loc4_.assetUri = _loc3_ + param1.itemPromoImage;
         }
         var _loc6_:IWindowModel = param2.getChildByName("event_catcher_region");
         if(_loc6_ != null)
         {
            _loc6_.procedure = eventProc;
         }
         return param2;
      }
      
      private function eventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc3_:FrontPageItem = null;
         if(param1.type == "WME_DOWN")
         {
            _loc4_ = UnknownVarFromFeaturedItemsCatalogWidget_IItemListWindow_1.getListItemIndex(param2.parent);
            _loc4_ = _loc4_ < 0 ? 0 : _loc4_ + 1;
            _loc3_ = _catalog.frontPageItems[_loc4_];
            switch(_loc3_.type)
            {
               case 0:
                  if(_loc3_.cataloguePageLocation == "room_bundles_mobile")
                  {
                     return _catalog.openCatalogPage("room_bundles","NORMAL");
                  }
                  if(_loc3_.cataloguePageLocation == "mobile_subscriptions")
                  {
                     return _catalog.openCatalogPage("hc_membership","NORMAL");
                  }
                  _catalog.openCatalogPage(_loc3_.cataloguePageLocation,"NORMAL");
                  break;
               case 1:
                  _catalog.openCatalogPageByOfferId(_loc3_.productOfferID,"NORMAL");
            }
         }
      }
   }
}

