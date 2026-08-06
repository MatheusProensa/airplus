package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   
   public class HabboTalentsPromoWidget implements ILandingViewWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      public function HabboTalentsPromoWidget(param1:HabboLandingView)
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
         _container = IWindowController_1(_landingView.getXmlWindow("habbo_talents_promo"));
         _container.findChildByName("go_button").procedure = onGoButton;
         HabboLandingView.positionAfterAndStretch(_container,"title_txt","hdr_line");
      }
      
      public function refresh() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onGoButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            _landingView.tracking.trackTalentTrackOpen(_landingView.sessionDataManager.currentTalentTrack,"landingpagepromo");
            _landingView.send(new GetTalentTrackMessageComposer(_landingView.sessionDataManager.currentTalentTrack));
         }
      }
   }
}

