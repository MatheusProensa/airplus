package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class IssueMessageData implements IComponentInterfaceQueue
   {
      public static const STATE_OPEN:int = 1;
      
      public static const UnknownConstFromIssueMessageData_Int_1:int = 2;
      
      public static const UnknownConstFromIssueMessageData_Int_2:int = 3;
      
      private var _issueId:int;
      
      private var _state:int;
      
      private var _categoryId:int;
      
      private var _reportedCategoryId:int;
      
      private var _issueAgeInMilliseconds:Number;
      
      private var _priority:int;
      
      private var _groupingId:int;
      
      private var _reporterUserId:int;
      
      private var _reporterUserName:String;
      
      private var _reportedUserId:int;
      
      private var _reportedUserName:String;
      
      private var _pickerUserId:int;
      
      private var _pickerUserName:String;
      
      private var _message:String;
      
      private var _chatRecordId:int;
      
      private var _patterns:Array;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromIssueMessageData_Number_1:Number;
      
      public function IssueMessageData(param1:int, param2:int, param3:int, param4:int, param5:Number, param6:int, param7:int, param8:int, param9:String, param10:int, param11:String, param12:int, param13:String, param14:String, param15:int, param16:Array)
      {
         super();
         _issueId = param1;
         _state = param2;
         _categoryId = param3;
         _reportedCategoryId = param4;
         _issueAgeInMilliseconds = param5;
         _priority = param6;
         _groupingId = param7;
         _reporterUserId = param8;
         _reporterUserName = param9;
         _reportedUserId = param10;
         _reportedUserName = param11;
         _pickerUserId = param12;
         _pickerUserName = param13;
         _message = param14;
         _chatRecordId = param15;
         _patterns = param16;
         UnknownVarFromIssueMessageData_Number_1 = getTimer();
      }
      
      public function get issueId() : int
      {
         return _issueId;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get categoryId() : int
      {
         return _categoryId;
      }
      
      public function get reportedCategoryId() : int
      {
         return _reportedCategoryId;
      }
      
      public function get issueAgeInMilliseconds() : Number
      {
         return _issueAgeInMilliseconds;
      }
      
      public function get priority() : int
      {
         return _priority;
      }
      
      public function get groupingId() : int
      {
         return _groupingId;
      }
      
      public function get reporterUserId() : int
      {
         return _reporterUserId;
      }
      
      public function get reporterUserName() : String
      {
         return _reporterUserName;
      }
      
      public function get reportedUserId() : int
      {
         return _reportedUserId;
      }
      
      public function get reportedUserName() : String
      {
         return _reportedUserName;
      }
      
      public function get pickerUserId() : int
      {
         return _pickerUserId;
      }
      
      public function get pickerUserName() : String
      {
         return _pickerUserName;
      }
      
      public function get message() : String
      {
         return _message;
      }
      
      public function get chatRecordId() : int
      {
         return _chatRecordId;
      }
      
      public function get patterns() : Array
      {
         return _patterns;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in _patterns)
         {
            _loc1_.dispose();
         }
         _patterns = [];
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function getOpenTime(param1:int) : String
      {
         var _loc7_:int = (_issueAgeInMilliseconds + param1 - UnknownVarFromIssueMessageData_Number_1) / 1000;
         var _loc5_:int = _loc7_ / 60;
         var _loc6_:int = _loc5_ % 60;
         var _loc4_:int = _loc5_ / 60;
         var _loc2_:String = (_loc6_ < 10 ? "0" : "") + _loc6_;
         var _loc3_:String = (_loc4_ < 10 ? "0" : "") + _loc4_;
         return _loc3_ + ":" + _loc2_;
      }
   }
}

