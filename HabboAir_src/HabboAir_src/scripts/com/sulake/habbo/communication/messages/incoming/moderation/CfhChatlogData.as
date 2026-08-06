package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CfhChatlogData
   {
      private var _callId:int;
      
      private var _callerUserId:int;
      
      private var _reportedUserId:int;
      
      private var _chatRecordId:int;
      
      private var _chatRecord:ChatRecordData;
      
      public function CfhChatlogData(param1:IMessageDataWrapper)
      {
         super();
         _callId = param1.readInteger();
         _callerUserId = param1.readInteger();
         _reportedUserId = param1.readInteger();
         _chatRecordId = param1.readInteger();
         _chatRecord = new ChatRecordData(param1);
      }
      
      public function get callId() : int
      {
         return _callId;
      }
      
      public function get callerUserId() : int
      {
         return _callerUserId;
      }
      
      public function get reportedUserId() : int
      {
         return _reportedUserId;
      }
      
      public function get chatRecordId() : int
      {
         return _chatRecordId;
      }
      
      public function get chatRecord() : ChatRecordData
      {
         return _chatRecord;
      }
   }
}

