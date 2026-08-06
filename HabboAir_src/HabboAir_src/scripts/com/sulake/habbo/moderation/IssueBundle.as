package com.sulake.habbo.moderation
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.moderation.IssueMessageData;
   
   public class IssueBundle
   {
      private var _id:int;
      
      private var _issues:Map;
      
      private var _state:int;
      
      private var _pickerUserId:int = 0;
      
      private var _pickerName:String = "";
      
      private var _reportedUserId:int;
      
      private var UnknownVarFromIssueBundle_Int_1:int;
      
      private var _messageCount:int = 0;
      
      private var _issueAgeInMilliseconds:int = 0;
      
      private var UnknownVarFromIssueBundle_IssueMessageData_1:IssueMessageData = null;
      
      private var _highestPriorityIssue:IssueMessageData = null;
      
      public function IssueBundle(param1:int, param2:IssueMessageData)
      {
         super();
         _id = param1;
         _issues = new Map();
         _state = param2.state;
         _pickerUserId = param2.pickerUserId;
         _pickerName = param2.pickerUserName;
         _reportedUserId = param2.reportedUserId;
         UnknownVarFromIssueBundle_Int_1 = param2.groupingId;
         addIssue(param2);
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get issues() : Array
      {
         return _issues.getValues();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get pickerUserId() : int
      {
         return _pickerUserId;
      }
      
      public function get pickerName() : String
      {
         return _pickerName;
      }
      
      public function matches(param1:IssueMessageData, param2:Boolean = false) : Boolean
      {
         if(UnknownVarFromIssueBundle_Int_1 == 0 || param1.groupingId == 0)
         {
            return false;
         }
         if(UnknownVarFromIssueBundle_Int_1 != param1.groupingId || _reportedUserId != param1.reportedUserId)
         {
            return false;
         }
         if(!param2)
         {
            if(state != param1.state)
            {
               return false;
            }
            if(pickerUserId != param1.pickerUserId)
            {
               return false;
            }
         }
         return true;
      }
      
      public function contains(param1:int) : Boolean
      {
         if(_issues == null)
         {
            return false;
         }
         return _issues.getKeys().indexOf(param1) > -1;
      }
      
      public function updateIssue(param1:IssueMessageData) : void
      {
         removeIssue(param1.issueId);
         addIssue(param1);
      }
      
      private function addIssue(param1:IssueMessageData) : void
      {
         _issues.add(param1.issueId,param1);
         _issueAgeInMilliseconds = param1.issueAgeInMilliseconds;
         if(param1.message != null && param1.message != "")
         {
            _messageCount++;
         }
         if(UnknownVarFromIssueBundle_IssueMessageData_1 == null || param1.issueAgeInMilliseconds > UnknownVarFromIssueBundle_IssueMessageData_1.issueAgeInMilliseconds)
         {
            UnknownVarFromIssueBundle_IssueMessageData_1 = param1;
         }
         _highestPriorityIssue = null;
         getHighestPriorityIssue();
      }
      
      public function removeIssue(param1:int) : IssueMessageData
      {
         var _loc2_:IssueMessageData = _issues.remove(param1) as IssueMessageData;
         if(_loc2_ != null)
         {
            if(_loc2_.message != null && _loc2_.message != "")
            {
               _messageCount--;
            }
            if(UnknownVarFromIssueBundle_IssueMessageData_1 == _loc2_)
            {
               UnknownVarFromIssueBundle_IssueMessageData_1 = null;
            }
            if(_highestPriorityIssue == _loc2_)
            {
               _highestPriorityIssue = null;
            }
         }
         return _loc2_;
      }
      
      public function get highestPriority() : int
      {
         if(_highestPriorityIssue == null)
         {
            getHighestPriorityIssue();
         }
         if(_highestPriorityIssue != null)
         {
            return _highestPriorityIssue.priority;
         }
         return 0;
      }
      
      public function getHighestPriorityIssue() : IssueMessageData
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:int = 0;
         var _loc1_:IssueMessageData = null;
         var _loc5_:Boolean = false;
         if(_highestPriorityIssue == null)
         {
            if(_issues == null || _issues.length < 1)
            {
               return null;
            }
            _loc2_ = 0;
            while(_loc2_ < _issues.length)
            {
               _loc1_ = _issues.getWithIndex(_loc2_);
               _loc5_ = _loc1_.reportedCategoryId > 0 && _loc1_.reportedCategoryId < 100;
               if(_loc5_)
               {
                  if(_loc4_ == null || _loc4_.priority > _loc1_.priority)
                  {
                     _loc4_ = _loc1_;
                  }
               }
               else if(_loc3_ == null || _loc3_.priority > _loc1_.priority)
               {
                  _loc3_ = _loc1_;
               }
               _loc2_++;
            }
            if(_loc4_ != null)
            {
               _highestPriorityIssue = _loc4_;
            }
            else
            {
               _highestPriorityIssue = _loc3_;
            }
         }
         return _highestPriorityIssue;
      }
      
      public function getIssueCount() : int
      {
         if(_issues == null)
         {
            return 0;
         }
         return _issues.length;
      }
      
      public function getIssueIds() : Array
      {
         if(_issues == null)
         {
            return [];
         }
         return _issues.getKeys();
      }
      
      public function get reportedUserId() : int
      {
         return _reportedUserId;
      }
      
      public function getMessageCount() : int
      {
         return _messageCount;
      }
      
      public function get issueAgeInMilliseconds() : int
      {
         return _issueAgeInMilliseconds;
      }
      
      public function getOpenTime(param1:int) : String
      {
         var _loc2_:* = null;
         var _loc3_:* = UnknownVarFromIssueBundle_IssueMessageData_1;
         if(_loc3_ == null)
         {
            for each(_loc2_ in _issues)
            {
               if(_loc3_ == null || _loc2_.issueAgeInMilliseconds > _loc3_.issueAgeInMilliseconds)
               {
                  _loc3_ = _loc2_;
               }
            }
            UnknownVarFromIssueBundle_IssueMessageData_1 = _loc3_;
         }
         if(_loc3_ != null)
         {
            return _loc3_.getOpenTime(param1);
         }
         return "";
      }
   }
}

