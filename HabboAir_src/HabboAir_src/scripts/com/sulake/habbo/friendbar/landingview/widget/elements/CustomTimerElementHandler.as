package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.incoming.competition.SecondsUntilMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.competition.GetSecondsUntilMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class CustomTimerElementHandler extends AbstractTimerElementHandler
   {
      private var _timeStr:String;
      
      public function CustomTimerElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _timeStr = param3[6];
         param1.communicationManager.addHabboConnectionMessageEvent(new SecondsUntilMessageEvent(onTime));
      }
      
      override public function refresh() : void
      {
         landingView.send(new GetSecondsUntilMessageComposer(_timeStr));
      }
      
      private function onTime(param1:SecondsUntilMessageEvent) : void
      {
         if(param1.getParser().timeStr == _timeStr)
         {
            setTimer(param1.getParser().secondsUntil);
         }
      }
   }
}

