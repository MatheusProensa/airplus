package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.catalog.LimitedOfferAppearingNextMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetLimitedOfferAppearingNextComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.session.product.UnknownIHabboSessionProduct1;
   import com.sulake.habbo.window.widgets.ICountdownWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class NextLimitedRareCountdownWidget implements ILandingViewWidget, UnknownIHabboSessionProduct1, ISettingsAwareWidget
   {
      private static const REFRESH_PERIOD_IN_MILLIS:Number = 30000;
      
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromNextLimitedRareCountdownWidget_Int_1:int = 0;
      
      private var UnknownVarFromNextLimitedRareCountdownWidget_Int_2:int;
      
      private var _offerId:int;
      
      private var UnknownVarFromNextLimitedRareCountdownWidget_String_1:String;
      
      private var _lastRequestTime:Date;
      
      private var UnknownVarFromNextLimitedRareCountdownWidget_Timer_1:Timer;
      
      public function NextLimitedRareCountdownWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(UnknownVarFromNextLimitedRareCountdownWidget_Timer_1 != null)
            {
               UnknownVarFromNextLimitedRareCountdownWidget_Timer_1.stop();
               UnknownVarFromNextLimitedRareCountdownWidget_Timer_1 = null;
            }
            _landingView = null;
            _container = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("next_ltd_available"));
         _container.findChildByName("get").procedure = onOpenCatalogButton;
         _container.findChildByName("catalogue_button").procedure = onOpenCatalogButton;
         _container.visible = false;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new LimitedOfferAppearingNextMessageEvent(onLimitedOfferAppearingNextMessage));
         requestLimitedOfferAppearingNextMessage(null);
      }
      
      private function requestLimitedOfferAppearingNextMessage(param1:TimerEvent) : void
      {
         if(!_landingView.getBoolean("next.limited.rare.countdown.widget.disabled"))
         {
            _landingView.communicationManager.connection.send(new GetLimitedOfferAppearingNextComposer());
         }
      }
      
      public function refresh() : void
      {
         if(_lastRequestTime == null || _lastRequestTime.time + 30000 < new Date().time)
         {
            requestLimitedOfferAppearingNextMessage(null);
            _lastRequestTime = new Date();
         }
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function productDataReady() : void
      {
         refreshContent();
      }
      
      private function refreshContent() : void
      {
         if(disposed)
         {
            return;
         }
         if(_landingView.getProductData(UnknownVarFromNextLimitedRareCountdownWidget_String_1,this) != null)
         {
            _container.findChildByName("get").caption = _landingView.getProductData(UnknownVarFromNextLimitedRareCountdownWidget_String_1,this).name;
         }
         if(UnknownVarFromNextLimitedRareCountdownWidget_Int_2 >= 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = true;
            _container.findChildByName("countdown").visible = false;
         }
         else if(UnknownVarFromNextLimitedRareCountdownWidget_Int_1 > 0)
         {
            _container.visible = true;
            _container.findChildByName("get").visible = false;
            _container.findChildByName("countdown").visible = true;
         }
         else
         {
            _container.visible = false;
         }
         refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:IWidgetWindowController = IWidgetWindowController(_container.findChildByName("countdown"));
         var _loc2_:ICountdownWidget = ICountdownWidget(_loc1_.widget);
         _loc2_.seconds = UnknownVarFromNextLimitedRareCountdownWidget_Int_1;
         _loc2_.running = true;
      }
      
      private function setModeSwitchTimer(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(UnknownVarFromNextLimitedRareCountdownWidget_Timer_1 != null)
         {
            UnknownVarFromNextLimitedRareCountdownWidget_Timer_1.stop();
            UnknownVarFromNextLimitedRareCountdownWidget_Timer_1 = null;
         }
         UnknownVarFromNextLimitedRareCountdownWidget_Timer_1 = new Timer((param1 + 1) * 1000,1);
         UnknownVarFromNextLimitedRareCountdownWidget_Timer_1.addEventListener("timer",requestLimitedOfferAppearingNextMessage);
         UnknownVarFromNextLimitedRareCountdownWidget_Timer_1.start();
      }
      
      private function onLimitedOfferAppearingNextMessage(param1:LimitedOfferAppearingNextMessageEvent) : void
      {
         UnknownVarFromNextLimitedRareCountdownWidget_Int_1 = param1.getParser().appearsInSeconds;
         UnknownVarFromNextLimitedRareCountdownWidget_Int_2 = param1.getParser().pageId;
         _offerId = param1.getParser().offerId;
         UnknownVarFromNextLimitedRareCountdownWidget_String_1 = param1.getParser().productType;
         refreshContent();
         setModeSwitchTimer(UnknownVarFromNextLimitedRareCountdownWidget_Int_1);
      }
      
      private function onOpenCatalogButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.catalog.openCatalogPageById(UnknownVarFromNextLimitedRareCountdownWidget_Int_2,_offerId,"NORMAL");
            _landingView.tracking.trackGoogle("landingView","click_goToNextLimitedCatalogPage");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}

