package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   
   public class GroupCreatedWindowCtrl implements IComponentInterfaceQueue
   {
      private var UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IFrameController;
      
      private var _groupId:int;
      
      public function GroupCreatedWindowCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1 = param1;
      }
      
      public function dispose() : void
      {
         UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1 == null;
      }
      
      public function show(param1:int) : void
      {
         _groupId = param1;
         prepareWindow();
         _window.visible = true;
         _window.activate();
      }
      
      private function prepareWindow() : void
      {
         if(_window != null)
         {
            return;
         }
         _window = IFrameController(UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1.getXmlWindow("group_created_window"));
         _window.findChildByTag("close").procedure = onClose;
         _window.findChildByName("ok_button").procedure = onClose;
         _window.center();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            close();
            UnknownVarFromGroupCreatedWindowCtrl_HabboGroupsManager_1.send(new GetHabboGroupDetailsMessageComposer(_groupId,false));
         }
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
   }
}

