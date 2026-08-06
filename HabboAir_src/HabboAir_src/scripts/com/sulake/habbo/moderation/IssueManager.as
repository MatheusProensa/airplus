package com.sulake.habbo.moderation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CallForHelpCategoryData;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhSanctionTypeData;
   import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssueDefaultActionMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.CloseIssuesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ModToolSanctionComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.PickIssuesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.moderator.ReleaseIssuesMessageComposer;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   import com.sulake.habbo.utils.StringUtil;
   import flash.events.Event;
   import flash.utils.Timer;
   
   public class IssueManager
   {
      public static const UnknownConstFromIssueManager_String_1:String = "issue_bundle_open";
      
      public static const BUNDLE_MY:String = "issue_bundle_my";
      
      public static const UnknownConstFromIssueManager_String_2:String = "issue_bundle_picked";
      
      public static const PRIORITY_UPDATE_INTERVAL_MS:int = 15000;
      
      public static const RESOLUTION_USELESS:int = 1;
      
      public static const RESOLUTION_RESOLVED:int = 3;
      
      private var _moderationManager:ModerationManager;
      
      private var UnknownVarFromIssueManager_IssueBrowser_1:IssueBrowser;
      
      private var _issues:Map;
      
      private var _bundles:Map;
      
      private var UnknownVarFromIssueManager_Map_1:Map;
      
      private var UnknownVarFromIssueManager_Array_1:Array;
      
      private var UnknownVarFromIssueManager_Array_2:Array;
      
      private var _issueHandlers:Map;
      
      private var UnknownVarFromIssueManager_Map_2:Map;
      
      private var UnknownVarFromIssueManager_Int_1:int = 1;
      
      private var UnknownVarFromIssueManager_Int_2:int;
      
      private var UnknownVarFromIssueManager_Timer_1:Timer;
      
      private var _issueListLimit:int;
      
      private var UnknownVarFromIssueManager_Int_3:int;
      
      private var UnknownVarFromIssueManager_Int_4:int;
      
      private var _windowWidth:int;
      
      private var UnknownVarFromIssueManager_Int_5:int;
      
      private var _cfhTopics:Vector.<CallForHelpCategoryData>;
      
      public function IssueManager(param1:ModerationManager)
      {
         super();
         _moderationManager = param1;
         _issues = new Map();
         _bundles = new Map();
         UnknownVarFromIssueManager_Map_1 = new Map();
         UnknownVarFromIssueManager_IssueBrowser_1 = new IssueBrowser(this,_moderationManager.windowManager,_moderationManager.assets);
         UnknownVarFromIssueManager_Array_1 = [];
         UnknownVarFromIssueManager_Array_2 = [];
         _issueHandlers = new Map();
         UnknownVarFromIssueManager_Map_2 = new Map();
         UnknownVarFromIssueManager_Int_2 = _moderationManager.getInteger("chf.score.updatefactor",60);
         _issueListLimit = _moderationManager.getInteger("max.call_for_help.results",200);
         UnknownVarFromIssueManager_Timer_1 = new Timer(15000,0);
         UnknownVarFromIssueManager_Timer_1.addEventListener("timer",updateIssueBrowser);
         UnknownVarFromIssueManager_Timer_1.start();
      }
      
      public function get issueListLimit() : int
      {
         return _issueListLimit;
      }
      
      public function init() : void
      {
         UnknownVarFromIssueManager_IssueBrowser_1.show();
      }
      
      public function pickBundle(param1:int, param2:String, param3:Boolean = false, param4:int = 0) : void
      {
         var _loc5_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc5_ == null)
         {
            return;
         }
         sendPick(_loc5_.getIssueIds(),param3,param4,param2);
         UnknownVarFromIssueManager_Array_1 = UnknownVarFromIssueManager_Array_1.concat(_loc5_.getIssueIds());
      }
      
      public function autoPick(param1:String, param2:Boolean = false, param3:int = 0) : void
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:Array = _bundles.getValues();
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.state == 1 && (_loc4_ == null || isBundleHigherPriorityOrOlder(_loc6_,_loc4_)))
            {
               _loc4_ = _loc6_;
            }
         }
         if(_loc4_ == null)
         {
            return;
         }
         pickBundle(_loc4_.id,param1,param2,param3);
      }
      
      private function isBundleHigherPriorityOrOlder(param1:IssueBundle, param2:IssueBundle) : Boolean
      {
         if(param1.highestPriority < param2.highestPriority)
         {
            return true;
         }
         return param1.highestPriority == param2.highestPriority && param1.issueAgeInMilliseconds < param2.issueAgeInMilliseconds;
      }
      
      public function releaseAll() : void
      {
         var _loc3_:* = null;
         if(_bundles == null)
         {
            return;
         }
         var _loc1_:int = _moderationManager.sessionDataManager.userId;
         var _loc2_:Array = [];
         for each(_loc3_ in _bundles)
         {
            if(_loc3_.state == 2 && _loc3_.pickerUserId == _loc1_)
            {
               _loc2_ = _loc2_.concat(_loc3_.getIssueIds());
            }
         }
         sendRelease(_loc2_);
      }
      
      public function releaseBundle(param1:int) : void
      {
         if(_bundles == null)
         {
            return;
         }
         var _loc2_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc2_ == null)
         {
            return;
         }
         sendRelease(_loc2_.getIssueIds());
      }
      
      private function sendRelease(param1:Array) : void
      {
         if(param1 == null || param1.length == 0 || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new ReleaseIssuesMessageComposer(param1));
         UnknownVarFromIssueManager_Array_2 = UnknownVarFromIssueManager_Array_2.concat(param1);
      }
      
      public function playSound(param1:IssueMessageData) : void
      {
         if(_issues[param1.issueId] != null)
         {
            return;
         }
         if(UnknownVarFromIssueManager_IssueBrowser_1 == null || !UnknownVarFromIssueManager_IssueBrowser_1.isOpen())
         {
            _moderationManager.soundManager.playSound("HBST_call_for_help");
         }
      }
      
      public function updateIssue(param1:IssueMessageData) : void
      {
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         var _loc7_:* = null;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            return;
         }
         _issues.remove(param1.issueId);
         _issues.add(param1.issueId,param1);
         var _loc6_:int = UnknownVarFromIssueManager_Map_1.getValue(param1.issueId);
         if(_loc6_ != 0)
         {
            _loc9_ = _bundles.getValue(_loc6_) as IssueBundle;
            if(_loc9_ != null)
            {
               if(_loc9_.matches(param1))
               {
                  _loc9_.updateIssue(param1);
               }
               else
               {
                  _loc9_.removeIssue(param1.issueId);
                  if(_loc9_.getIssueCount() == 0)
                  {
                     _bundles.remove(_loc9_.id);
                     removeHandler(_loc9_.id);
                  }
                  UnknownVarFromIssueManager_Map_1.remove(param1.issueId);
                  _loc9_ = null;
               }
            }
         }
         if(param1.state == 3)
         {
            _issues.remove(param1.issueId);
            return;
         }
         if(_loc9_ == null)
         {
            for each(_loc3_ in _bundles)
            {
               if(_loc3_.matches(param1))
               {
                  _loc9_ = _loc3_;
                  _loc9_.updateIssue(param1);
                  UnknownVarFromIssueManager_Map_1.add(param1.issueId,_loc9_.id);
                  break;
               }
            }
         }
         if(_loc9_ == null)
         {
            _loc6_ = UnknownVarFromIssueManager_Int_1++;
            _loc9_ = new IssueBundle(_loc6_,param1);
            UnknownVarFromIssueManager_Map_1.add(param1.issueId,_loc6_);
            _bundles.add(_loc6_,_loc9_);
         }
         if(_loc9_ == null)
         {
            return;
         }
         if(UnknownVarFromIssueManager_Array_1.indexOf(param1.issueId) != -1)
         {
            handleBundle(_loc9_.id);
            _loc2_ = _moderationManager.sessionDataManager.userId;
            if(_loc2_ != param1.pickerUserId)
            {
               if(param1.state == 2)
               {
                  unhandleBundle(_loc9_.id);
               }
            }
         }
         if(param1.state == 1)
         {
            _loc4_ = getBundles("issue_bundle_my");
            _loc5_ = false;
            for each(_loc7_ in _loc4_)
            {
               if(_loc7_.matches(param1,true))
               {
                  _loc5_ = true;
                  break;
               }
            }
            _loc8_ = int(UnknownVarFromIssueManager_Array_2.indexOf(param1.issueId));
            if(_loc8_ == -1 && _loc5_)
            {
               sendPick([param1.issueId],false,0,"matches bundle with issue: " + _loc7_.getHighestPriorityIssue().issueId);
            }
            else
            {
               UnknownVarFromIssueManager_Array_2.splice(_loc8_,1);
            }
         }
         updateHandler(_loc9_.id);
         UnknownVarFromIssueManager_IssueBrowser_1.update();
      }
      
      public function updateIssueBrowser(param1:Event = null) : void
      {
         if(_moderationManager == null)
         {
            return;
         }
         if(UnknownVarFromIssueManager_IssueBrowser_1 != null)
         {
            UnknownVarFromIssueManager_IssueBrowser_1.update();
         }
      }
      
      private function updateHandler(param1:int) : void
      {
         var _loc2_:IIssueHandler = _issueHandlers.getValue(param1);
         if(_loc2_ != null)
         {
            _loc2_.updateIssuesAndMessages();
         }
      }
      
      public function removeHandler(param1:int) : void
      {
         var _loc2_:IIssueHandler = _issueHandlers.remove(param1);
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            _loc2_ = null;
         }
      }
      
      public function addModActionView(param1:int, param2:ModActionCtrl) : void
      {
         UnknownVarFromIssueManager_Map_2.add(param1,param2);
      }
      
      public function removeModActionView(param1:int) : void
      {
         UnknownVarFromIssueManager_Map_2.remove(param1);
      }
      
      public function removeIssue(param1:int) : void
      {
         var _loc3_:IssueBundle = null;
         if(_issues == null)
         {
            return;
         }
         var _loc2_:int = UnknownVarFromIssueManager_Map_1.getValue(param1);
         if(_loc2_ != 0)
         {
            _loc3_ = _bundles.getValue(_loc2_) as IssueBundle;
            if(_loc3_ != null)
            {
               _loc3_.removeIssue(param1);
               if(_loc3_.getIssueCount() == 0)
               {
                  _bundles.remove(_loc3_.id);
               }
            }
         }
         _issues.remove(param1);
         UnknownVarFromIssueManager_IssueBrowser_1.update();
      }
      
      public function getBundles(param1:String) : Array
      {
         var _loc4_:* = null;
         if(_bundles == null)
         {
            return [];
         }
         var _loc3_:Array = [];
         var _loc2_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc4_ in _bundles)
         {
            switch(param1)
            {
               case "issue_bundle_open":
                  if(_loc4_.state == 1)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
               case "issue_bundle_my":
                  if(_loc4_.state == 2 && _loc4_.pickerUserId == _loc2_)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
               case "issue_bundle_picked":
                  if(_loc4_.state == 2 && _loc4_.pickerUserId != _loc2_)
                  {
                     _loc3_.push(_loc4_);
                  }
                  break;
            }
         }
         return _loc3_;
      }
      
      public function handleBundle(param1:int) : void
      {
         var _loc5_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:IIssueHandler = new IssueHandler(_moderationManager,_loc5_,_cfhTopics,UnknownVarFromIssueManager_Int_3,UnknownVarFromIssueManager_Int_4,_windowWidth,UnknownVarFromIssueManager_Int_5);
         _moderationManager.windowTracker.show(_loc4_ as ITrackedWindow,null,false,false,false,true,UnknownVarFromIssueManager_Int_3,UnknownVarFromIssueManager_Int_4,_windowWidth,UnknownVarFromIssueManager_Int_5);
         removeHandler(param1);
         _issueHandlers.add(param1,_loc4_);
         var _loc2_:Array = [];
         for each(var _loc3_ in UnknownVarFromIssueManager_Array_1)
         {
            if(!_loc5_.contains(_loc3_))
            {
               _loc2_ = _loc2_.concat(_loc3_);
            }
         }
         UnknownVarFromIssueManager_Array_1 = _loc2_;
      }
      
      public function unhandleBundle(param1:int) : void
      {
         var _loc3_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:ITrackedWindow = _issueHandlers.remove(param1);
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
      }
      
      public function closeBundle(param1:int, param2:int) : void
      {
         var _loc3_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         sendClose(_loc3_.getIssueIds(),param2);
      }
      
      public function closeDefaultAction(param1:int, param2:int) : void
      {
         var _loc6_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc5_:int = _loc6_.getHighestPriorityIssue().issueId;
         var _loc4_:Array = [];
         for each(var _loc3_ in _loc6_.getIssueIds())
         {
            if(_loc3_ != _loc5_)
            {
               _loc4_.push(_loc3_);
            }
         }
         sendCloseDefaultAction(_loc5_,_loc4_,param2);
      }
      
      public function requestSanctionData(param1:int, param2:int) : void
      {
         var _loc3_:IssueBundle = _bundles.getValue(param1) as IssueBundle;
         if(_loc3_ == null)
         {
            return;
         }
         if(_loc3_.getHighestPriorityIssue() != null)
         {
            _moderationManager.connection.send(new ModToolSanctionComposer(_loc3_.getHighestPriorityIssue().issueId,-1,param2));
         }
      }
      
      public function requestSanctionDataForAccount(param1:int, param2:int) : void
      {
         _moderationManager.connection.send(new ModToolSanctionComposer(-1,param1,param2));
      }
      
      public function updateSanctionData(param1:int, param2:int, param3:CfhSanctionTypeData) : void
      {
         var _loc4_:IIssueHandler = null;
         var _loc5_:ModActionCtrl = null;
         var _loc6_:String = param3.name + (param3.avatarOnly ? " (avatar) " : " ");
         if(param3.sanctionLengthInHours > 24)
         {
            _loc6_ += param3.sanctionLengthInHours / 24 + " days";
         }
         else
         {
            _loc6_ += param3.sanctionLengthInHours + "h";
         }
         if(!StringUtil.isEmpty(param3.tradeLockInfo))
         {
            _loc6_ += " & " + param3.tradeLockInfo;
         }
         if(!StringUtil.isEmpty(param3.machineBanInfo))
         {
            _loc6_ += " & " + param3.machineBanInfo;
         }
         if(param1 > 0)
         {
            for each(var _loc7_ in _bundles)
            {
               if(_loc7_.contains(param1))
               {
                  _loc4_ = _issueHandlers.getValue(_loc7_.id);
                  if(_loc4_ != null)
                  {
                     _loc4_.showDefaultSanction(param2,_loc6_);
                  }
               }
            }
         }
         else
         {
            _loc5_ = UnknownVarFromIssueManager_Map_2.getValue(param2);
            if(_loc5_ != null)
            {
               _loc5_.showDefaultSanction(param2,_loc6_);
            }
         }
      }
      
      private function sendClose(param1:Array, param2:int) : void
      {
         if(param1 == null || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new CloseIssuesMessageComposer(param1,param2));
      }
      
      private function sendPick(param1:Array, param2:Boolean, param3:int, param4:String) : void
      {
         if(param1 == null || _moderationManager == null || _moderationManager.connection == null)
         {
            return;
         }
         _moderationManager.connection.send(new PickIssuesMessageComposer(param1,param2,param3,param4));
      }
      
      private function sendCloseDefaultAction(param1:int, param2:Array, param3:int) : void
      {
         _moderationManager.connection.send(new CloseIssueDefaultActionMessageComposer(param1,param2,param3));
      }
      
      public function autoHandle(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc4_:Array = _bundles.getValues();
         var _loc2_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.state == 2 && _loc5_.pickerUserId == _loc2_ && _loc5_.id != param1 && (_loc3_ == null || _loc5_.highestPriority < _loc3_.highestPriority))
            {
               _loc3_ = _loc5_;
            }
         }
         if(_loc3_ == null)
         {
            autoPick("issue manager pick next");
            return;
         }
         handleBundle(_loc3_.id);
      }
      
      public function issuePickFailed(param1:Array) : Boolean
      {
         var _loc6_:* = null;
         var _loc4_:int = 0;
         var _loc10_:String = null;
         var _loc2_:int = 0;
         var _loc13_:* = null;
         var _loc5_:* = null;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:IIssueHandler = null;
         if(!param1)
         {
            return false;
         }
         var _loc7_:Boolean = false;
         var _loc9_:int = _moderationManager.sessionDataManager.userId;
         for each(_loc6_ in param1)
         {
            _loc4_ = int(_loc6_.issueId);
            _loc10_ = _loc6_.pickerUserName;
            _loc2_ = _loc6_.pickerUserId;
            if(_loc2_ != -1 && _loc2_ != _loc9_)
            {
               _loc7_ = true;
            }
            _loc13_ = null;
            for each(_loc5_ in _bundles)
            {
               _loc11_ = _loc5_.getIssueIds();
               if(_loc11_ != null)
               {
                  for each(_loc12_ in _loc11_)
                  {
                     if(_loc4_ == _loc12_)
                     {
                        _loc13_ = _loc5_;
                        break;
                     }
                  }
               }
            }
            if(_loc13_ != null)
            {
               _loc8_ = _loc13_.id;
               _loc3_ = _issueHandlers.getValue(_loc8_);
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               releaseBundle(_loc8_);
            }
         }
         return _loc7_;
      }
      
      public function setToolPreferences(param1:int, param2:int, param3:int, param4:int) : void
      {
         UnknownVarFromIssueManager_Int_3 = param1;
         UnknownVarFromIssueManager_Int_4 = param2;
         UnknownVarFromIssueManager_Int_5 = param3;
         _windowWidth = param4;
      }
      
      public function setCfhTopics(param1:Vector.<CallForHelpCategoryData>) : void
      {
         this._cfhTopics = param1;
      }
      
      public function getCfhTopics() : Vector.<CallForHelpCategoryData>
      {
         return _cfhTopics;
      }
   }
}

