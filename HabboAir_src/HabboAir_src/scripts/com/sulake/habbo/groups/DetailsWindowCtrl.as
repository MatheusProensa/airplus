package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   
   public class DetailsWindowCtrl implements IComponentInterfaceQueue
   {
      private var UnknownVarFromDetailsWindowCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1:GroupDetailsCtrl;
      
      private var _groupId:int;
      
      public function DetailsWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromDetailsWindowCtrl_HabboGroupsManager_1 = param1;
         UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1 = new GroupDetailsCtrl(param1,true);
      }
      
      public function dispose() : void
      {
         UnknownVarFromDetailsWindowCtrl_HabboGroupsManager_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1)
         {
            UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1.dispose();
            UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1 = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromDetailsWindowCtrl_HabboGroupsManager_1 == null;
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && Boolean(_window.visible) && param1 == _groupId;
      }
      
      public function onGroupDetails(param1:HabboGroupDetailsData) : void
      {
         if(_window != null && Boolean(_window.visible) && param1.groupId == _groupId || param1.openDetails)
         {
            _groupId = param1.groupId;
            prepareWindow();
            UnknownVarFromDetailsWindowCtrl_GroupDetailsCtrl_1.onGroupDetails(IWindowController_1(_window.findChildByName("group_cont")),param1);
            if(param1.openDetails)
            {
               _window.visible = true;
               _window.activate();
            }
         }
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IFrameController(UnknownVarFromDetailsWindowCtrl_HabboGroupsManager_1.getXmlWindow("group_info_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         close();
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _groupId = 0;
            _window.visible = false;
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(_groupId == param1)
         {
            close();
         }
      }
   }
}

