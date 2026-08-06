package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ThreadData
   {
      private var _threadId:int;
      
      private var _threadAuthorId:int;
      
      private var _threadAuthorName:String;
      
      private var _creationTimeAsSecondsAgo:int;
      
      private var _header:String;
      
      private var _nMessages:int;
      
      private var _nUnreadMessages:int;
      
      private var _lastMessageId:int;
      
      private var _lastMessageAuthorId:int;
      
      private var _lastMessageAuthorName:String;
      
      private var _lastMessageTimeAsSecondsAgo:int;
      
      private var _state:int;
      
      private var _adminId:int;
      
      private var _adminName:String;
      
      private var _adminOperationTimeAsSecondsAgo:int;
      
      private var _isSticky:Boolean;
      
      private var _isLocked:Boolean;
      
      public function ThreadData()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : ThreadData
      {
         var _loc2_:ThreadData = new ThreadData();
         _loc2_.threadId = param1.readInteger();
         _loc2_.threadAuthorId = param1.readInteger();
         _loc2_.threadAuthorName = param1.readString();
         _loc2_.header = param1.readString();
         _loc2_.isSticky = param1.readBoolean();
         _loc2_.isLocked = param1.readBoolean();
         _loc2_.creationTimeAsSecondsAgo = param1.readInteger();
         _loc2_.nMessages = param1.readInteger();
         _loc2_.nUnreadMessages = param1.readInteger();
         _loc2_.lastMessageId = param1.readInteger();
         _loc2_.lastMessageAuthorId = param1.readInteger();
         _loc2_.lastMessageAuthorName = param1.readString();
         _loc2_.lastMessageTimeAsSecondsAgo = param1.readInteger();
         _loc2_.state = param1.readByte();
         _loc2_.adminId = param1.readInteger();
         _loc2_.adminName = param1.readString();
         _loc2_.adminOperationTimeAsSecondsAgo = param1.readInteger();
         return _loc2_;
      }
      
      public function get adminOperationTimeAsSecondsAgo() : int
      {
         return _adminOperationTimeAsSecondsAgo;
      }
      
      public function set adminOperationTimeAsSecondsAgo(param1:int) : void
      {
         _adminOperationTimeAsSecondsAgo = param1;
      }
      
      public function get lastMessageTimeAsSecondsAgo() : int
      {
         return _lastMessageTimeAsSecondsAgo;
      }
      
      public function set lastMessageTimeAsSecondsAgo(param1:int) : void
      {
         _lastMessageTimeAsSecondsAgo = param1;
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function set threadId(param1:int) : void
      {
         _threadId = param1;
      }
      
      public function get threadAuthorId() : int
      {
         return _threadAuthorId;
      }
      
      public function set threadAuthorId(param1:int) : void
      {
         _threadAuthorId = param1;
      }
      
      public function get threadAuthorName() : String
      {
         return _threadAuthorName;
      }
      
      public function set threadAuthorName(param1:String) : void
      {
         _threadAuthorName = param1;
      }
      
      public function get creationTimeAsSecondsAgo() : int
      {
         return _creationTimeAsSecondsAgo;
      }
      
      public function set creationTimeAsSecondsAgo(param1:int) : void
      {
         _creationTimeAsSecondsAgo = param1;
      }
      
      public function get header() : String
      {
         return _header;
      }
      
      public function set header(param1:String) : void
      {
         _header = param1;
      }
      
      public function get lastMessageId() : int
      {
         return _lastMessageId;
      }
      
      public function set lastMessageId(param1:int) : void
      {
         _lastMessageId = param1;
      }
      
      public function get lastMessageAuthorId() : int
      {
         return _lastMessageAuthorId;
      }
      
      public function set lastMessageAuthorId(param1:int) : void
      {
         _lastMessageAuthorId = param1;
      }
      
      public function get lastMessageAuthorName() : String
      {
         return _lastMessageAuthorName;
      }
      
      public function set lastMessageAuthorName(param1:String) : void
      {
         _lastMessageAuthorName = param1;
      }
      
      public function get nMessages() : int
      {
         return _nMessages;
      }
      
      public function set nMessages(param1:int) : void
      {
         _nMessages = param1;
      }
      
      public function get nUnreadMessages() : int
      {
         return _nUnreadMessages;
      }
      
      public function set nUnreadMessages(param1:int) : void
      {
         _nUnreadMessages = param1;
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
      
      public function get isSticky() : Boolean
      {
         return _isSticky;
      }
      
      public function set isSticky(param1:Boolean) : void
      {
         _isSticky = param1;
      }
      
      public function get isLocked() : Boolean
      {
         return _isLocked;
      }
      
      public function set isLocked(param1:Boolean) : void
      {
         _isLocked = param1;
      }
   }
}

