package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ForumData
   {
      private var _groupId:int;
      
      private var _name:String;
      
      private var _description:String;
      
      private var _icon:String;
      
      private var _totalThreads:int;
      
      private var _leaderboardScore:int;
      
      private var _totalMessages:int;
      
      private var _unreadMessages:int;
      
      private var _lastMessageId:int;
      
      private var _lastMessageAuthorId:int;
      
      private var _lastMessageAuthorName:String;
      
      private var _lastMessageTimeAsSecondsAgo:int;
      
      public function ForumData()
      {
         super();
      }
      
      public static function readFromMessage(param1:IMessageDataWrapper) : ForumData
      {
         return fillFromMessage(new ForumData(),param1);
      }
      
      internal static function fillFromMessage(param1:ForumData, param2:IMessageDataWrapper) : ForumData
      {
         param1._groupId = param2.readInteger();
         param1._name = param2.readString();
         param1._description = param2.readString();
         param1._icon = param2.readString();
         param1._totalThreads = param2.readInteger();
         param1._leaderboardScore = param2.readInteger();
         param1._totalMessages = param2.readInteger();
         param1._unreadMessages = param2.readInteger();
         param1._lastMessageId = param2.readInteger();
         param1._lastMessageAuthorId = param2.readInteger();
         param1._lastMessageAuthorName = param2.readString();
         param1._lastMessageTimeAsSecondsAgo = param2.readInteger();
         return param1;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function get icon() : String
      {
         return _icon;
      }
      
      public function get totalThreads() : int
      {
         return _totalThreads;
      }
      
      public function get leaderboardScore() : int
      {
         return _leaderboardScore;
      }
      
      public function get totalMessages() : int
      {
         return _totalMessages;
      }
      
      public function get unreadMessages() : int
      {
         return _unreadMessages;
      }
      
      public function get lastMessageId() : int
      {
         return _lastMessageId;
      }
      
      public function get lastMessageAuthorId() : int
      {
         return _lastMessageAuthorId;
      }
      
      public function get lastMessageAuthorName() : String
      {
         return _lastMessageAuthorName;
      }
      
      public function get lastMessageTimeAsSecondsAgo() : int
      {
         return _lastMessageTimeAsSecondsAgo;
      }
      
      public function updateFrom(param1:ForumData) : void
      {
         _totalThreads = param1._totalThreads;
         _totalMessages = param1._totalMessages;
         _unreadMessages = param1._unreadMessages;
         _lastMessageAuthorId = param1._lastMessageAuthorId;
         _lastMessageAuthorName = param1._lastMessageAuthorName;
         _lastMessageId = param1._lastMessageId;
         _lastMessageTimeAsSecondsAgo = param1._lastMessageTimeAsSecondsAgo;
      }
      
      public function get lastReadMessageId() : int
      {
         return _totalMessages - _unreadMessages;
      }
      
      public function set lastReadMessageId(param1:int) : void
      {
         _unreadMessages = _totalMessages - param1;
         if(_unreadMessages < 0)
         {
            _unreadMessages = 0;
         }
      }
      
      public function addNewThread(param1:ThreadData) : void
      {
         _lastMessageAuthorId = param1.lastMessageAuthorId;
         _lastMessageAuthorName = param1.lastMessageAuthorName;
         _lastMessageId = param1.lastMessageId;
         _lastMessageTimeAsSecondsAgo = param1.lastMessageTimeAsSecondsAgo;
         _totalThreads++;
         _totalMessages++;
         _unreadMessages = 0;
      }
   }
}

