package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpTopicData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.DefaultSanctionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModAlertMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModBanMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModKickMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModMuteMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModTradingLockMessageComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import com.sulake.habbo.utils.StringUtil;
   
   public class ModActionCtrl implements IComponentInterfaceQueue, ITrackedWindow
   {
      private static var UnknownVarFromModActionCtrl_Array_1:Array;
      
      private static var UnknownVarFromModActionCtrl_Map_1:Map;
      
      private var _main:ModerationManager;
      
      private var UnknownVarFromModActionCtrl_Int_1:int;
      
      private var _targetUserName:String;
      
      private var UnknownVarFromModActionCtrl_IssueMessageData_1:IssueMessageData;
      
      private var _frame:IFrameController;
      
      private var _topicDropdown:IDropBaseController_1;
      
      private var UnknownVarFromModActionCtrl_Array_2:Array;
      
      private var _actionTypeDropdown:IDropBaseController_1;
      
      private var UnknownVarFromModActionCtrl_ITextFieldWindow_1:ITextFieldWindow;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromModActionCtrl_UserInfoCtrl_1:UserInfoCtrl;
      
      public function ModActionCtrl(param1:ModerationManager, param2:int, param3:String, param4:IssueMessageData, param5:UserInfoCtrl)
      {
         super();
         _main = param1;
         UnknownVarFromModActionCtrl_Int_1 = param2;
         _targetUserName = param3;
         UnknownVarFromModActionCtrl_IssueMessageData_1 = param4;
         UnknownVarFromModActionCtrl_UserInfoCtrl_1 = param5;
         if(UnknownVarFromModActionCtrl_Array_1 == null)
         {
            UnknownVarFromModActionCtrl_Array_1 = [];
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(1,"Alert",1,1,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(2,"Mute 1h",2,2,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(3,"Ban 18h",3,3,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(4,"Ban 7 days",3,4,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(5,"Ban 30 days (step 1)",3,5,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(7,"Ban 30 days (step 2)",3,7,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(6,"Ban 100 years",3,6,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(106,"Ban avatar-only 100 years",3,6,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(101,"Kick",4,0,0));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(102,"Lock trade 1 week",5,0,168));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(104,"Lock trade permanent",5,0,876000));
            UnknownVarFromModActionCtrl_Array_1.push(new ModActionDefinition(105,"Message",6,0,0));
         }
         _main.issueManager.addModActionView(UnknownVarFromModActionCtrl_Int_1,this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show() : void
      {
         _frame = IFrameController(_main.getXmlWindow("modact_summary"));
         _frame.caption = "Mod action on: " + _targetUserName;
         _frame.findChildByName("custom_sanction_button").procedure = onCustomSanctionButton;
         UnknownVarFromModActionCtrl_ITextFieldWindow_1 = ITextFieldWindow(_frame.findChildByName("message_input"));
         _frame.findChildByName("default_sanction_button").procedure = onDefaultSanctionButton;
         _frame.findChildByName("default_sanction_button").disable();
         initializeTopicToSanctionTypeMapping();
         initializeTopicDropdown();
         initializeActionTypeDropdown();
         var _loc1_:IWindowModel = _frame.findChildByTag("close");
         _loc1_.procedure = onClose;
         _frame.visible = true;
      }
      
      public function getType() : int
      {
         return 7;
      }
      
      public function getId() : String
      {
         return _targetUserName;
      }
      
      public function getFrame() : IFrameController
      {
         return _frame;
      }
      
      private function logEvent(param1:String, param2:String = "") : void
      {
         if(UnknownVarFromModActionCtrl_UserInfoCtrl_1 != null)
         {
            UnknownVarFromModActionCtrl_UserInfoCtrl_1.logEvent(param1,param2);
         }
      }
      
      private function trackAction(param1:String) : void
      {
         if(UnknownVarFromModActionCtrl_UserInfoCtrl_1 != null && !UnknownVarFromModActionCtrl_UserInfoCtrl_1.disposed)
         {
            UnknownVarFromModActionCtrl_UserInfoCtrl_1.trackAction("modAction_" + param1);
         }
      }
      
      private function initializeTopicToSanctionTypeMapping() : void
      {
         var _loc2_:String = null;
         var _loc6_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         if(UnknownVarFromModActionCtrl_Map_1 == null)
         {
            UnknownVarFromModActionCtrl_Map_1 = new Map();
            _loc2_ = _main.getProperty("cfh.topic_id.to.sanction_type_id");
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.split(",");
               _loc3_ = 0;
               while(_loc3_ < _loc6_.length)
               {
                  _loc4_ = _loc6_[_loc3_].split("=");
                  if(_loc4_.length == 2)
                  {
                     _loc1_ = parseInt(String(_loc4_[0]));
                     _loc5_ = parseInt(String(_loc4_[1]));
                     UnknownVarFromModActionCtrl_Map_1.add(_loc1_,_loc5_);
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      private function initializeTopicDropdown() : void
      {
         _topicDropdown = IDropBaseController_1(_frame.findChildByName("cfh_topics"));
         _topicDropdown.addEventListener("WE_SELECTED",refreshSanctionDataForSelectedTopic);
         UnknownVarFromModActionCtrl_Array_2 = [];
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         for each(var _loc4_ in _main.issueManager.getCfhTopics())
         {
            for each(var _loc3_ in _loc4_.topics)
            {
               _loc1_[_loc2_] = "${help.cfh.topic." + _loc3_.id + "}";
               UnknownVarFromModActionCtrl_Array_2[_loc2_] = _loc3_.id;
               _loc2_++;
            }
         }
         _topicDropdown.populate(_loc1_);
      }
      
      private function refreshSanctionDataForSelectedTopic(param1:WindowEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = _topicDropdown.selection;
         var _loc2_:int = int(UnknownVarFromModActionCtrl_Array_2[_loc5_]);
         var _loc3_:int = UnknownVarFromModActionCtrl_Map_1.getValue(_loc2_);
         if(!_loc3_)
         {
            _loc3_ = UnknownVarFromModActionCtrl_Map_1.getValue(0);
         }
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < UnknownVarFromModActionCtrl_Array_1.length)
            {
               if(UnknownVarFromModActionCtrl_Array_1[_loc4_].actionId == _loc3_)
               {
                  _actionTypeDropdown.selection = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
         else
         {
            _actionTypeDropdown.selection = -1;
         }
         _main.issueManager.requestSanctionDataForAccount(UnknownVarFromModActionCtrl_Int_1,_loc2_);
      }
      
      public function showDefaultSanction(param1:int, param2:String) : void
      {
         if(_frame == null || param1 != UnknownVarFromModActionCtrl_Int_1)
         {
            return;
         }
         var _loc3_:ITextWindow = _frame.findChildByName("default_sanction_label") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = param2;
         }
         _frame.findChildByName("default_sanction_button").enable();
      }
      
      private function initializeActionTypeDropdown() : void
      {
         _actionTypeDropdown = IDropBaseController_1(_frame.findChildByName("sanction_type"));
         var _loc1_:Array = [];
         for each(var _loc2_ in UnknownVarFromModActionCtrl_Array_1)
         {
            _loc1_.push(_loc2_.name);
         }
         _actionTypeDropdown.populate(_loc1_);
      }
      
      private function onDefaultSanctionButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         Logger.log("Giving default sanction...");
         trackAction("defaultAction");
         logEvent("action.default");
         var _loc3_:int = int(UnknownVarFromModActionCtrl_Array_2[_topicDropdown.selection]);
         _main.connection.send(new DefaultSanctionMessageComposer(UnknownVarFromModActionCtrl_Int_1,_loc3_,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,getIssueId()));
         dispose();
      }
      
      private function onCustomSanctionButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc6_:* = false;
         var _loc3_:int = 0;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_topicDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a topic.",0,onAlertClose);
            return;
         }
         if(_actionTypeDropdown.selection < 0)
         {
            _main.windowManager.alert("Alert","Please select a sanction.",0,onAlertClose);
            return;
         }
         var _loc4_:int = int(UnknownVarFromModActionCtrl_Array_2[_topicDropdown.selection]);
         var _loc5_:ModActionDefinition;
         switch((_loc5_ = UnknownVarFromModActionCtrl_Array_1[_actionTypeDropdown.selection]).actionType - 1)
         {
            case 0:
               if(!_main.initMsg.alertPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new ModAlertMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc4_,getIssueId()));
               break;
            case 1:
               trackAction("mute");
               _main.connection.send(new ModMuteMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc4_,getIssueId()));
               break;
            case 2:
               if(!_main.initMsg.banPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("ban");
               _loc6_ = _loc5_.actionId == 106;
               _main.connection.send(new ModBanMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc4_,_loc5_.sanctionTypeId,_loc6_,getIssueId()));
               break;
            case 3:
               if(!_main.initMsg.kickPermission)
               {
                  _main.windowManager.alert("Alert","You have insufficient permissions.",0,onAlertClose);
                  return;
               }
               trackAction("kick");
               _main.connection.send(new ModKickMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc4_,getIssueId()));
               break;
            case 4:
               trackAction("trading_lock");
               _loc3_ = _loc5_.actionLengthHours * 60;
               _main.connection.send(new ModTradingLockMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc3_,_loc4_,getIssueId()));
               break;
            case 5:
               if(StringUtil.isEmpty(UnknownVarFromModActionCtrl_ITextFieldWindow_1.text))
               {
                  _main.windowManager.alert("Alert","Please write a message to user.",0,onAlertClose);
                  return;
               }
               trackAction("sendCaution");
               _main.connection.send(new ModMessageMessageComposer(UnknownVarFromModActionCtrl_Int_1,UnknownVarFromModActionCtrl_ITextFieldWindow_1.text,_loc4_,getIssueId()));
               break;
         }
         logEvent("action.custom","unknown");
         dispose();
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("close");
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
         _topicDropdown = null;
         UnknownVarFromModActionCtrl_ITextFieldWindow_1 = null;
         _main.issueManager.removeModActionView(UnknownVarFromModActionCtrl_Int_1);
         _main = null;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function getIssueId() : int
      {
         return UnknownVarFromModActionCtrl_IssueMessageData_1 != null ? UnknownVarFromModActionCtrl_IssueMessageData_1.issueId : -1;
      }
   }
}

