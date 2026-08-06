package com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.groups.IHabboGroupsManager;
   import com.sulake.habbo.ui.widget.contextmenu.UnknownIHabboUiWidgetContextmenu1;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class GuildFurnitureContextMenuView extends FurnitureContextInfoView
   {
      protected var UnknownVarFromGuildFurnitureContextMenuView_IHabboGroupsManager_1:IHabboGroupsManager;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      public var _guildId:int = -1;
      
      public var _guildHomeRoomId:int = -1;
      
      public var _userIsMember:Boolean = false;
      
      public var _guildHasReadableForum:Boolean = false;
      
      public function GuildFurnitureContextMenuView(param1:UnknownIHabboUiWidgetContextmenu1, param2:IHabboGroupsManager, param3:IHabboWindowManagerComponent)
      {
         super(param1);
         UnknownVarFromContextInfoView_Boolean_5 = false;
         UnknownVarFromGuildFurnitureContextMenuView_IHabboGroupsManager_1 = param2;
         _windowManager = param3;
      }
      
      override public function dispose() : void
      {
         UnknownVarFromGuildFurnitureContextMenuView_IHabboGroupsManager_1 = null;
         _windowManager = null;
         super.dispose();
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         var _loc2_:IRegionWindow = null;
         if(!UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets || !UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager)
         {
            return;
         }
         if(UnknownVarFromContextInfoView_Boolean_1)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.assets.getAssetByName("guild_furni_menu")).content as XML;
               _window = UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.windowManager.buildFromXML(_loc1_,0) as IWindowController_1;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            UnknownVarFromButtonMenuView_IItemListWindow_1 = _window.findChildByName("buttons") as IItemListWindow;
            UnknownVarFromButtonMenuView_IItemListWindow_1.procedure = buttonEventProc;
            _loc2_ = _window.findChildByName("profile_link") as IRegionWindow;
            if(_loc2_)
            {
               _loc2_.procedure = buttonEventProc;
               _loc2_.toolTipCaption = widget.localizations.getLocalization("infostand.profile.link.tooltip","Click to view profile");
               _loc2_.toolTipDelay = 100;
            }
            _window.findChildByName("name").caption = UnknownVarFromFurnitureContextInfoView_String_1;
            _window.visible = false;
            activeView = _window;
            updateButtons();
            UnknownVarFromContextInfoView_Boolean_2 = false;
         }
      }
      
      protected function updateButtons() : void
      {
         if(!_window || !UnknownVarFromButtonMenuView_IItemListWindow_1)
         {
            return;
         }
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = false;
         showButton("join",!_userIsMember,true);
         showButton("open_forum",_guildHasReadableForum,true);
         UnknownVarFromButtonMenuView_IItemListWindow_1.autoArrangeItems = true;
         UnknownVarFromButtonMenuView_IItemListWindow_1.visible = true;
      }
      
      override protected function buttonEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:Component = null;
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               switch(param2.parent.name)
               {
                  case "join":
                     widget.handler.sendJoinToGroupMessage(_guildId);
                     showButton("join",!_userIsMember,false);
                     break;
                  case "home_room":
                     widget.handler.sendGoToHomeRoomMessage(_guildHomeRoomId);
                     break;
                  case "open_forum":
                     if(widget != null && widget.roomEngine != null)
                     {
                        _loc4_ = widget.roomEngine as Component;
                        if(_loc4_.context != null)
                        {
                           _loc4_.context.createLinkEvent("groupforum/" + _guildId);
                           break;
                        }
                     }
               }
            }
            if(param2.name == "profile_link")
            {
               UnknownVarFromGuildFurnitureContextMenuView_IHabboGroupsManager_1.openGroupInfo(_guildId);
            }
            _loc3_ = true;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1.removeView(this,false);
         }
      }
      
      private function get widget() : FurnitureContextMenuWidget
      {
         return UnknownVarFromContextInfoView_UnknownIHabboUiWidgetContextmenu1_1 as FurnitureContextMenuWidget;
      }
   }
}

