package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.WiredRewardResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.GetIsBadgeRequestFulfilledComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class RequestBadgeButtonElementHandler extends AbstractButtonElementHandler implements UnknownIHabboFriendbarLandingviewInterfacesElements1
   {
      private var _badgeRequestCode:String;
      
      private var _isFloating:Boolean = true;
      
      public function RequestBadgeButtonElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _badgeRequestCode = param3[2];
         param2.x = int(param3[3]);
         param2.y = int(param3[4]);
         if(param3.length > 5)
         {
            _isFloating = param3[5] == "true";
         }
         param1.communicationManager.addHabboConnectionMessageEvent(new IsBadgeRequestFulfilledEvent(onInfo));
         param1.communicationManager.addHabboConnectionMessageEvent(new WiredRewardResultMessageEvent(onReward));
      }
      
      override protected function onClick() : void
      {
         landingView.requestBadge(_badgeRequestCode);
         landingView.tracking.trackGoogle("landingView","click_requestbadge_" + _badgeRequestCode);
      }
      
      override public function refresh() : void
      {
         super.refresh();
         landingView.send(new GetIsBadgeRequestFulfilledComposer(_badgeRequestCode));
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return _isFloating;
      }
      
      private function onInfo(param1:IsBadgeRequestFulfilledEvent) : void
      {
         if(param1.getParser().requestCode == _badgeRequestCode)
         {
            window.visible = !param1.getParser().fulfilled;
         }
      }
      
      private function onReward(param1:WiredRewardResultMessageEvent) : void
      {
         if(window)
         {
            landingView.send(new GetIsBadgeRequestFulfilledComposer(_badgeRequestCode));
         }
      }
   }
}

