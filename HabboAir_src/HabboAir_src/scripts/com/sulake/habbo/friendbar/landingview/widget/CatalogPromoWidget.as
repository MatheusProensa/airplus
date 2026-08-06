package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   
   public class CatalogPromoWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var _targetCatalogPageName:String;
      
      private var _disposed:Boolean = false;
      
      public function CatalogPromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      protected function get xmlAssetName() : String
      {
         return "catalog_promo";
      }
      
      public function initialize() : void
      {
         var _loc2_:int = 0;
         _container = IWindowController_1(_landingView.getXmlWindow(xmlAssetName));
         _targetCatalogPageName = _landingView.getProperty("landing.view.catalog.promo.target");
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("picture"));
         _loc3_.assetUri = _landingView.getProperty("landing.view.catalog.promo.image.uri");
         _container.findChildByName("open_page_button").addEventListener("WME_CLICK",onOpenPageButtonClicked);
         if(_targetCatalogPageName == "" && _loc3_.assetUri == "")
         {
            _container.visible = false;
         }
         else
         {
            _container.visible = true;
         }
         var _loc1_:Map = new Map();
         _loc1_.add("catalog_promo_caption","landing.view.catalog.promo.caption");
         _loc1_.add("catalog_promo_info","landing.view.catalog.promo.info");
         _loc1_.add("open_page_button","landing.view.catalog.open.page");
         _loc1_.add("catalog_promo_picture_text","landing.view.catalog.promo.picture.text");
         _loc1_.add("catalog_promo_title","landing.view.catalog.promo.title");
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            setCustomLocalization(_loc1_.getKeys()[_loc2_],_loc1_.getValues()[_loc2_],_targetCatalogPageName);
            _loc2_++;
         }
      }
      
      public function refresh() : void
      {
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            _landingView = null;
            if(_container != null)
            {
               _container.dispose();
               _container = null;
            }
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onOpenPageButtonClicked(param1:WindowMouseEvent) : void
      {
         _landingView.catalog.openCatalogPage(_targetCatalogPageName);
      }
      
      private function setCustomLocalization(param1:String, param2:String, param3:String) : void
      {
         var _loc5_:IWindowModel = null;
         var _loc4_:ILocalization = _landingView.localizationManager.getLocalizationRaw(param2 + "." + param3);
         if(_loc4_ != null)
         {
            _loc5_ = _container.findChildByName(param1);
            if(_loc5_ != null)
            {
               _loc5_.caption = "${" + param2 + "." + param3 + "}";
            }
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}

