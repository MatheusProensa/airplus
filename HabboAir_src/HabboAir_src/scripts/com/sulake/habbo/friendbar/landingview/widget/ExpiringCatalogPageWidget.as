package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageWithEarliestExpiryMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetCatalogPageWithEarliestExpiryComposer;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageWithEarliestExpiryMessageParser;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.ICountdownWidget;
   
   public class ExpiringCatalogPageWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var _pageName:String = "";
      
      private var UnknownVarFromExpiringCatalogPageWidget_Int_1:int;
      
      private var UnknownVarFromExpiringCatalogPageWidget_String_1:String;
      
      private var _lastRequestTime:Date;
      
      public function ExpiringCatalogPageWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("expiring_catalog_page"));
         _container.findChildByName("open_catalog_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CatalogPageWithEarliestExpiryMessageEvent(onCatalogPage));
         HabboLandingView.positionAfterAndStretch(_container,"page_expiry_title","hdr_line");
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            _landingView.send(new GetCatalogPageWithEarliestExpiryComposer());
            _lastRequestTime = new Date();
         }
      }
      
      private function refreshContent() : void
      {
         if(_pageName == "")
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         _container.findChildByName("page_header_txt").caption = getText("landing.view.pageexpiry","page." + _pageName,"header");
         _container.findChildByName("page_desc_txt").caption = getText("landing.view.pageexpiry","page." + _pageName,"desc");
         var _loc1_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_container.findChildByName("promo_bitmap"));
         _loc1_.assetUri = "${image.library.url}reception/catalog_teaser_" + _pageName + ".png";
         refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:IWidgetWindowController = IWidgetWindowController(_container.findChildByName("countdown_widget"));
         var _loc2_:ICountdownWidget = ICountdownWidget(_loc1_.widget);
         _loc2_.seconds = UnknownVarFromExpiringCatalogPageWidget_Int_1;
      }
      
      private function getText(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:String = param1 + (useDefaultLocalization ? "" : "." + param2) + "." + param3;
         return "${" + _loc4_ + "}";
      }
      
      private function get useDefaultLocalization() : Boolean
      {
         return false;
      }
      
      private function onOpenCatalogButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPage(_pageName);
            _landingView.tracking.trackGoogle("landingView","click_goToExpiringCatalogPage");
         }
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onCatalogPage(param1:IMessageEvent) : void
      {
         var _loc2_:CatalogPageWithEarliestExpiryMessageParser = CatalogPageWithEarliestExpiryMessageParser(param1.parser);
         _pageName = _loc2_.pageName;
         UnknownVarFromExpiringCatalogPageWidget_Int_1 = _loc2_.secondsToExpiry;
         UnknownVarFromExpiringCatalogPageWidget_String_1 = _loc2_.image;
         refreshContent();
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}

