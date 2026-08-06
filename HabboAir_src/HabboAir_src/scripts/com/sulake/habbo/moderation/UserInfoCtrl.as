package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.moderation.ModeratorUserInfoData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorUserInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.GetUserChatlogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   
   public class UserInfoCtrl implements IComponentInterfaceQueue, IUserInfoCtrl
   {
      private static const secsInMinute:int = 60;
      
      private static const secsInHour:int = 3600;
      
      private static const secsInDay:int = 86400;
      
      private static const secsInYear:int = 31536000;
      
      private var _callerFrame:IFrameController;
      
      private var _main:ModerationManager;
      
      private var UnknownVarFromUserInfoCtrl_Int_1:int;
      
      private var UnknownVarFromUserInfoCtrl_IssueMessageData_1:IssueMessageData;
      
      private var UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1:ModeratorUserInfoData;
      
      private var UnknownVarFromUserInfoCtrl_IWindowController_1_1:IWindowController_1;
      
      private var _openToolsBelow:Boolean;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromUserInfoCtrl_IssueHandler_1:IssueHandler;
      
      public function UserInfoCtrl(param1:IFrameController, param2:ModerationManager, param3:IssueMessageData, param4:IssueHandler = null, param5:Boolean = false)
      {
         super();
         _callerFrame = param1;
         _main = param2;
         UnknownVarFromUserInfoCtrl_IssueMessageData_1 = param3;
         _openToolsBelow = param5;
         UnknownVarFromUserInfoCtrl_IssueHandler_1 = param4;
      }
      
      public static function formatTime(param1:int) : String
      {
         if(param1 < 2 * 60)
         {
            return param1 + " secs ago";
         }
         if(param1 < 2 * 3600)
         {
            return Math.round(param1 / 60) + " mins ago";
         }
         if(param1 < 2 * 86400)
         {
            return Math.round(param1 / 3600) + " hours ago";
         }
         if(param1 < 2 * 31536000)
         {
            return Math.round(param1 / 86400) + " days ago";
         }
         return Math.round(param1 / 31536000) + " years ago";
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function load(param1:IWindowController_1, param2:int) : void
      {
         UnknownVarFromUserInfoCtrl_IWindowController_1_1 = param1;
         UnknownVarFromUserInfoCtrl_Int_1 = param2;
         UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1 = null;
         refresh();
         _main.messageHandler.addUserInfoListener(this);
         _main.connection.send(new GetModeratorUserInfoMessageComposer(param2));
      }
      
      public function onUserInfo(param1:ModeratorUserInfoData) : void
      {
         if(param1.userId != UnknownVarFromUserInfoCtrl_Int_1)
         {
            return;
         }
         UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1 = param1;
         refresh();
      }
      
      public function refresh() : void
      {
         if(UnknownVarFromUserInfoCtrl_IWindowController_1_1.disposed)
         {
            return;
         }
         var _loc1_:IWindowController_1 = prepare();
         if(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1 == null)
         {
            _loc1_.findChildByName("fields").visible = false;
            _loc1_.findChildByName("loading_txt").visible = true;
            return;
         }
         _loc1_.findChildByName("fields").visible = true;
         _loc1_.findChildByName("loading_txt").visible = false;
         setTxt(_loc1_,"name_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName);
         setTxt(_loc1_,"registered_txt",formatTime(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.registrationAgeInMinutes * 60));
         setTxt(_loc1_,"cfh_count_txt","" + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.cfhCount);
         setAlertTxt(_loc1_,"abusive_cfh_count_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.abusiveCfhCount);
         setAlertTxt(_loc1_,"caution_count_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.cautionCount);
         setAlertTxt(_loc1_,"ban_count_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.banCount);
         setAlertTxt(_loc1_,"trading_lock_count_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.tradingLockCount);
         setTxt(_loc1_,"trading_lock_expiry_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.tradingExpiryDate,"No active lock");
         setTxt(_loc1_,"last_login_txt",formatTime(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.minutesSinceLastLogin * 60));
         setTxt(_loc1_,"online_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.online ? "Yes" : "No");
         setTxt(_loc1_,"last_purchase_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.lastPurchaseDate,"No purchases");
         setTxt(_loc1_,"email_address_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.primaryEmailAddress,"No email found");
         setTxt(_loc1_,"id_bans_txt","" + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.identityRelatedBanCount);
         setTxt(_loc1_,"user_class_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userClassification,"-");
         setTxt(_loc1_,"last_sanction_time_txt",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.lastSanctionTime);
         if(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.sanctionAgeHours <= 48)
         {
            (_loc1_.findChildByName("last_sanction_time_txt") as ITextWindow).textColor = 255 * (48 - UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.sanctionAgeHours) / 48 << 16;
         }
         if(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.primaryEmailAddress == "No identity")
         {
            _loc1_.findChildByName("modaction_but").disable();
         }
         Logger.log("USER: " + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName + ", " + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.banCount + ", " + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.cautionCount);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _main.messageHandler.removeUserInfoListener(this);
         _callerFrame = null;
         _main = null;
         UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1 = null;
         UnknownVarFromUserInfoCtrl_IWindowController_1_1 = null;
      }
      
      private function prepare() : IWindowController_1
      {
         var _loc1_:IWindowController_1 = IWindowController_1(UnknownVarFromUserInfoCtrl_IWindowController_1_1.findChildByName("user_info"));
         if(_loc1_ == null)
         {
            _loc1_ = IWindowController_1(_main.getXmlWindow("user_info"));
            UnknownVarFromUserInfoCtrl_IWindowController_1_1.addChild(_loc1_);
            _main.initMsg.chatlogsPermission ? null : _loc1_.findChildByName("chatlog_but").disable();
            _main.initMsg.alertPermission ? null : _loc1_.findChildByName("message_but").disable();
            _main.initMsg.alertPermission || _main.initMsg.kickPermission || _main.initMsg.banPermission ? null : _loc1_.findChildByName("modaction_but").disable();
         }
         _loc1_.findChildByName("chatlog_but").procedure = onChatlogButton;
         _loc1_.findChildByName("roomvisits_but").procedure = onRoomVisitsButton;
         _loc1_.findChildByName("habboinfotool_but").procedure = onHabboInfoToolButton;
         _loc1_.findChildByName("message_but").procedure = onMessageButton;
         _loc1_.findChildByName("modaction_but").procedure = onModActionButton;
         _loc1_.findChildByName("view_caution_count_txt").procedure = onViewCautions;
         _loc1_.findChildByName("view_ban_count_txt").procedure = onViewBans;
         _loc1_.findChildByName("view_trading_lock_count_txt").procedure = onViewTradingLocks;
         _loc1_.findChildByName("view_id_bans_txt").procedure = onViewIDBans;
         return _loc1_;
      }
      
      private function setAlertTxt(param1:IWindowController_1, param2:String, param3:int) : void
      {
         var _loc5_:IWindowModel = param1.findChildByName(param2);
         var _loc4_:IWindowModel = param1.findChildByName("view_" + param2);
         if(_loc4_ != null)
         {
            _loc4_.visible = param3 > 0;
         }
         _loc5_.caption = "" + param3;
      }
      
      private function setTxt(param1:IWindowController_1, param2:String, param3:String, param4:String = "") : void
      {
         var _loc5_:IWindowModel = ITextWindow(param1.findChildByName(param2));
         if(!param3 || param3.length == 0)
         {
            _loc5_.caption = param4;
         }
         else
         {
            _loc5_.caption = param3;
         }
      }
      
      private function onChatlogButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("chatLog");
         _main.windowTracker.show(new ChatlogCtrl(new GetUserChatlogMessageComposer(UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userId),_main,5,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onRoomVisitsButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _main.windowTracker.show(new RoomVisitsCtrl(_main,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userId),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onHabboInfoToolButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openInfoTool");
         _main.openHkPage("habboinfotool.url",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName);
      }
      
      private function onMessageButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openSendMessage");
         _main.windowTracker.show(new SendMsgsCtrl(_main,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userId,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName,UnknownVarFromUserInfoCtrl_IssueMessageData_1),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onModActionButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("openModAction");
         _main.windowTracker.show(new ModActionCtrl(_main,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userId,UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName,UnknownVarFromUserInfoCtrl_IssueMessageData_1,this),_callerFrame,_openToolsBelow,false,true);
      }
      
      private function onViewCautions(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewCautions");
         showModeratorLog();
      }
      
      private function onViewBans(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewBans");
         showModeratorLog();
      }
      
      private function onViewTradingLocks(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewTradingLocks");
         showModeratorLog();
      }
      
      private function onViewIDBans(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         trackAction("viewIdentityInfo");
         showIdentityInformation();
      }
      
      private function showModeratorLog() : void
      {
         _main.openHkPage("moderatoractionlog.url",UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.userName);
      }
      
      private function showIdentityInformation() : void
      {
         _main.openHkPage("identityinformationtool.url","" + UnknownVarFromUserInfoCtrl_ModeratorUserInfoData_1.identityId);
      }
      
      internal function logEvent(param1:String, param2:String) : void
      {
         if(_main != null)
         {
            _main.logEvent(param1,param2);
         }
      }
      
      internal function trackAction(param1:String) : void
      {
         if(UnknownVarFromUserInfoCtrl_IssueHandler_1 == null || UnknownVarFromUserInfoCtrl_IssueHandler_1.disposed)
         {
            _main.trackGoogle("userInfo_" + param1);
         }
         else if(this == UnknownVarFromUserInfoCtrl_IssueHandler_1.callerUserInfo)
         {
            UnknownVarFromUserInfoCtrl_IssueHandler_1.trackAction("callerUserInfo_" + param1);
         }
         else if(this == UnknownVarFromUserInfoCtrl_IssueHandler_1.reportedUserInfo)
         {
            UnknownVarFromUserInfoCtrl_IssueHandler_1.trackAction("reportedUserInfo_" + param1);
         }
         else
         {
            UnknownVarFromUserInfoCtrl_IssueHandler_1.trackAction("userInfo_" + param1);
         }
      }
   }
}

