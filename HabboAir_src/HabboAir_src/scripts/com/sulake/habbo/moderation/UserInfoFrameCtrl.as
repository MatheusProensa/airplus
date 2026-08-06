package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   
   public class UserInfoFrameCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private var _main:ModerationManager;
      
      private var UnknownVarFromUserInfoFrameCtrl_Int_1:int;
      
      private var _frame:IFrameController;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1:UserInfoCtrl;
      
      private var UnknownVarFromUserInfoFrameCtrl_IssueMessageData_1:IssueMessageData;
      
      public function UserInfoFrameCtrl(param1:ModerationManager, param2:int, param3:IssueMessageData = null)
      {
         super();
         _main = param1;
         UnknownVarFromUserInfoFrameCtrl_Int_1 = param2;
         UnknownVarFromUserInfoFrameCtrl_IssueMessageData_1 = param3;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = IFrameController(_main.getXmlWindow("user_info_frame"));
         _frame.caption = "User Info";
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1 = new UserInfoCtrl(_frame,_main,UnknownVarFromUserInfoFrameCtrl_IssueMessageData_1,null,true);
         UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1.load(_frame.content,UnknownVarFromUserInfoFrameCtrl_Int_1);
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 1;
      }
      
      public function getId() : String
      {
         return "" + UnknownVarFromUserInfoFrameCtrl_Int_1;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_frame != null)
         {
            _frame.destroy();
            _frame = null;
         }
         if(UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1 != null)
         {
            UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1.dispose();
            UnknownVarFromUserInfoFrameCtrl_UserInfoCtrl_1 = null;
         }
         UnknownVarFromUserInfoFrameCtrl_IssueMessageData_1 = null;
         _main = null;
      }
   }
}

