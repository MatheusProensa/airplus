package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class GuildInfoCtrl implements IComponentInterfaceQueue
   {
      private static const GUILD_INFO_NAME:String = "guild_info";
      
      private var _navigator:IHabboNavigator_2;
      
      private var _groupId:int;
      
      public function GuildInfoCtrl(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
      }
      
      public function dispose() : void
      {
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function refresh(param1:IWindowController_1, param2:GuestRoomData, param3:Boolean = false) : void
      {
         var _loc5_:IWindowController_1 = IWindowController_1(param1.findChildByName("guild_info"));
         if(_loc5_ == null)
         {
            _loc5_ = IWindowController_1(_navigator.getXmlWindow("guild_info"));
            _loc5_.name = "guild_info";
            param1.addChild(_loc5_);
            _loc5_.addEventListener("WME_CLICK",onGuildInfo);
         }
         if(param2 == null || param2.habboGroupId < 1)
         {
            _loc5_.visible = false;
            return;
         }
         _loc5_.visible = true;
         _navigator.registerParameter("navigator.guildbase","groupName",param2.groupName);
         _loc5_.findChildByName("guild_base_txt").caption = _navigator.getText("navigator.guildbase");
         var _loc4_:IBadgeImageWidget = IWidgetWindowController(param1.findChildByName("guild_badge")).widget as IBadgeImageWidget;
         _loc4_.badgeId = param2.groupBadgeCode;
         _loc4_.groupId = param2.habboGroupId;
         _groupId = param2.habboGroupId;
      }
      
      private function onGuildInfo(param1:WindowEvent) : void
      {
         _navigator.send(new GetHabboGroupDetailsMessageComposer(_groupId,true));
      }
   }
}

