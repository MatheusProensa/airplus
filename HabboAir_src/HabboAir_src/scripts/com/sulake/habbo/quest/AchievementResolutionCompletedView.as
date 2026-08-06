package com.sulake.habbo.quest
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class AchievementResolutionCompletedView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromAchievementResolutionCompletedView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromAchievementResolutionCompletedView_String_2:String = "cancel_button";
      
      private var UnknownVarFromAchievementResolutionCompletedView_AchievementsResolutionController_1:AchievementsResolutionController;
      
      private var _window:IFrameController;
      
      private var _badgeCode:String;
      
      private var _stuffCode:String;
      
      public function AchievementResolutionCompletedView(param1:AchievementsResolutionController)
      {
         super();
         UnknownVarFromAchievementResolutionCompletedView_AchievementsResolutionController_1 = param1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromAchievementResolutionCompletedView_AchievementsResolutionController_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromAchievementResolutionCompletedView_AchievementsResolutionController_1 != null;
      }
      
      public function get visible() : Boolean
      {
         if(!_window)
         {
            return false;
         }
         return _window.visible;
      }
      
      public function show(param1:String, param2:String) : void
      {
         if(_window == null)
         {
            createWindow();
         }
         initializeWindow();
         _stuffCode = param1;
         _badgeCode = param2;
         setBadge(_badgeCode);
         _window.visible = true;
      }
      
      private function createWindow() : void
      {
         _window = IFrameController(UnknownVarFromAchievementResolutionCompletedView_AchievementsResolutionController_1.questEngine.getXmlWindow("AchievementResolutionCompleted"));
         addClickListener("header_button_close");
         addClickListener("cancel_button");
      }
      
      private function addClickListener(param1:String) : void
      {
         var _loc2_:IWindowModel = _window.findChildByName(param1);
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onMouseClick);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_button":
               close();
         }
      }
      
      private function initializeWindow() : void
      {
         _window.center();
      }
      
      private function setBadge(param1:String) : void
      {
         var _loc3_:IWidgetWindowController = _window.findChildByName("achievement_badge") as IWidgetWindowController;
         var _loc2_:IBadgeImageWidget = _loc3_.widget as IBadgeImageWidget;
         IStaticBitmapWrapperWindow(IWindowController_1(_loc3_.rootWindow).findChildByName("bitmap")).assetUri = "common_loading_icon";
         _loc2_.badgeId = param1;
         _loc3_.visible = true;
      }
      
      public function close() : void
      {
         if(_window)
         {
            _window.visible = false;
         }
      }
   }
}

