package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class MessageHistoryEntry
   {
      private var _senderId:Number;
      
      private var _senderName:String;
      
      private var _senderFigure:String;
      
      private var _content:InstantMessageContentData;
      
      private var _secondsSinceSent:int;
      
      private var _messageId:String;
      
      public function MessageHistoryEntry(param1:IMessageDataWrapper)
      {
         super();
         _senderId = param1.readInteger();
         _senderName = param1.readString();
         _senderFigure = param1.readString();
         _content = InstantMessageContentData.parse(param1);
         _secondsSinceSent = param1.readInteger();
         _messageId = param1.readString();
      }
      
      public function get senderId() : Number
      {
         return _senderId;
      }
      
      public function get senderName() : String
      {
         return _senderName;
      }
      
      public function get senderFigure() : String
      {
         return _senderFigure;
      }
      
      public function get message() : String
      {
         return _content != null ? _content.messageText : "";
      }
      
      public function get messageType() : int
      {
         return _content != null ? _content.messageType : 0;
      }
      
      public function get habbiconId() : int
      {
         return _content != null ? _content.habbiconId : 0;
      }
      
      public function get content() : InstantMessageContentData
      {
         return _content;
      }
      
      public function get secondsSinceSent() : int
      {
         return _secondsSinceSent;
      }
      
      public function get messageId() : String
      {
         return _messageId;
      }
   }
}

