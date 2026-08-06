package com.sulake.habbo.ui.widget.friendrequest
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFriendRequestUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFriendRequestMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class FriendRequestWidget extends RoomWidgetBase implements IProfiler_1
   {
      private var UnknownVarFromFriendRequestWidget_Component_1:Component;
      
      private var UnknownVarFromFriendRequestWidget_Map_1:Map;
      
      public function FriendRequestWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:Component)
      {
         super(param1,param2,param3,param4);
         UnknownVarFromFriendRequestWidget_Component_1 = param5;
         UnknownVarFromFriendRequestWidget_Map_1 = new Map();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromFriendRequestWidget_Component_1)
         {
            UnknownVarFromFriendRequestWidget_Component_1.removeUpdateReceiver(this);
            UnknownVarFromFriendRequestWidget_Component_1 = null;
         }
         if(UnknownVarFromFriendRequestWidget_Map_1)
         {
            for each(var _loc1_ in UnknownVarFromFriendRequestWidget_Map_1)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            UnknownVarFromFriendRequestWidget_Map_1.dispose();
            UnknownVarFromFriendRequestWidget_Map_1 = null;
         }
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(!param1)
         {
            return;
         }
         param1.addEventListener("RWFRUE_SHOW_FRIEND_REQUEST",eventHandler);
         param1.addEventListener("RWFRUE_HIDE_FRIEND_REQUEST",eventHandler);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWFRUE_SHOW_FRIEND_REQUEST",eventHandler);
         param1.removeEventListener("RWFRUE_HIDE_FRIEND_REQUEST",eventHandler);
      }
      
      private function eventHandler(param1:RoomWidgetFriendRequestUpdateEvent) : void
      {
         if(!param1)
         {
            return;
         }
         switch(param1.type)
         {
            case "RWFRUE_SHOW_FRIEND_REQUEST":
               addRequest(param1.requestId,new FriendRequestDialog(this,param1.requestId,param1.userId,param1.userName));
               break;
            case "RWFRUE_HIDE_FRIEND_REQUEST":
               removeRequest(param1.requestId);
         }
         checkUpdateNeed();
      }
      
      public function checkUpdateNeed() : void
      {
         if(!UnknownVarFromFriendRequestWidget_Component_1)
         {
            return;
         }
         if(UnknownVarFromFriendRequestWidget_Map_1 && UnknownVarFromFriendRequestWidget_Map_1.length > 0)
         {
            UnknownVarFromFriendRequestWidget_Component_1.registerUpdateReceiver(this,10);
         }
         else
         {
            UnknownVarFromFriendRequestWidget_Component_1.removeUpdateReceiver(this);
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:RoomWidgetUserLocationUpdateEvent = null;
         if(!UnknownVarFromFriendRequestWidget_Map_1)
         {
            return;
         }
         for each(var _loc2_ in UnknownVarFromFriendRequestWidget_Map_1)
         {
            if(_loc2_)
            {
               _loc3_ = messageListener.processWidgetMessage(new RoomWidgetGetObjectLocationMessage("RWGOI_MESSAGE_GET_OBJECT_LOCATION",_loc2_.userId,1)) as RoomWidgetUserLocationUpdateEvent;
               if(_loc3_)
               {
                  _loc2_.targetRect = _loc3_.rectangle;
               }
            }
         }
      }
      
      public function acceptRequest(param1:int) : void
      {
         if(!messageListener)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_ACCEPT",param1));
         removeRequest(param1);
      }
      
      public function declineRequest(param1:int) : void
      {
         if(!messageListener)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetFriendRequestMessage("RWFRM_DECLINE",param1));
         removeRequest(param1);
      }
      
      public function ignoreRequest(param1:int) : void
      {
         removeRequest(param1);
      }
      
      private function addRequest(param1:int, param2:FriendRequestDialog) : void
      {
         if(!UnknownVarFromFriendRequestWidget_Map_1 || !param2)
         {
            return;
         }
         UnknownVarFromFriendRequestWidget_Map_1.add(param1,param2);
      }
      
      private function removeRequest(param1:int) : void
      {
         if(!UnknownVarFromFriendRequestWidget_Map_1)
         {
            return;
         }
         var _loc2_:FriendRequestDialog = UnknownVarFromFriendRequestWidget_Map_1.getValue(param1) as FriendRequestDialog;
         if(!_loc2_)
         {
            return;
         }
         UnknownVarFromFriendRequestWidget_Map_1.remove(param1);
         _loc2_.dispose();
         checkUpdateNeed();
      }
      
      public function showProfile(param1:int, param2:String) : void
      {
         messageListener.processWidgetMessage(new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",param1,param2));
      }
   }
}

