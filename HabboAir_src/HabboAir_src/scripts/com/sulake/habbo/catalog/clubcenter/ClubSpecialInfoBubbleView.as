package com.sulake.habbo.catalog.clubcenter
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrKickbackData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class ClubSpecialInfoBubbleView
   {
      private static const MARGIN:int = 8;
      
      private var UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1:ScrKickbackData;
      
      private var UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1:HabboClubCenter;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromClubSpecialInfoBubbleView_Timer_1:Timer;
      
      public function ClubSpecialInfoBubbleView(param1:HabboClubCenter, param2:IHabboWindowManagerComponent, param3:ScrKickbackData, param4:IWindowModel)
      {
         super();
         UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1 = param3;
         UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1 = param1;
         _window = param2.buildFromXML(XML(UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.assets.getAssetByName("club_center_special_info_xml").content)) as IWindowController_1;
         if(!_window)
         {
            return;
         }
         _window.procedure = onInput;
         positionWindow(param4);
         setElementText("info_creditsspent",getLocalization("hccenter.breakdown.creditsspent").replace("%credits%",UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.totalCreditsSpent));
         var _loc6_:int = UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage * 100;
         setElementText("info_factor",getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",_loc6_).replace("%multiplier%",UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage));
         _loc6_ = UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage * 100;
         var _loc5_:String = UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.localization.getLocalization("hccenter.breakdown.paydayfactor.percent");
         if(_loc5_ && _loc5_.length > 0)
         {
            _loc5_ = _loc5_.replace("%percent%",_loc6_).replace("%multiplier%",UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage);
         }
         else
         {
            _loc5_ = getLocalization("hccenter.breakdown.paydayfactor").replace("%percent%",UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage);
         }
         setElementText("info_factor",_loc5_);
         setElementText("info_streakbonus",getLocalization("hccenter.breakdown.streakbonus").replace("%credits%",UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.creditRewardForStreakBonus));
         var _loc8_:Number = int((UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.kickbackPercentage * UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.totalCreditsSpent + UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.creditRewardForStreakBonus) * 100) / 100;
         var _loc7_:int = (UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.creditRewardForMonthlySpent + UnknownVarFromClubSpecialInfoBubbleView_ScrKickbackData_1.creditRewardForStreakBonus) * 100 / 100;
         setElementText("info_total",getLocalization("hccenter.breakdown.total").replace("%credits%",_loc7_).replace("%actual%",_loc8_));
         _window.activate();
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1 = new Timer(80,1);
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1.addEventListener("timer",onTimerEvent);
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1.start();
         if(UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage)
         {
            UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage.addEventListener("click",onStageClick);
         }
      }
      
      private function onTimerEvent(param1:TimerEvent) : void
      {
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1.stop();
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1.removeEventListener("timer",onTimerEvent);
         UnknownVarFromClubSpecialInfoBubbleView_Timer_1 = null;
         _window.activate();
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1 && UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage)
         {
            UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage.removeEventListener("click",onStageClick);
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1 = null;
      }
      
      private function onInput(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_DOWN" || !UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1)
         {
            return;
         }
         param1.stopImmediatePropagation();
         var _loc3_:* = param2.name;
         if("special_infolink" === _loc3_)
         {
            UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.openPaydayHelpPage();
         }
         UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.removeBreakdown();
      }
      
      private function onStageClick(param1:MouseEvent) : void
      {
         if(UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1)
         {
            UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.removeBreakdown();
         }
      }
      
      private function positionWindow(param1:IWindowModel) : void
      {
         if(!param1 || !_window || !UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1 || !UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage)
         {
            return;
         }
         var _loc2_:Point = new Point();
         param1.getGlobalPosition(_loc2_);
         if(UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.stage.stageWidth < _loc2_.x + param1.width + _window.width + 8 && _loc2_.x > _window.width + 8)
         {
            (_window as IBubbleController).direction = "right";
            _loc2_.x -= _window.width + 8;
         }
         else
         {
            _loc2_.x += param1.width + 8;
         }
         _loc2_.y += param1.height * 0.5 - _window.height * 0.5;
         _window.position = _loc2_;
      }
      
      private function setElementText(param1:String, param2:String) : void
      {
         if(!_window)
         {
            return;
         }
         var _loc3_:ITextWindow = _window.findChildByName(param1) as ITextWindow;
         if(_loc3_)
         {
            _loc3_.text = param2;
         }
      }
      
      private function getLocalization(param1:String) : String
      {
         if(!UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1 || !UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.localization)
         {
            return "";
         }
         return UnknownVarFromClubSpecialInfoBubbleView_HabboClubCenter_1.localization.getLocalization(param1,param1);
      }
   }
}

