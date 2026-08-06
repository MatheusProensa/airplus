package com.sulake.habbo.ui.widget.doorbell
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class DoorbellWidget extends RoomWidgetBase
   {
      private static const MAX_USERS_ON_DOORBELL_LIST:int = 50;
      
      private var _users:Array;
      
      private var UnknownVarFromDoorbellWidget_DoorbellView_1:DoorbellView;
      
      public function DoorbellWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         UnknownVarFromDoorbellWidget_DoorbellView_1 = new DoorbellView(this);
         _users = [];
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return UnknownVarFromDoorbellWidget_DoorbellView_1.mainWindow;
      }
      
      public function get users() : Array
      {
         return _users;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromDoorbellWidget_DoorbellView_1)
         {
            UnknownVarFromDoorbellWidget_DoorbellView_1.dispose();
            UnknownVarFromDoorbellWidget_DoorbellView_1 = null;
         }
         _users = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWDE_RINGING",onDoorbellRinging);
         param1.addEventListener("RWDE_REJECTED",onDoorbellHandled);
         param1.addEventListener("RWDE_ACCEPTED",onDoorbellHandled);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWDE_RINGING",onDoorbellRinging);
         param1.removeEventListener("RWDE_REJECTED",onDoorbellHandled);
         param1.removeEventListener("RWDE_ACCEPTED",onDoorbellHandled);
      }
      
      private function onDoorbellRinging(param1:RoomWidgetDoorbellEvent) : void
      {
         addUser(param1.userName);
      }
      
      private function onDoorbellHandled(param1:RoomWidgetDoorbellEvent) : void
      {
         removeUser(param1.userName);
      }
      
      public function addUser(param1:String) : void
      {
         if(_users.indexOf(param1) != -1)
         {
            return;
         }
         if(_users.length >= 50)
         {
            deny(param1);
            return;
         }
         _users.push(param1);
         UnknownVarFromDoorbellWidget_DoorbellView_1.update();
      }
      
      public function removeUser(param1:String) : void
      {
         var _loc2_:int = int(_users.indexOf(param1));
         if(_loc2_ == -1)
         {
            return;
         }
         _users.splice(_loc2_,1);
         UnknownVarFromDoorbellWidget_DoorbellView_1.update();
      }
      
      public function accept(param1:String) : void
      {
         var _loc2_:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(param1,true);
         messageListener.processWidgetMessage(_loc2_);
         removeUser(param1);
      }
      
      public function deny(param1:String) : void
      {
         var _loc2_:RoomWidgetLetUserInMessage = new RoomWidgetLetUserInMessage(param1,false);
         messageListener.processWidgetMessage(_loc2_);
         removeUser(param1);
      }
      
      public function denyAll() : void
      {
         while(_users.length > 0)
         {
            deny(_users[0]);
         }
      }
   }
}

