package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class MessageData
   {
      private var _groupId:int;
      
      private var _messageId:int;
      
      private var _messageIndex:int;
      
      private var _authorId:int;
      
      private var _threadId:int;
      
      private var _creationTime:int;
      
      private var _messageText:String;
      
      private var _authorName:String;
      
      private var _authorFigure:String;
      
      private var _state:int;
      
      private var _adminId:int;
      
      private var _adminName:String;
      
      private var _adminOperationTimeAsSeccondsAgo:int;
      
      private var _authorPostCount:int;
      
      public function MessageData()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : MessageData
      {
         var _loc2_:MessageData = new MessageData();
         _loc2_.messageId = param1.readInteger();
         _loc2_.messageIndex = param1.readInteger();
         _loc2_.authorId = param1.readInteger();
         _loc2_.authorName = param1.readString();
         _loc2_.authorFigure = param1.readString();
         _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
         _loc2_.messageText = param1.readString();
         _loc2_.state = param1.readByte();
         _loc2_.adminId = param1.readInteger();
         _loc2_.adminName = param1.readString();
         _loc2_.adminOperationTimeAsSeccondsAgo = param1.readInteger();
         _loc2_.authorPostCount = param1.readInteger();
         return _loc2_;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function get adminId() : int
      {
         return _adminId;
      }
      
      public function set adminId(param1:int) : void
      {
         _adminId = param1;
      }
      
      public function get adminName() : String
      {
         return _adminName;
      }
      
      public function set adminName(param1:String) : void
      {
         _adminName = param1;
      }
      
      public function get adminOperationTimeAsSeccondsAgo() : int
      {
         return _adminOperationTimeAsSeccondsAgo;
      }
      
      public function set adminOperationTimeAsSeccondsAgo(param1:int) : void
      {
         _adminOperationTimeAsSeccondsAgo = param1;
      }
      
      public function get MessageId() : int
      {
         return _messageId;
      }
      
      public function set MessageId(param1:int) : void
      {
         _messageId = param1;
      }
      
      public function get creationTime() : int
      {
         return _creationTime;
      }
      
      public function set creationTime(param1:int) : void
      {
         _creationTime = param1;
      }
      
      public function get authorName() : String
      {
         return _authorName;
      }
      
      public function set authorName(param1:String) : void
      {
         _authorName = param1;
      }
      
      public function get authorFigure() : String
      {
         return _authorFigure;
      }
      
      public function set authorFigure(param1:String) : void
      {
         _authorFigure = param1;
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function set threadId(param1:int) : void
      {
         _threadId = param1;
      }
      
      public function get messageId() : int
      {
         return _messageId;
      }
      
      public function set messageId(param1:int) : void
      {
         _messageId = param1;
      }
      
      public function get messageIndex() : int
      {
         return _messageIndex;
      }
      
      public function set messageIndex(param1:int) : void
      {
         _messageIndex = param1;
      }
      
      public function set groupID(param1:int) : void
      {
         _groupId = param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get authorId() : int
      {
         return _authorId;
      }
      
      public function set authorId(param1:int) : void
      {
         _authorId = param1;
      }
      
      public function get creationTimeAsSecondsAgo() : int
      {
         return _creationTime;
      }
      
      public function set creationTimeAsSecondsAgo(param1:int) : void
      {
         _creationTime = param1;
      }
      
      public function get messageText() : String
      {
         return _messageText;
      }
      
      public function set messageText(param1:String) : void
      {
         _messageText = param1;
      }
      
      public function get authorPostCount() : int
      {
         return _authorPostCount;
      }
      
      public function set authorPostCount(param1:int) : void
      {
         _authorPostCount = param1;
      }
   }
}

