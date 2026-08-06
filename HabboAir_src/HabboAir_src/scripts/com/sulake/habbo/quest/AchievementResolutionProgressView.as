package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   import com.sulake.habbo.window.widgets.ICountdownWidget;
   
   public class AchievementResolutionProgressView implements IComponentInterfaceQueue
   {
      private static const PROGRESSBAR_LEFT:String = "achieved_left";
      
      private static const PROGRESSBAR_MID:String = "achieved_mid";
      
      private static const PROGRESSBAR_RIGHT:String = "achieved_right";
      
      private var UnknownVarFromAchievementResolutionProgressView_Int_1:int;
      
      private var UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1:AchievementsResolutionController;
      
      private var _window:IFrameController;
      
      private var _stuffId:int;
      
      private var _achievementId:int;
      
      private var _badgeCode:String;
      
      public function AchievementResolutionProgressView(param1:AchievementsResolutionController)
      {
         super();
         UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1 == null;
      }
      
      public function get achievementId() : int
      {
         return _achievementId;
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function show(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(param2 != _achievementId)
         {
            initializeWindow();
            _window.center();
         }
         _stuffId = param1;
         _achievementId = param2;
         _badgeCode = param3;
         setProgress(param4,param5);
         setBadge(_badgeCode);
         setLocalizations();
         setCountdown(param6);
         _window.visible = true;
      }
      
      private function setProgress(param1:int, param2:int) : void
      {
         var _loc3_:Number = Math.min(1,param1 / param2);
         if(_loc3_ > 0)
         {
            _window.setVisibleChildren(true,["achieved_left","achieved_mid"]);
            _window.findChildByName("achieved_right").visible = _loc3_ == 1;
         }
         _window.findChildByName("achieved_mid").width = UnknownVarFromAchievementResolutionProgressView_Int_1 * _loc3_;
         UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.questEngine.localization.registerParameter("resolution.progress.progress","progress",param1.toString());
         UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.questEngine.localization.registerParameter("resolution.progress.progress","total",param2.toString());
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc3_:IWidgetWindowController = _window.findChildByName("achievement_badge") as IWidgetWindowController;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowController_1(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1;
         _loc3_.visible = true;
      }
      
      private function setLocalizations() : void
      {
         _window.findChildByName("achievement.name").caption = UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.questEngine.localization.getBadgeName(_badgeCode);
         _window.findChildByName("achievement.desc").caption = UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.questEngine.localization.getBadgeDesc(_badgeCode);
      }
      
      private function setCountdown(param1:int) : void
      {
         var _loc2_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("time_left_widget"));
         var _loc3_:ICountdownWidget = ICountdownWidget(_loc2_.widget);
         _loc3_.seconds = param1;
         _loc3_.running = true;
      }
      
      private function createWindow() : void
      {
         _window = IFrameController(UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.questEngine.getXmlWindow("AchievementResolutionProgress"));
         _window.findChildByTag("close").procedure = onWindowClose;
         _window.findChildByName("reset_button").procedure = onResetButton;
         UnknownVarFromAchievementResolutionProgressView_Int_1 = _window.findChildByName("achieved_mid").width;
      }
      
      private function initializeWindow() : void
      {
         _window.center();
         _window.setVisibleChildren(false,["achieved_left","achieved_mid","achieved_right"]);
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
         }
      }
      
      private function onResetButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromAchievementResolutionProgressView_AchievementsResolutionController_1.resetResolution(_stuffId);
            close();
         }
      }
   }
}

