package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModeratorInitData implements IComponentInterfaceQueue
   {
      private var _messageTemplates:Array;
      
      private var _roomMessageTemplates:Array;
      
      private var _issues:Array;
      
      private var _cfhPermission:Boolean;
      
      private var _chatlogsPermission:Boolean;
      
      private var _alertPermission:Boolean;
      
      private var _kickPermission:Boolean;
      
      private var _banPermission:Boolean;
      
      private var _roomAlertPermission:Boolean;
      
      private var _roomKickPermission:Boolean;
      
      private var _disposed:Boolean;
      
      public function ModeratorInitData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         super();
         var _loc2_:IssueInfoMessageParser = new IssueInfoMessageParser();
         _issues = [];
         _messageTemplates = [];
         _roomMessageTemplates = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_.parse(param1))
            {
               _issues.push(_loc2_.issueData);
            }
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _messageTemplates.push(param1.readString());
            _loc4_++;
         }
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            param1.readString();
            _loc4_++;
         }
         _cfhPermission = param1.readBoolean();
         _chatlogsPermission = param1.readBoolean();
         _alertPermission = param1.readBoolean();
         _kickPermission = param1.readBoolean();
         _banPermission = param1.readBoolean();
         _roomAlertPermission = param1.readBoolean();
         _roomKickPermission = param1.readBoolean();
         _loc3_ = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _roomMessageTemplates.push(param1.readString());
            _loc4_++;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _messageTemplates = null;
         _roomMessageTemplates = null;
         _issues = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get messageTemplates() : Array
      {
         return _messageTemplates;
      }
      
      public function get roomMessageTemplates() : Array
      {
         return _roomMessageTemplates;
      }
      
      public function get issues() : Array
      {
         return _issues;
      }
      
      public function get cfhPermission() : Boolean
      {
         return _cfhPermission;
      }
      
      public function get chatlogsPermission() : Boolean
      {
         return _chatlogsPermission;
      }
      
      public function get alertPermission() : Boolean
      {
         return _alertPermission;
      }
      
      public function get kickPermission() : Boolean
      {
         return _kickPermission;
      }
      
      public function get banPermission() : Boolean
      {
         return _banPermission;
      }
      
      public function get roomAlertPermission() : Boolean
      {
         return _roomAlertPermission;
      }
      
      public function get roomKickPermission() : Boolean
      {
         return _roomKickPermission;
      }
   }
}

