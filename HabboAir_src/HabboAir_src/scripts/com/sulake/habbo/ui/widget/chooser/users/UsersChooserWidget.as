package com.sulake.habbo.ui.widget.chooser.users
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.UserChooserWidgetHandler;
   import com.sulake.habbo.ui.widget.chooser.ChooserItem;
   import com.sulake.habbo.ui.widget.chooser.ChooserWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class UsersChooserWidget extends ChooserWidgetBase
   {
      private const STATE_USER_CHOOSER_CLOSED:int = 0;
      
      private const STATE_USER_CHOOSER_OPEN:int = 1;
      
      private var UnknownVarFromUsersChooserWidget_UsersView_1:UsersView;
      
      private var _items:Array;
      
      public function UsersChooserWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromUsersChooserWidget_UsersView_1 != null)
         {
            UnknownVarFromUsersChooserWidget_UsersView_1.dispose();
            UnknownVarFromUsersChooserWidget_UsersView_1 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.addEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.addEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCCE_USER_CHOOSER_CONTENT",onChooserContent);
         param1.removeEventListener("RWROUE_USER_REMOVED",onUpdateUserChooser);
         param1.removeEventListener("RWROUE_USER_ADDED",onUpdateUserChooser);
      }
      
      private function onChooserContent(param1:RoomWidgetChooserContentEvent) : void
      {
         if(param1 == null || param1.items == null)
         {
            return;
         }
         if(UnknownVarFromUsersChooserWidget_UsersView_1 == null)
         {
            UnknownVarFromUsersChooserWidget_UsersView_1 = new UsersView(this,"${widget.chooser.user.title}");
         }
         _items = [];
         for each(var _loc2_ in param1.items)
         {
            _items.push(_loc2_);
         }
         _items.sortOn(["lowerCaseName","id"],[null,16]);
         UnknownVarFromUsersChooserWidget_UsersView_1.onItemsChanged();
      }
      
      public function get items() : Array
      {
         return _items;
      }
      
      override public function initialize(param1:int = 0) : void
      {
         var _loc2_:RoomWidgetRequestWidgetMessage = null;
         super.initialize(param1);
         if(UserChooserWidgetHandler(_widgetHandler).isChooserDisabled())
         {
            return;
         }
         if(param1 == 1)
         {
            _loc2_ = new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER");
            messageListener.processWidgetMessage(_loc2_);
         }
      }
      
      override public function get state() : int
      {
         if(UnknownVarFromUsersChooserWidget_UsersView_1 != null && UnknownVarFromUsersChooserWidget_UsersView_1.isOpen())
         {
            return 1;
         }
         return 0;
      }
      
      private function onUpdateUserChooser(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var delayedAction:Timer;
         var event:RoomWidgetRoomObjectUpdateEvent = param1;
         if(UnknownVarFromUsersChooserWidget_UsersView_1 == null || !UnknownVarFromUsersChooserWidget_UsersView_1.isOpen())
         {
            return;
         }
         delayedAction = new Timer(100,1);
         delayedAction.addEventListener("timer",function(param1:TimerEvent):void
         {
            if(disposed)
            {
               return;
            }
            messageListener.processWidgetMessage(new RoomWidgetRequestWidgetMessage("RWRWM_USER_CHOOSER"));
         });
         delayedAction.start();
      }
   }
}

