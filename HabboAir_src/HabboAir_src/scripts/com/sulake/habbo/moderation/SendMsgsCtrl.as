package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   
   public class SendMsgsCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private static const TOPIC_ID_NOT_SELECTED:int = -999;
      
      private var _main:ModerationManager;
      
      private var UnknownVarFromSendMsgsCtrl_Int_1:int;
      
      private var _targetUserName:String;
      
      private var UnknownVarFromSendMsgsCtrl_IssueMessageData_1:IssueMessageData;
      
      private var _frame:IFrameController;
      
      private var _msgSelect:IDropBaseController_1;
      
      private var UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var _placeHolderMessage:Boolean = true;
      
      public function SendMsgsCtrl(param1:ModerationManager, param2:int, param3:String, param4:IssueMessageData)
      {
         super();
         _main = param1;
         UnknownVarFromSendMsgsCtrl_Int_1 = param2;
         _targetUserName = param3;
         UnknownVarFromSendMsgsCtrl_IssueMessageData_1 = param4;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = IFrameController(_main.getXmlWindow("send_msgs"));
         _frame.caption = "Msg To: " + _targetUserName;
         _frame.findChildByName("send_message_but").procedure = onSendMessageButton;
         UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1 = ITextFieldWindow(_frame.findChildByName("message_input"));
         UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1.procedure = onInputClick;
         _msgSelect = IDropBaseController_1(_frame.findChildByName("msgTemplatesSelect"));
         prepareMessageSelection(_msgSelect);
         _msgSelect.procedure = onSelectTemplate;
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 2;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
      
      private function prepareMessageSelection(param1:IDropBaseController_1) : void
      {
         Logger.log("MSG TEMPLATES: " + _main.initMsg.messageTemplates.length);
         param1.populate(_main.initMsg.messageTemplates);
      }
      
      private function onSelectTemplate(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         var _loc3_:String = _main.initMsg.messageTemplates[_msgSelect.selection];
         if(_loc3_ != null)
         {
            _placeHolderMessage = false;
            UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1.text = _loc3_;
         }
      }
      
      private function onSendMessageButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_placeHolderMessage || UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1.text == "")
         {
            _main.windowManager.alert("Alert","You must input a message to the user",0,onAlertClose);
            return;
         }
         Logger.log("Sending message...");
         _main.connection.send(new ModMessageMessageComposer(UnknownVarFromSendMsgsCtrl_Int_1,UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1.text,-999,UnknownVarFromSendMsgsCtrl_IssueMessageData_1 != null ? UnknownVarFromSendMsgsCtrl_IssueMessageData_1.issueId : -1));
         this.dispose();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         dispose();
      }
      
      private function onInputClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_FOCUSED")
         {
            return;
         }
         if(_placeHolderMessage)
         {
            UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1.text = "";
            _placeHolderMessage = false;
         }
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
         _msgSelect = null;
         UnknownVarFromSendMsgsCtrl_ITextFieldWindow_1 = null;
         _main = null;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
   }
}

