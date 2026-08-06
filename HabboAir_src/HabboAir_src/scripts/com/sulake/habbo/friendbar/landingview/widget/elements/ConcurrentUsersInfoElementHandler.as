package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.ConcurrentUsersGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetConcurrentUsersRewardMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class ConcurrentUsersInfoElementHandler implements IElementHandler, IComponentInterfaceQueue
   {
      private static const STATE_DISABLED:int = 0;
      
      private static const STATE_ACTIVE:int = 1;
      
      private static const STATE_REDEEM:int = 2;
      
      private static const STATE_REWARDED:int = 3;
      
      private static const UPDATE_INTERVAL_MS:int = 5000;
      
      private var _landingView:HabboLandingView;
      
      private var UnknownVarFromConcurrentUsersInfoElementHandler_GenericWidget_1:GenericWidget;
      
      private var _localizationKey:String;
      
      private var UnknownVarFromConcurrentUsersInfoElementHandler_Int_1:int = -1;
      
      private var UnknownVarFromConcurrentUsersInfoElementHandler_Int_2:int = -1;
      
      private var UnknownVarFromConcurrentUsersInfoElementHandler_Int_3:int = -1;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1:Timer;
      
      private var _disposed:Boolean = false;
      
      public function ConcurrentUsersInfoElementHandler()
      {
         super();
         UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1 = new Timer(5000);
         UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1.addEventListener("timer",onUpdateTimer);
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(_window == null || _window.visible == false || !_landingView.isLandingViewVisible)
         {
            return;
         }
         refresh();
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1)
         {
            UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1.stop();
         }
         UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         UnknownVarFromConcurrentUsersInfoElementHandler_GenericWidget_1 = param4;
         _landingView = param1;
         _window = param2 as IWindowController_1;
         _localizationKey = param3[1];
         _window.findChildByName("users_desc").caption = "${" + _localizationKey + "}";
         var _loc5_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(_window.findChildByName("badge_image"));
         var _loc6_:String = param3.length > 2 ? param3[2] : "ConcurrentUsersReward";
         var _loc7_:String = "${image.library.url}album1584/" + _loc6_ + ".png";
         _loc5_.assetUri = _loc7_;
         updateLocalization();
         param2.procedure = onButton;
         param1.communicationManager.addHabboConnectionMessageEvent(new ConcurrentUsersGoalProgressMessageEvent(onConcurrentUsersGoalProgress));
         UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1.start();
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
      }
      
      private function updateLocalization() : void
      {
         var _loc4_:String = "landing.view.concurrentusers.caption";
         var _loc3_:String = "landing.view.concurrentusers.bodytext";
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userCount",UnknownVarFromConcurrentUsersInfoElementHandler_Int_2.toString());
         _landingView.windowManager.registerLocalizationParameter(_localizationKey,"userGoal",UnknownVarFromConcurrentUsersInfoElementHandler_Int_3.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userCount",UnknownVarFromConcurrentUsersInfoElementHandler_Int_2.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","userGoal",UnknownVarFromConcurrentUsersInfoElementHandler_Int_3.toString());
         _landingView.windowManager.registerLocalizationParameter("landing.view.concurrentusers.bodytext","domain",_landingView.localizationManager.getLocalization("landing.view.hotel.domain","Habbo"));
         switch(UnknownVarFromConcurrentUsersInfoElementHandler_Int_1)
         {
            case 0:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 1:
               _window.findChildByName("state.active").visible = true;
               _window.findChildByName("state.achieved").visible = false;
               break;
            case 2:
               if(UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1)
               {
                  UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.active").enable();
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = true;
               break;
            case 3:
               if(UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1)
               {
                  UnknownVarFromConcurrentUsersInfoElementHandler_Timer_1.stop();
               }
               _loc4_ += ".success";
               _loc3_ += ".success";
               _window.findChildByName("state.active").visible = false;
               _window.findChildByName("state.achieved").visible = true;
               _window.findChildByName("action_button").visible = false;
         }
         var _loc1_:TextElementHandler = UnknownVarFromConcurrentUsersInfoElementHandler_GenericWidget_1.getElementByName("bodytext") as TextElementHandler;
         if(_loc1_)
         {
            _loc1_.localizationKey = _loc3_;
         }
         var _loc2_:TextElementHandler = UnknownVarFromConcurrentUsersInfoElementHandler_GenericWidget_1.getElementByName("caption") as TextElementHandler;
         if(_loc2_)
         {
            _loc2_.localizationKey = _loc4_;
         }
      }
      
      private function onConcurrentUsersGoalProgress(param1:ConcurrentUsersGoalProgressMessageEvent) : void
      {
         UnknownVarFromConcurrentUsersInfoElementHandler_Int_1 = param1.getParser().state;
         UnknownVarFromConcurrentUsersInfoElementHandler_Int_2 = param1.getParser().userCount;
         UnknownVarFromConcurrentUsersInfoElementHandler_Int_3 = param1.getParser().userCountGoal;
         updateLocalization();
      }
      
      private function onButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            onClick();
         }
      }
      
      protected function onClick() : void
      {
         _landingView.send(new GetConcurrentUsersRewardMessageComposer());
         _landingView.send(new GetConcurrentUsersGoalProgressMessageComposer());
         _window.findChildByName("state.active").disable();
      }
   }
}

