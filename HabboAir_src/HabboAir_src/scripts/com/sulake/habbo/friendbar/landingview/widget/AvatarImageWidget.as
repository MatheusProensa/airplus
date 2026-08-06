package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class AvatarImageWidget implements ILandingViewWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWidgetWindowController;
      
      private var UnknownVarFromAvatarImageWidget_UserObjectEvent_1:UserObjectEvent;
      
      private var UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1:UserChangeMessageEvent;
      
      public function AvatarImageWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
         UnknownVarFromAvatarImageWidget_UserObjectEvent_1 = new UserObjectEvent(onUserObject);
         UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1 = new UserChangeMessageEvent(onUserChange);
         _landingView.communicationManager.addHabboConnectionMessageEvent(UnknownVarFromAvatarImageWidget_UserObjectEvent_1);
         _landingView.communicationManager.addHabboConnectionMessageEvent(UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1);
         _landingView.avatarEditor.events.addEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromAvatarImageWidget_UserObjectEvent_1 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromAvatarImageWidget_UserObjectEvent_1);
            UnknownVarFromAvatarImageWidget_UserObjectEvent_1 = null;
         }
         if(UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1 != null)
         {
            _landingView.communicationManager.removeHabboConnectionMessageEvent(UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1);
            UnknownVarFromAvatarImageWidget_UserChangeMessageEvent_1 = null;
         }
         if(_landingView != null)
         {
            _landingView.avatarEditor.events.removeEventListener("AVATAR_FIGURE_UPDATED",onAvatarFigureUpdated);
            _landingView = null;
         }
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWidgetWindowController(_landingView.getXmlWindow("avatar_image"));
      }
      
      public function refresh() : void
      {
         refreshAvatarInfo();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         refreshAvatarInfo(param1.getParser().figure);
      }
      
      private function onUserChange(param1:IMessageEvent) : void
      {
         var _loc2_:UserChangeMessageEvent = param1 as UserChangeMessageEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.id == -1)
         {
            refreshAvatarInfo(_loc2_.figure);
         }
      }
      
      private function onAvatarFigureUpdated(param1:AvatarUpdateEvent) : void
      {
         refreshAvatarInfo(param1.figure);
      }
      
      private function refreshAvatarInfo(param1:String = null) : void
      {
         var _loc2_:IAvatarImageWidget = null;
         if(!param1 && _landingView.sessionDataManager)
         {
            param1 = _landingView.sessionDataManager.figure;
         }
         if(_container != null)
         {
            _loc2_ = _container.widget as IAvatarImageWidget;
            if(_loc2_ != null)
            {
               _loc2_.figure = param1;
            }
         }
      }
   }
}

