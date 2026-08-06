package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTrophyDataUpdateEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class TrophyFurniWidget extends RoomWidgetBase implements ITrophyFurniWidget
   {
      public static const VIEW_NIKO_SILVER:int = 10;
      
      public static const VIEW_NIKO_GOLD:int = 20;
      
      private var _name:String;
      
      private var _date:String;
      
      private var _message:String;
      
      private var _backgroundTheme:int = 0;
      
      private var _configuration:IComponent_1;
      
      private var UnknownVarFromTrophyFurniWidget_ITrophyView_1:ITrophyView;
      
      private var UnknownVarFromTrophyFurniWidget_Int_1:int;
      
      public function TrophyFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IComponent_1)
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
         return 16777215;
      }
      
      public function get frameTitle() : String
      {
         return localizations.getLocalization("widget.furni.trophy.title","Trophy");
      }
      
      public function get headerColor() : uint
      {
         return TrophyTheme.getHeaderColor(_backgroundTheme);
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
         if(UnknownVarFromTrophyFurniWidget_ITrophyView_1)
         {
            UnknownVarFromTrophyFurniWidget_ITrophyView_1.dispose();
            UnknownVarFromTrophyFurniWidget_ITrophyView_1 = null;
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
         param1.addEventListener("RWTDUE_TROPHY_DATA",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWTDUE_TROPHY_DATA",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetTrophyDataUpdateEvent) : void
      {
         _name = param1.name;
         _date = param1.date;
         _message = param1.message;
         _backgroundTheme = TrophyTheme.normalize(param1.color - 1);
         UnknownVarFromTrophyFurniWidget_Int_1 = param1.viewType;
         updateInterface();
      }
      
      private function updateInterface() : void
      {
         if(UnknownVarFromTrophyFurniWidget_ITrophyView_1 != null)
         {
            UnknownVarFromTrophyFurniWidget_ITrophyView_1.dispose();
         }
         switch(UnknownVarFromTrophyFurniWidget_Int_1 - 10)
         {
            case 0:
            case 10:
               UnknownVarFromTrophyFurniWidget_ITrophyView_1 = new NikoTrophyView(this,UnknownVarFromTrophyFurniWidget_Int_1);
               break;
            default:
               UnknownVarFromTrophyFurniWidget_ITrophyView_1 = new TrophyView(this);
         }
         UnknownVarFromTrophyFurniWidget_ITrophyView_1.showInterface();
      }
   }
}

