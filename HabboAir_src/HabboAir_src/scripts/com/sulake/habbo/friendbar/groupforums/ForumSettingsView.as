package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ExtendedForumData;
   
   public class ForumSettingsView
   {
      private static const UnknownConstFromForumSettingsView_Number_1:Number = 0.5;
      
      private var UnknownVarFromForumSettingsView_GroupForumController_1:GroupForumController;
      
      private var UnknownVarFromForumSettingsView_GroupForumView_1:GroupForumView;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromForumSettingsView_ISelectorWindow_1:ISelectorWindow;
      
      private var UnknownVarFromForumSettingsView_ISelectorWindow_2:ISelectorWindow;
      
      private var UnknownVarFromForumSettingsView_ISelectorWindow_3:ISelectorWindow;
      
      private var UnknownVarFromForumSettingsView_ISelectorWindow_4:ISelectorWindow;
      
      private var UnknownVarFromForumSettingsView_ExtendedForumData_1:ExtendedForumData;
      
      private var UnknownVarFromForumSettingsView_Int_1:int;
      
      private var UnknownVarFromForumSettingsView_Int_2:int;
      
      private var UnknownVarFromForumSettingsView_Int_3:int;
      
      private var UnknownVarFromForumSettingsView_Int_4:int;
      
      public function ForumSettingsView(param1:GroupForumView, param2:int, param3:int, param4:ExtendedForumData)
      {
         super();
         UnknownVarFromForumSettingsView_GroupForumView_1 = param1;
         UnknownVarFromForumSettingsView_GroupForumController_1 = UnknownVarFromForumSettingsView_GroupForumView_1.controller;
         UnknownVarFromForumSettingsView_ExtendedForumData_1 = param4;
         _window = IFrameController(UnknownVarFromForumSettingsView_GroupForumController_1.windowManager.buildFromXML(XML(new HabboFriendBarCom.groupforum_forum_settings_xml())));
         _window.x = param2;
         var _loc5_:int = int(UnknownVarFromForumSettingsView_GroupForumController_1.windowManager.getDesktop(1).width);
         if(_window.x + _window.width > _loc5_)
         {
            _window.x = _loc5_ - _window.width;
         }
         _window.y = param3;
         initControls();
      }
      
      private static function setSelectorState(param1:ISelectorWindow, param2:int, param3:int) : int
      {
         var _loc5_:* = 0;
         var _loc6_:ISelectableWindow = null;
         var _loc4_:IWindowModel = null;
         if(param3 < param2)
         {
            param3 = param2;
         }
         _loc5_ = 0;
         while(_loc5_ < param2)
         {
            _loc6_ = param1.getSelectableByName(String(_loc5_));
            if(_loc6_ != null)
            {
               _loc6_.disable();
               _loc6_.blend = 0.5;
               _loc4_ = IWindowController_1(param1.parent).findChildByName("label" + _loc5_);
               if(_loc4_ != null)
               {
                  _loc4_.blend = 0.5;
               }
            }
            _loc5_++;
         }
         _loc5_ = param2;
         while(_loc5_ < 4)
         {
            _loc6_ = param1.getSelectableByName(String(_loc5_));
            if(_loc6_ != null)
            {
               _loc6_.enable();
               _loc6_.blend = 1;
               _loc4_ = IWindowController_1(param1.parent).findChildByName("label" + _loc5_);
               if(_loc4_ != null)
               {
                  _loc4_.blend = 1;
               }
               if(_loc5_ == param3)
               {
                  param1.setSelected(_loc6_);
               }
            }
            _loc5_++;
         }
         return param3;
      }
      
      private static function getSelectorState(param1:ISelectorWindow) : int
      {
         var _loc2_:ISelectableWindow = param1.getSelected();
         if(_loc2_ == null)
         {
            return 0;
         }
         return int(_loc2_.name);
      }
      
      public function focus(param1:ExtendedForumData) : void
      {
         if(UnknownVarFromForumSettingsView_ExtendedForumData_1 != param1)
         {
            UnknownVarFromForumSettingsView_ExtendedForumData_1 = param1;
            initControls();
         }
         _window.activate();
      }
      
      private function initControls() : void
      {
         var _loc2_:IRegionWindow = GroupForumView.initTopAreaForForum(_window,UnknownVarFromForumSettingsView_ExtendedForumData_1);
         _loc2_.removeEventListener("WME_CLICK",onTopAreaClick);
         _loc2_.addEventListener("WME_CLICK",onTopAreaClick);
         var _loc1_:IWindowModel = _window.findChildByName("cancel_btn");
         _loc1_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc1_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc3_:IWindowModel = _window.findChildByName("header_button_close");
         _loc3_.removeEventListener("WME_CLICK",onCancelButtonClick);
         _loc3_.addEventListener("WME_CLICK",onCancelButtonClick);
         var _loc4_:IWindowModel = _window.findChildByName("ok_btn");
         _loc4_.removeEventListener("WME_CLICK",onPostButtonClick);
         _loc4_.addEventListener("WME_CLICK",onPostButtonClick);
         UnknownVarFromForumSettingsView_ISelectorWindow_1 = ISelectorWindow(_window.findChildByName("read_selector"));
         UnknownVarFromForumSettingsView_ISelectorWindow_1.addEventListener("WME_OVER",onReadSelectorHover);
         addSelectorListeners(UnknownVarFromForumSettingsView_ISelectorWindow_1);
         UnknownVarFromForumSettingsView_ISelectorWindow_2 = ISelectorWindow(_window.findChildByName("post_message_selector"));
         UnknownVarFromForumSettingsView_ISelectorWindow_2.addEventListener("WME_OVER",onPostMessageSelectorHover);
         addSelectorListeners(UnknownVarFromForumSettingsView_ISelectorWindow_2);
         UnknownVarFromForumSettingsView_ISelectorWindow_3 = ISelectorWindow(_window.findChildByName("post_thread_selector"));
         UnknownVarFromForumSettingsView_ISelectorWindow_3.addEventListener("WME_OVER",onPostThreadSelectorHover);
         addSelectorListeners(UnknownVarFromForumSettingsView_ISelectorWindow_3);
         UnknownVarFromForumSettingsView_ISelectorWindow_4 = ISelectorWindow(_window.findChildByName("moderate_selector"));
         UnknownVarFromForumSettingsView_ISelectorWindow_4.addEventListener("WME_OVER",onModerateSelectorHover);
         addSelectorListeners(UnknownVarFromForumSettingsView_ISelectorWindow_4);
         UnknownVarFromForumSettingsView_Int_1 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_1,0,UnknownVarFromForumSettingsView_ExtendedForumData_1.readPermissions);
         UnknownVarFromForumSettingsView_Int_2 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_2,UnknownVarFromForumSettingsView_Int_1,UnknownVarFromForumSettingsView_ExtendedForumData_1.postMessagePermissions);
         UnknownVarFromForumSettingsView_Int_3 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_3,UnknownVarFromForumSettingsView_Int_2,UnknownVarFromForumSettingsView_ExtendedForumData_1.postThreadPermissions);
         UnknownVarFromForumSettingsView_Int_4 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_4,2,UnknownVarFromForumSettingsView_ExtendedForumData_1.moderatePermissions);
      }
      
      public function dispose() : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.forumSettingsView = null;
         _window.dispose();
         _window = null;
      }
      
      private function onTopAreaClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.context.createLinkEvent("group/" + UnknownVarFromForumSettingsView_ExtendedForumData_1.groupId);
      }
      
      private function onPostButtonClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.updateForumSettings(UnknownVarFromForumSettingsView_ExtendedForumData_1.groupId,UnknownVarFromForumSettingsView_Int_1,UnknownVarFromForumSettingsView_Int_2,UnknownVarFromForumSettingsView_Int_3,UnknownVarFromForumSettingsView_Int_4);
         dispose();
      }
      
      private function onCancelButtonClick(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function addSelectorListeners(param1:ISelectorWindow) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ISelectableWindow = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numSelectables)
         {
            _loc3_ = param1.getSelectableAt(_loc2_);
            _loc3_.removeEventListener("WE_SELECTED",onSelectionChanged);
            _loc3_.addEventListener("WE_SELECTED",onSelectionChanged);
            _loc2_++;
         }
      }
      
      private function onSelectionChanged(param1:WindowEvent) : void
      {
         UnknownVarFromForumSettingsView_Int_1 = getSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_1);
         UnknownVarFromForumSettingsView_Int_2 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_2,UnknownVarFromForumSettingsView_Int_1,getSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_2));
         UnknownVarFromForumSettingsView_Int_3 = setSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_3,UnknownVarFromForumSettingsView_Int_2,getSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_3));
         UnknownVarFromForumSettingsView_Int_4 = getSelectorState(UnknownVarFromForumSettingsView_ISelectorWindow_4);
      }
      
      private function onReadSelectorHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.read.seen");
      }
      
      private function onPostMessageSelectorHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.post.seen");
      }
      
      private function onPostThreadSelectorHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.start.thread.seen");
      }
      
      private function onModerateSelectorHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromForumSettingsView_GroupForumController_1.tracking.trackEventLogOncePerSession("InterfaceExplorer","hover","forum.can.moderate.seen");
      }
   }
}

