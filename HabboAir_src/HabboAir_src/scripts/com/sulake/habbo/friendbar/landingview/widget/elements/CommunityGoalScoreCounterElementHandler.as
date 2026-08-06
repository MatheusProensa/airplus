package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements1;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.UnknownIHabboFriendbarLandingviewInterfacesElements2;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   import com.sulake.habbo.window.widgets.IRunningNumberWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CommunityGoalScoreCounterElementHandler implements IElementHandler, IComponentInterfaceQueue, UnknownIHabboFriendbarLandingviewInterfacesElements1, ILayoutNameProvider, UnknownIHabboFriendbarLandingviewInterfacesElements2
   {
      private var _landingView:HabboLandingView;
      
      private var _window:IWindowController_1;
      
      private var _isFloating:Boolean;
      
      private var UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1:Timer;
      
      private var UnknownVarFromCommunityGoalScoreCounterElementHandler_Boolean_1:Boolean;
      
      public function CommunityGoalScoreCounterElementHandler()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(_landingView)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
            _landingView = null;
         }
         if(UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1)
         {
            UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1.stop();
            UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1.removeEventListener("timer",onPollTimer);
            UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1 = null;
         }
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         _window = IWindowController_1(param2);
         var _loc7_:int = int(param3[1]);
         var _loc6_:int = int(param3[2]);
         var _loc8_:int = int(param3[3]);
         _isFloating = param3[4] == "true";
         var _loc5_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("running_number_widget"));
         var _loc9_:IRunningNumberWidget = IRunningNumberWidget(_loc5_.widget);
         _loc9_.digits = _loc7_;
         _loc9_.updateFrequency = _loc6_;
         if(_isFloating)
         {
            _window.x = int(param3[5]);
            _window.y = int(param3[6]);
         }
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1 = new Timer(_loc8_);
         UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1.addEventListener("timer",onPollTimer);
      }
      
      public function disable() : void
      {
         UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1.stop();
      }
      
      public function refresh() : void
      {
         _landingView.send(new GetCommunityGoalProgressMessageComposer());
         UnknownVarFromCommunityGoalScoreCounterElementHandler_Boolean_1 = false;
         UnknownVarFromCommunityGoalScoreCounterElementHandler_Timer_1.start();
      }
      
      public function isFloating(param1:Boolean) : Boolean
      {
         return _isFloating;
      }
      
      public function get layoutName() : String
      {
         return "element_community_goal_score";
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         var _loc4_:CommunityGoalData = null;
         var _loc2_:IWidgetWindowController = null;
         var _loc3_:IRunningNumberWidget = null;
         if(_landingView)
         {
            _loc4_ = param1.getParser().data;
            _loc2_ = IWidgetWindowController(_window.findChildByName("running_number_widget"));
            _loc3_ = IRunningNumberWidget(_loc2_.widget);
            if(UnknownVarFromCommunityGoalScoreCounterElementHandler_Boolean_1)
            {
               _loc3_.number = _loc4_.communityTotalScore;
            }
            else
            {
               _loc3_.initialNumber = _loc4_.communityTotalScore;
               UnknownVarFromCommunityGoalScoreCounterElementHandler_Boolean_1 = true;
            }
         }
      }
      
      private function onPollTimer(param1:TimerEvent) : void
      {
         _landingView.send(new GetCommunityGoalProgressMessageComposer());
      }
   }
}

