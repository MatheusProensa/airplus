package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAchievementResolutionTrophyDataUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class AchievementResolutionTrophyFurniWidget extends RoomWidgetBase implements ITrophyFurniWidget
   {
      private var _name:String;
      
      private var _date:String;
      
      private var _message:String;
      
      private var _frameTitle:String;
      
      private var _headerColor:uint = TrophyTheme.getHeaderColor(0);
      
      private var _backgroundTheme:int = 0;
      
      private var _backgroundColor:uint = 16777215;
      
      private var _configuration:IComponent_1;
      
      private var UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1:ITrophyView;
      
      private var UnknownVarFromAchievementResolutionTrophyFurniWidget_Int_1:int;
      
      public function AchievementResolutionTrophyFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1)
      {
         super(param1,param2,param3,param4);
         _configuration = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get date() : String
      {
         return _date;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get color() : int
      {
         return _backgroundColor;
      }
      
      public function get frameTitle() : String
      {
         return _frameTitle;
      }
      
      public function get headerColor() : uint
      {
         return _headerColor;
      }
      
      public function get backgroundTheme() : int
      {
         return _backgroundTheme;
      }
      
      public function get configuration() : IComponent_1
      {
         return _configuration;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1)
         {
            UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1.dispose();
            UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1 = null;
         }
         _configuration = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWARTDUE_TROPHY_DATA",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetAchievementResolutionTrophyDataUpdateEvent) : void
      {
         _name = param1.name;
         _date = param1.date;
         _message = param1.message;
         UnknownVarFromAchievementResolutionTrophyFurniWidget_Int_1 = param1.viewType;
         _backgroundTheme = TrophyTheme.normalize(param1.backgroundTheme >= 0 ? param1.backgroundTheme : int(param1.color) - 1);
         _frameTitle = param1.frameTitle != "" ? param1.frameTitle : localizations.getLocalization("widget.furni.trophy.title","Trophy");
         _headerColor = param1.headerColor != 0 ? param1.headerColor : TrophyTheme.getHeaderColor(_backgroundTheme);
         _backgroundColor = param1.backgroundColor != 0 ? param1.backgroundColor : 16777215;
         updateInterface();
      }
      
      private function updateInterface() : void
      {
         if(UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1 != null)
         {
            UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1.dispose();
         }
         var _loc1_:int = UnknownVarFromAchievementResolutionTrophyFurniWidget_Int_1;
         UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1 = new TrophyView(this);
         UnknownVarFromAchievementResolutionTrophyFurniWidget_ITrophyView_1.showInterface();
      }
   }
}

