package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class MeMenuController implements IComponentInterfaceQueue
   {
      public static const USE_GUIDE_TOOL:String = "USE_GUIDE_TOOL";
      
      private var _toolbar:HabboToolbar;
      
      private var UnknownVarFromMeMenuController_ToolbarView_1:ToolbarView;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMeMenuController_MeMenuIconLoader_1:MeMenuIconLoader;
      
      private var UnknownVarFromMeMenuController_Boolean_1:Boolean;
      
      private var UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1:MeMenuSettingsMenuView;
      
      private var _unseenItemCounters:Map;
      
      public function MeMenuController(param1:HabboToolbar, param2:ToolbarView)
      {
         super();
         _unseenItemCounters = new Map();
         _toolbar = param1;
         UnknownVarFromMeMenuController_ToolbarView_1 = param2;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("me_menu_view_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,2) as IWindowController_1;
         UnknownVarFromMeMenuController_MeMenuIconLoader_1 = new MeMenuIconLoader(_toolbar);
         _window.visible = false;
         _window.procedure = windowProcedure;
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc5_:IRegionWindow = null;
         var _loc3_:IStaticBitmapWrapperWindow = null;
         var _loc4_:IHabboNavigator_1 = null;
         var _loc6_:String = null;
         if(param2 is IRegionWindow)
         {
            _loc5_ = param2 as IRegionWindow;
            switch(param1.type)
            {
               case "WME_OVER":
                  _loc3_ = _loc5_.findChildByName(param2.name + "_icon") as IStaticBitmapWrapperWindow;
                  if(_loc3_ != null)
                  {
                     _loc3_.assetUri = "toolbar_memenu_" + param2.name + "_color";
                  }
                  break;
               case "WME_OUT":
                  _loc3_ = _loc5_.findChildByName(param2.name + "_icon") as IStaticBitmapWrapperWindow;
                  if(_loc3_ != null)
                  {
                     _loc3_.assetUri = "toolbar_memenu_" + param2.name + "_white";
                  }
                  break;
               case "WME_CLICK":
                  _window.visible = false;
                  switch(param2.name)
                  {
                     case "profile":
                        _toolbar.connection.send(new GetExtendedProfileMessageComposer(_toolbar.sessionDataManager.userId));
                        break;
                     case "minimail":
                        HabboWebTools.openMinimail("#mail/inbox/");
                        break;
                     case "rooms":
                        _loc4_ = _toolbar.navigator;
                        if(_loc4_ != null)
                        {
                           _loc4_.showOwnRooms();
                        }
                        break;
                     case "talents":
                        _loc6_ = _toolbar.sessionDataManager.currentTalentTrack;
                        _toolbar.connection.send(new GetTalentTrackMessageComposer(_loc6_));
                        break;
                     case "settings":
                        UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 = new MeMenuSettingsMenuView();
                        UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1.init(this,UnknownVarFromMeMenuController_ToolbarView_1);
                        break;
                     case "achievements":
                        _toolbar.questEngine.showAchievements();
                        break;
                     case "guide":
                        _toolbar.toggleWindowVisibility("GUIDE");
                        break;
                     case "clothes":
                        _toolbar.context.createLinkEvent("avatareditor/open");
                  }
            }
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         if(UnknownVarFromMeMenuController_Boolean_1)
         {
            return;
         }
         if(param1.iconId == "HTIE_ICON_MEMENU")
         {
            toggleVisibility();
         }
         else
         {
            _window.visible = false;
            if(UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 != null)
            {
               UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1.dispose();
               UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 = null;
            }
         }
      }
      
      private function setGuideToolVisibility(param1:Boolean) : void
      {
         _window.findChildByName("guide").visible = param1;
         _window.height = param1 ? _window.findChildByName("guide").bottom + 5 : _window.findChildByName("achievements").bottom + 5;
      }
      
      public function toggleVisibility() : void
      {
         var _loc1_:Boolean = false;
         if(UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 != null)
         {
            UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1.dispose();
            UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 = null;
         }
         _window.visible = !_window.visible;
         if(_window.visible)
         {
            if(!toolbar.getBoolean("talent.track.enabled"))
            {
               _window.findChildByName("guide").rectangle = _window.findChildByName("talents").rectangle;
               _window.findChildByName("talents").visible = false;
            }
            if(_toolbar.getBoolean("guides.enabled"))
            {
               _loc1_ = _toolbar.sessionDataManager.isPerkAllowed("USE_GUIDE_TOOL");
               setGuideToolVisibility(_loc1_);
            }
         }
         reposition();
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 != null)
         {
            UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1.dispose();
            UnknownVarFromMeMenuController_MeMenuSettingsMenuView_1 = null;
         }
         UnknownVarFromMeMenuController_MeMenuIconLoader_1.dispose();
         UnknownVarFromMeMenuController_MeMenuIconLoader_1 = null;
         _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
         UnknownVarFromMeMenuController_ToolbarView_1 = null;
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _toolbar == null;
      }
      
      public function get toolbar() : HabboToolbar
      {
         return _toolbar;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function reposition() : void
      {
         _window.x = UnknownVarFromMeMenuController_ToolbarView_1.window.width + 10;
         _window.y = UnknownVarFromMeMenuController_ToolbarView_1.window.bottom - _window.height;
      }
      
      public function getUnseenItemCounter(param1:String) : IWindowController_1
      {
         var _loc2_:IWindowController_1 = null;
         var _loc4_:* = param1;
         if(!_loc4_)
         {
            Logger.log("[Toolbar] Unknown icon type for unseen item counter for iconId: " + param1);
         }
         var _loc3_:IWindowController_1 = _unseenItemCounters.getValue(param1) as IWindowController_1;
         if(!_loc3_)
         {
            _loc3_ = _toolbar.windowManager.createUnseenItemCounter();
            _loc2_ = _window.findChildByName(_loc4_) as IWindowController_1;
            if(_loc2_)
            {
               _loc2_.addChild(_loc3_);
               _loc3_.x = _loc2_.width - _loc3_.width - 5;
               _loc3_.y = 5;
               _unseenItemCounters.add(param1,_loc3_);
            }
         }
         return _loc3_;
      }
      
      public function set achievementCount(param1:int) : void
      {
         setUnseenItemCount("achievements",param1);
      }
      
      public function set minimailCount(param1:int) : void
      {
         setUnseenItemCount("minimail",param1);
      }
      
      public function set newUiEnabled(param1:Boolean) : void
      {
         UnknownVarFromMeMenuController_Boolean_1 = param1;
      }
      
      public function setUnseenItemCount(param1:String, param2:int) : void
      {
         var _loc3_:IWindowController_1 = getUnseenItemCounter(param1);
         if(!_loc3_)
         {
            return;
         }
         if(param2 < 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = " ";
         }
         else if(param2 > 0)
         {
            _loc3_.visible = true;
            _loc3_.findChildByName("count").caption = param2.toString();
         }
         else
         {
            _loc3_.visible = false;
         }
      }
   }
}

